

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/messages/chat/bloc/chatBlocs.dart';
import 'package:learningapplication/Pages/messages/chat/bloc/chatEvents.dart';
import 'package:learningapplication/common/entities/msg.dart';
import 'package:learningapplication/common/entities/msgcontent.dart';
import 'package:learningapplication/common/values/constant.dart';

import '../../../common/entities/User.dart';
import '../../../global.dart';

class ChatController {
  late BuildContext context;
  ChatController({required this.context});
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  User? userProfile = Global.storageservice.getUserProfile();
  final db = FirebaseFirestore.instance;
  late var docID;
  late var listener;
  bool isLoadingMore = true;

  /////////////////////////////////////////////////////////////////////

  void init(){
  final data = ModalRoute.of(context)!.settings.arguments as Map;
  docID = data["doc-id"];
  clearMsgNum(docID);
  chatSnapshots();
  }

  //////////////////////////////////////////////////////////////////////
  clearMsgNum(String docID) async{
  var messageRes = await db.collection('message').doc(docID).
  withConverter(
      fromFirestore: Msg.fromFirestore,
      toFirestore: (Msg msg ,options)=>msg.toFirestore()).get();
  if(messageRes.data()!=null) {
      var item = messageRes.data()!;
      int to_msg_num =  item.to_msg_num==null?0:item.to_msg_num!;
      int from_msg_num =  item.from_msg_num==null?0:item.from_msg_num!;
      if(item.from_token==Global.storageservice.getUserToken()) {
        to_msg_num = 0;
      }
        else {
        from_msg_num = 0;
      }
      await db.collection("message").doc(docID).update({
        "to_msg_num" : to_msg_num,
        "from_msg_num":from_msg_num
      });
    }
  }
///////////////////////////////////////////////////////////////////////
  void dispose(){
    textEditingController.dispose();
    clearMsgNum(docID);
  }

  ////////////////////////////////////////////////////////////////////

  void chatSnapshots(){

    context.read<ChatBlocs>().add(TriggerClearMsgList());
    var messages = db.collection("message").doc(docID).collection("msgList")
        .withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msg , options)=>msg.toFirestore()
    ).orderBy("addtime",descending:true).limit(15);

    listener=messages.snapshots().listen((event) {
      
      List<Msgcontent> tempMsgList = <Msgcontent>[];
      for(var change in event.docChanges)
        {
          switch(change.type){
            case DocumentChangeType.added:
              print("added ...:${change.doc.data()}");
              if(change.doc.data()!=null){
                tempMsgList.add(change.doc.data()!);
              }
              break;
            case DocumentChangeType.modified:
             break;
            case DocumentChangeType.removed:
                // TODO: Handle this case.
          }
        }
      //last message

      for (var element in tempMsgList.reversed)
        {
         print(element.content);
        context.read<ChatBlocs>().add(TriggerMsgContentList(element));
        }

      scrollController.addListener(() {
       if((scrollController.offset+10)>(scrollController.position.maxScrollExtent)){
           if(isLoadingMore){
             context.read<ChatBlocs>().add(const TriggerLoadMsgData(true));
             isLoadingMore=false;
             asyncLoadMoreData();
             context.read<ChatBlocs>().add(const TriggerLoadMsgData(false));
           }
       }
      });
    });
  }

  ////////////////////////////////////////////////////////////////////

  Future<void> asyncLoadMoreData() async {
    var state = context.read<ChatBlocs>().state;
    var moreMessages = await db.collection("message")
    .doc(docID).collection("msgList")
    .withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msg , options)=>msg.toFirestore()
    ).orderBy("addtime",descending: true)
        .where("addtime",isLessThan:state.msgcontentList.last.addtime)
    .limit(10)
    .get();

    if(moreMessages.docs.isNotEmpty){
      moreMessages.docs.forEach((element) {
        var data = element.data();
        context.read<ChatBlocs>().add(TriggerAddMsgContent(data));
        print(data);
      });
      SchedulerBinding.instance.addPostFrameCallback((_) {
        isLoadingMore = true ;
      });
    }
  }

  ///////////////////////////////////////////////////////////////////

  sendMessage() async{
    if(textEditingController.text.isEmpty){

    }
    else
      {
        String sendContent = textEditingController.text.trim();
        textEditingController.clear();
        final content =  Msgcontent(
          token: Global.storageservice.getUserToken(),
          content: sendContent,
          type: "text",
          addtime: Timestamp.now()
        );
        print(docID);
        await db.collection("message").doc(docID).collection("msgList").withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg ,options )=>msg.toFirestore()
        ).add(content).then((DocumentReference doc) {
          print("${doc.id}");
        });

        var messageRes =  await db.collection("message").doc(docID).withConverter
          (fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg ,options )=>msg.toFirestore()
        ).get();

        if(messageRes.data()!=null){
          var item = messageRes.data()!;

          int to_msg_num = item.to_msg_num==null?0:item.to_msg_num!;
          int from_msg_num = item.from_msg_num==null?0:item.from_msg_num!;

          if(item.from_token == Global.storageservice.getUserToken()){
            from_msg_num = from_msg_num + 1;
          }
          else{
            to_msg_num = to_msg_num + 1;
          }

          await db.collection("message").doc(docID).update({
            "to_msg_num":to_msg_num,
            "from_msg_num":from_msg_num,
            "last_time" : Timestamp.now(),
            "last_msg":sendContent
          });
        }

      }
  }
}