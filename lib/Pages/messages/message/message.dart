
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Course/courseDetails/course_detail_widgets.dart';
import 'package:learningapplication/Pages/messages/message/cubit/message_cubits.dart';
import 'package:learningapplication/Pages/messages/message/cubit/message_states.dart';
import 'package:learningapplication/Pages/messages/message/message_Widgets.dart';
import 'package:learningapplication/Pages/messages/message/message_controller.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessageState();
}

class _MessageState extends State<Messages> {

  late MessageController messageController;

  @override void didChangeDependencies() {
   messageController=MessageController(context: context);
   messageController.init();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<MessageCubits,MessageState>(builder: (context,state){
      var mylist = state.message;
      print("my list : ${mylist.length}");

     return  Scaffold(
       appBar: buildAppBar("Messages"),
       body:state.loadStatus==true?Center(child: CircularProgressIndicator(
       )):CustomScrollView(
            slivers: [
              SliverPadding(padding: EdgeInsets.symmetric(
                horizontal: 25,vertical: 0,),
               sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (_,index){
                      var item = state.message.elementAt(index);
                      return buildChatList(context,item,messageController);
                      },
                    childCount: state.message.length
                  ),
                )
              )
            ],
       ),

     );
    });
  }
}
