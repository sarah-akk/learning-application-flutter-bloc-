import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/common/values/colors.dart';
import 'package:learningapplication/common/widgets/text_Field.dart';

AppBar buildAppBar(String text){
  return  AppBar(
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1.0),
      child: Container(
        color: AppColors.primarySecondaryBackground,
        height: 1.0,

      ),
    ),
    title: Text(text,
      style: TextStyle(
        color: AppColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.sp,
      ),
    ),
    centerTitle: true,
  );
}

Widget buildThirdPartyLogin(BuildContext context){
return Center(
  child: Container(
    margin: EdgeInsets.only(
      top: 40.h,
      bottom: 20.h
    ),
  padding: EdgeInsets.only(
    left: 25.w,right: 25.w
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      reusableIcons("google"),
      reusableIcons("apple"),
      reusableIcons("facebook"),
    ],
  ),

  ),
);
}

Widget reusableIcons(String iconName){

  return GestureDetector(
    onTap: (){

    },
    child: Container(
      width: 40.w,
      height: 40.w,
      child: Image.asset("assets/icons/$iconName.png"),
    ),
  );
}

Widget reusableText(String text){
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    child: Text(
      text,style: TextStyle(
      color: Colors.blueGrey,
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
    ),
    ),
  );
}

Widget buildTextField(String textType,String hinttext,String iconName,void Function(String? value)?func){
  return Container(
width: 325.w,
height: 50.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15.w)),
      border : Border.all(color: Colors.black45),
    ),
    child: Row(
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          margin: EdgeInsets.only(left: 17.w),
          child: Image.asset("assets/icons/$iconName.png"),

        ),
        Container(
          width: 260.w,
          height: 50.h,
          child: appTextField("Enter your Email",textType, func)
        )
      ],
    ),
  );
}

Widget forgetPassword(){

  return Container(
    margin: EdgeInsets.only(left: 20.w),

    width: 260.w,
    height: 44.h,
    child: GestureDetector(
      onTap: (){

      },
      child: Text(
        "Forget password ?",
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.underline,
          fontSize: 12.sp,
          decorationColor: Colors.blue

        ),

      ),
    ),
  );
}

Widget buildLogInAdnRegButtom(String buttonName,String buttonType,void Function()?func){
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 250.w,
      height: 50.h,
      margin: EdgeInsets.only(left: 25.w,right: 25.h,top:buttonType=="login"? 40.h : 20.h),
      decoration: BoxDecoration(
        color: buttonType=="login"? AppColors.primaryElement:AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(15.w),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0,1),
            color: Colors.grey.withOpacity(0.5),
          )
        ]
        ),
    child: Center(child: Text(
      buttonName,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: buttonType=="login"?Colors.white:AppColors.primaryText
      ),
    ),),
    ),
  );
}

