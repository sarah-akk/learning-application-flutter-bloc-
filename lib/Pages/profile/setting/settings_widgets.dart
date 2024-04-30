import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/constant.dart';
import '../../../common/widgets/base_text_Widget.dart';
import '../../../global.dart';

AppBar buildAppBar(){
  return AppBar(
    title:Container(
      child: Container(
        child : reusableText("Settings")
      ),
    )
  );
}

Widget settingsButton(BuildContext context,void Function() func){
  return GestureDetector(
    onTap:(){
      showDialog(context:context,builder:(BuildContext context)
      {
        return AlertDialog(
            title :Text("Confirm logout"),
            content:Text("Confirm logout"),
            actions:[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancle"),
              ),
              TextButton(
                onPressed: () {
                  func(); // Correct way to call the function
                },
                child: Text("Confirm"),
              ),
            ]

        );
      });
    },
    child: Container(
        height:100.w,
        decoration:BoxDecoration(
            image:DecorationImage(
                fit:BoxFit.fitHeight,
                image:AssetImage(
                    "assets/icons/Logout.png"
                )
            )
        )

    ),
  );

}