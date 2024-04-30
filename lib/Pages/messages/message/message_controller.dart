import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/messages/message/cubit/message_cubits.dart';
import 'package:learningapplication/common/entities/message.dart';
import 'package:learningapplication/common/routes/names.dart';
import 'package:learningapplication/global.dart';

import '../../../common/entities/User.dart';
import '../../../common/entities/msg.dart';

class MessageController{
  late BuildContext context;
  MessageController({required this.context});

  final db = FirebaseFirestore.instance;
  User? userProfile = Global.storageservice.getUserProfile();
  StreamSubscription<QuerySnapshot<Object?>>? listener1;
  StreamSubscription<QuerySnapshot<Object?>>? listener2;

  Future<void> init() async {
    await snapshots();
  }



  Future<void> goChat(Message item) async {
    var nav = Navigator.of(context);
    if(item.doc_id!=null){
      if(listener1!=null && listener2!=null){
        await listener1?.cancel();
        await listener2?.cancel();
      }
    }
    nav.pushNamed(AppRoutes.Chat,arguments: {
      "doc-id" : item.doc_id!,
      "to_token":item.token!,
      "to_avatar":item.avatar!,
      "to_online":item.online != null?item.online:"",
      
    }).then((value) => snapshots());
  }

  //////////////////////////////////////////////////////////////////

  Future<void>  snapshots () async{
  var token = Global.storageservice.getUserToken();

  final toMessageRef = db.collection("message").withConverter(
      fromFirestore: Msg.fromFirestore,
      toFirestore: (Msg msg,options) => msg.toFirestore())
    .where("to_token",isEqualTo: token);

  final fromMessageRef = db.collection("message").withConverter(
      fromFirestore: Msg.fromFirestore,
      toFirestore: (Msg msg,options) => msg.toFirestore())
      .where("from_token",isEqualTo: token);


  listener1 = toMessageRef.snapshots().listen((event) async {
     await aysncLoadMsgData();
  });
  listener1 = fromMessageRef.snapshots().listen((event) async {
    await aysncLoadMsgData();
  });

  }

  ////////////////////////////////////////////////////////////////////////

  aysncLoadMsgData() async {

    var msgContext = context.read<MessageCubits>();

    final fromMessageRef = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg,options) => msg.toFirestore())
        .where("from_token",isEqualTo: Global.storageservice.getUserToken())
        .get();

    final toMessageRef = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg,options) => msg.toFirestore())
        .where("to_token",isEqualTo: Global.storageservice.getUserToken())
        .get();

    List<Message> messageList = <Message>[];

    if(fromMessageRef.docs.isNotEmpty){
       var message = await  addMessage(fromMessageRef.docs);
       messageList.addAll(message);
    }
    if(toMessageRef.docs.isNotEmpty){
      var message = await  addMessage(toMessageRef.docs);
      messageList.addAll(message);
    }

    messageList.sort((a,b){
      if(a.last_time==null) return 0;
      if(b.last_time==null) return 0;

      return b.last_time!.compareTo(a.last_time!);
    });
    msgContext.messageChanged(messageList);
    msgContext.loadStatusChanged(false);
  }

  /////////////////////////////////////////////////////////////////

  Future <List<Message>> addMessage(List<QueryDocumentSnapshot<Msg>> data) async{
    List<Message> messageList = <Message>[];
    data.forEach((element) {

      var item = element.data();
      Message message = Message();

      message.doc_id= element.id;
      message.last_time = item.last_time;
      message.msg_num = item.msg_num;
      message.last_msg = item.last_msg;

      if(item.from_token == Global.storageservice.getUserToken()){
        message.name = item.to_name;
        message.avatar=item.to_avatar;
        message.online=item.to_online??0;
        message.msg_num=item.to_msg_num??0;
        message.token = item.to_avatar;

      }else{
        message.name = item.from_name;
        message.avatar=item.from_avatar;
        message.online=item.from_online;
        message.msg_num=item.from_msg_num??0;
        message.token=item.from_token;
      }
      
      messageList.add(message);

    });

    return messageList;
  }
}