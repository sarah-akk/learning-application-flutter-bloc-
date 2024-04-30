import 'package:flutter/material.dart';
import 'package:learningapplication/common/entities/msgcontent.dart';

import '../../../common/values/colors.dart';

Widget ChatFileButton(String iconpath){
  return  GestureDetector(
    child: Container(
      padding: EdgeInsets.all(10),
      child: Image.asset(iconpath),
      height: 40,width: 40,
      decoration: BoxDecoration(
          color: AppColors.primaryBackground,
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
    ),
  );
}

Widget chatRightWidget(Msgcontent item){
  return Container(
    padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 0),
    child: Row(
     mainAxisAlignment: MainAxisAlignment.end,
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       ConstrainedBox(constraints: BoxConstraints(
         minHeight: 40 , maxWidth: 250
         ),
         child: Column(
           children: [
             Container(
               margin: EdgeInsets.only(right: 0,top: 0),
               padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
               decoration: BoxDecoration(
                 color: AppColors.primaryElement,
                 borderRadius: BorderRadius.only(
                   topRight: Radius.circular(0),
                   topLeft: Radius.circular(20),
                   bottomLeft: Radius.circular(20),
                   bottomRight: Radius.circular(20),
                   )
               ),
               child: Text("${item.content}",style: TextStyle(
                 fontSize: 14,
                 color: AppColors.primaryElementText
               ),),
             )
           ],
         ),
       )
     ],
   ),
  );
}
Widget chatLeftWidget(Msgcontent item){
  return Container(
    padding: EdgeInsets.only(top: 10,bottom: 10,left: 0,right: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(constraints: BoxConstraints(
            minHeight: 40 , maxWidth: 250
        ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 0,top: 0),
                padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                decoration: BoxDecoration(
                    color: AppColors.primarySecondaryBackground,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )
                ),
                child: Text("${item.content}",style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryText
                ),),
              )
            ],
          ),
        )
      ],
    ),
  );
}