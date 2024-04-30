import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/routes/names.dart';
import '../../common/values/colors.dart';
import '../../common/widgets/base_text_Widget.dart';

AppBar buildAppBar(){
  return AppBar(
      title :Container(
          child :Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children:[
                SizedBox(
                    width : 18.w,
                    height:12.h,
                    child:Image.asset("assets/icons/menu.png")

                ),
                reusableText("profile"),
                SizedBox(
                  width : 24.w,
                  height:24.h,
                  child:Image.asset("assets/icons/more-vertical.png"),

                )
              ]
          )
      )
  );
}

Widget profileIconEdit(){
  return    Container(
      alignment:Alignment.bottomRight,
      padding:EdgeInsets.only(right:6.w),
      child: Image(
        width : 25.w,
        height:25.h,
        image:AssetImage("assets/icons/edit_3.png"),
      ),
      width :80.w,
      height:80.h,
      decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(20.w),
          image:DecorationImage(
              image: AssetImage(
                  "assets/icons/headpic.png"
              )

          )
      )
  );
}

var RowImageInfo = <String, String>{
  "My courses": "video(1).png",
  "Buy courses": "Vector.png",
  "4.9": "star(2).png",

};


var ColumnImageInfo = <String, String>{
  "Settings": "settings.png",
  "payment details": "credit-card.png",
  "Achievment": "award.png",
  "Love":"heart(1).png",
  "Reminders":"cube.png"
};

Widget buildColumnListView(BuildContext context) {
  return Column(
    children: [
      ...List.generate(
        ColumnImageInfo.length,
            (index) => GestureDetector(
          onTap :()=>
           Navigator.of(context).pushNamed(AppRoutes.Settings)
          ,
          child: Container(
            margin:EdgeInsets.only(bottom:15.h),
            child: Row(
              children: [
                Container(
                  child: Image.asset(
                    "assets/icons/${ColumnImageInfo.values.elementAt(index)}",
                  ),
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: AppColors.primaryElement,
                  ),
                ),
                SizedBox(width: 15.w),
                Text(
                  ColumnImageInfo.keys.elementAt(index),
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildRowListView(BuildContext context) {
  return Row(
    children: [
      ...List.generate(
        RowImageInfo.length,
            (index) => GestureDetector(
          onTap: () {
         Navigator.of(context).pushNamed(AppRoutes.MY_COURSES);
          },
          child:Container(
            margin: EdgeInsets.only(bottom: 5.h, left: 20),
            width: 90.w,
            height: 50.h,
            padding: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: AppColors.primaryElement,
            ),
            child: Column(
              children: [
                Image.asset(
                  width: 20.w,
                  height: 20.h,
                  "assets/icons/${RowImageInfo.values.elementAt(index)}",
                ),
                Text(
                  RowImageInfo.keys.elementAt(index),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),

            ),
        ),

    ],
  );
}
