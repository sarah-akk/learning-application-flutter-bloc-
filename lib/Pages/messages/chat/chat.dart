
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Course/courseDetails/course_detail_widgets.dart';
import 'package:learningapplication/Pages/messages/chat/bloc/chatBlocs.dart';
import 'package:learningapplication/Pages/messages/chat/bloc/chatEvents.dart';
import 'package:learningapplication/Pages/messages/chat/chat_widgets.dart';
import 'package:learningapplication/common/values/colors.dart';
import 'package:learningapplication/common/values/constant.dart';
import 'package:learningapplication/common/widgets/text_Field.dart';

import '../../../global.dart';
import 'bloc/chatStates.dart';
import 'chat_controller.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  late ChatController chatController;

  @override
  void didChangeDependencies(){
    chatController=ChatController(context: context);
    chatController.init();
  super.didChangeDependencies();
  }

  @override
  void dispose(){
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: buildAppBar("Chat"),
        body: BlocBuilder<ChatBlocs,ChatStates>(builder: (context,state){
          return  Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(bottom: 70),
                  child: CustomScrollView(
                    controller:chatController.scrollController,
                    reverse: true,
                    slivers: [
                      SliverPadding(padding: EdgeInsets.symmetric(horizontal: 25),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context,index){
                                var item = state.msgcontentList[index];
                                if(Global.storageservice.getUserToken()==item.token) {
                                return chatRightWidget(state.msgcontentList[index]);
                              }
                                else
                                  {
                                    return chatLeftWidget(state.msgcontentList[index]);
                                  }
                            },
                            childCount: state.msgcontentList.length
                          ),
                        ),
                      ),
                    ],
                  ) ,
                ),
              ),
              Positioned(
                  bottom : 0 ,
                  child: Container(
                    color: AppColors.primaryBackground  ,
                    width: 390,
                    constraints: BoxConstraints(
                        maxHeight: 170,minHeight: 70
                    ),
                    padding: EdgeInsets.only(
                        left: 20,right: 20,bottom: 10,top: 10
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 290,
                            constraints: BoxConstraints(
                                maxHeight: 170,minHeight: 70
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBackground,
                              border: Border.all(color: AppColors.primaryFourElementText),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child:Row(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      maxHeight: 150,minHeight: 30
                                  ),
                                  padding: EdgeInsets.only(left: 5),
                                  width: 220,
                                  child: appTextField("Message", "none", (value) { } ,
                                      maxlines: null , controller: chatController.textEditingController),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    context.read<ChatBlocs>().
                                    add(TriggerAddMoreStatus(state.more_status?false:true));
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: 40,height: 40,
                                    child: Image.asset("assets/icons/05.png"),),
                                )
                              ],
                            )
                        ),
                        GestureDetector(
                          onTap: (){
                            chatController.sendMessage();
                          },
                          child: Container(width: 40,height: 40,
                            decoration: BoxDecoration(
                                color: AppColors.primaryElement,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(1,1)
                                  )
                                ]
                            ),
                            child: Image.asset("assets/icons/send2.png"),
                          ),
                        )
                      ],
                    ),
                  )),

             state.more_status? Positioned(
                 right: 82,bottom: 70,height: 100,width: 40,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     ChatFileButton("assets/icons/file.png"),
                     ChatFileButton("assets/icons/photo.png"),
                   ],
                 )) : Container()
            ],
          );
        })

      ),
    );
  }
}
