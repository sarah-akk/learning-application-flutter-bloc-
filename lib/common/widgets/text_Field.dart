import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget appTextField(String textType,String hinttext,
    void Function(String? value)?func ,
    { int? maxlines = 1 , TextEditingController? controller}){

  return TextField(
    onChanged:(value)=>func!(value),
   controller:  controller,
    keyboardType: TextInputType.multiline,
    maxLines:   maxlines ,
    decoration: InputDecoration(
        hintText: hinttext,
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent
          ),
        ),
        disabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent
          ),
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.5),
        )
    ),
    style: TextStyle(
      color: Colors.black45,
      fontFamily: "Avenir",
      fontWeight: FontWeight.normal,
      fontSize: 14.sp,

    ),
    autocorrect: false,
    obscureText: textType=="password"?true:false,
  );
}