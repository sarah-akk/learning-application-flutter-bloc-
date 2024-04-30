import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningapplication/Pages/messages/message/message_controller.dart';
import 'package:learningapplication/common/values/colors.dart';
import '../../../common/entities/message.dart';
import '../../../common/utils/time_formate.dart';
import '../../../common/widgets/base_text_Widget.dart';

Widget buildChatList(BuildContext context ,Message item ,MessageController messageController){
return Container(
  width: 325, height: 90,padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
  child: InkWell(
      onTap: (){
         messageController.goChat(item);
      },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
         Container(
           width: 80,height: 80,
           decoration: BoxDecoration(
             image: DecorationImage(
               image: NetworkImage(
                 "http://10.0.2.2:8000${item.avatar}"
                     // "${item.avatar}"
               ),
               fit: BoxFit.fitHeight
             ),
             borderRadius: BorderRadius.circular(15)
           ),
         ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: 210 ,
                  child: reusableText("${item.name}",color: AppColors.primaryText,fontSize: 13),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,top: 10),
                  child: Text("${item.last_msg}",
                  overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    ),
                ),
              ],
            )
          ],
        ),
        SizedBox(width: 5,),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(item.last_time==null?" ":duTimeLineFormat(
                  (item.last_time as Timestamp).toDate()
              ),
                style: TextStyle(
                  color: AppColors.primaryThreeElementText,
                  fontSize: 10,
                  fontWeight: FontWeight.normal
                ),
              )
            ),
            item.msg_num==0?Container():Container(
              height: 15,
              alignment: Alignment.center,
              constraints: BoxConstraints(minWidth: 15),
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text(
                "${item.msg_num}",
                style: TextStyle(
                  color: AppColors.primaryElementText,
                  fontWeight: FontWeight.normal,
                  fontSize: 8
                ),
              ),
            )
          ],
        )
      ],
    ),
  ),
 );
}