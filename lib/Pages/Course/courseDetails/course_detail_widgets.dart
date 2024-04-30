import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/Course/courseDetails/bloc/course_detail_states.dart';
import 'package:learningapplication/common/routes/names.dart';
import 'package:learningapplication/common/values/colors.dart';
import 'package:learningapplication/common/widgets/base_text_Widget.dart';

import '../../../common/values/constant.dart';

AppBar buildAppBar(String s){
  return AppBar(
    title: reusableText(s),

  );
}


Widget thumbnail(CourseDetailStates state){
  return  Container(
    width: 325.w,
    height: 200.h,
    decoration: BoxDecoration(
        image:DecorationImage(
            fit: BoxFit.fitWidth,
            image : NetworkImage(AppConstants.SERVER_UPLOADS+state.courseItem!.thumbnail.toString())
        )
    ),

  );
}


Widget menuView(BuildContext context , CourseDetailStates state){
  return Container(
    width: 325.w,
    child: Row(
      children: [
        GestureDetector(
          onTap: (){
           Navigator.of(context).pushNamed(AppRoutes.Contributor ,
               arguments: {
                 "token": state.courseItem!.user_token
               });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(7.w),
              border: Border.all(color: AppColors.primaryElement),

            ),
            child: reusableText("Author Page",
            color: AppColors.primaryElementText,
            fontWeight: FontWeight.normal,
            fontSize: 10,
            ),
          ),
        ),
        iconAndNum("assets/icons/people.png", 0),
        iconAndNum("assets/icons/star.png", 0),

      ],
    ),
  );
}

Widget iconAndNum(String iconName,int num){
  return Container(
    margin: EdgeInsets.only(left: 30),
    child: Row(
      children: [
        Image(image: AssetImage(iconName),
        width: 20,height: 20,
        ),
        reusableText(
          num.toString(),
        color: AppColors.primaryThreeElementText,
        fontSize: 11,
        fontWeight: FontWeight.normal,
        )
      ],
    ),
  );
}



Widget describeText(CourseDetailStates state)
{
  return reusableText(state.courseItem!.description as String,
      color: AppColors.primaryThreeElementText,
      fontWeight: FontWeight.normal,
      fontSize: 11);
}


Widget PrimaryButton(String name){
  return Container(
    padding: EdgeInsets.only(top: 13.h),
    width: 330.w,
    height: 50.h,
    decoration: BoxDecoration(
      color: AppColors.primaryElement,
      borderRadius: BorderRadius.circular(10.w),
      border: Border.all(color: AppColors.primaryElement),
    ),
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.primaryElementText,
        fontSize: 16.sp,
        fontWeight: FontWeight.normal
      ),
    ),
  );
}


Widget courseSumary(){
  return reusableText("the course include",fontSize: 14);
}




Widget courseSummaryView(BuildContext context, CourseDetailStates state) {
  var ColumnImageInfo = <String, String>{
    "${state.courseItem!.video_len.toString() ?? '0'} Hours video": "video_detail.png",
    "Total ${state.courseItem?.lesson_num.toString() ?? '0'} Lessons ": "file_detail.png",
    "${state.courseItem?.down_num.toString() ?? "0"} Downloadable resources": "download_detail.png",
  };
  // Rest of your code


  return Column(
    children: [
      ...List.generate(
        ColumnImageInfo.length,
            (index) => GestureDetector(
          onTap :()=>
            null
          ,
          child: Container(
            margin:EdgeInsets.only(bottom:15.h),
            child: Row(
              children: [
                Container(
                  child: Image.asset(
                    "assets/icons/${ColumnImageInfo.values.elementAt(index)}",
                    width: 30.w,
                    height: 30.h,
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
                    color: AppColors.primarySecondaryElementText,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
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

Widget courseLessonList(CourseDetailStates state){

  return SingleChildScrollView(
    child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.lessonItem.length,
        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.only(top: 10.h),
            width: 325.w,
            height: 80.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(10.w),
                boxShadow: [
                  BoxShadow
                    (
                    color:  Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset:  Offset(0,1),

                  )
                ]
            ),
            child: InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(AppRoutes.LESSON_Detail,arguments: {
                  "id":state.lessonItem[index].id
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width:  60.w,
                        height:  60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.h),
                            image:DecorationImage(
                                fit: BoxFit.cover,
                                image:NetworkImage(AppConstants.SERVER_UPLOADS+state.lessonItem[index].thumbnail!)
                            )
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListContainer(state.lessonItem[index].name.toString()),
                          ListContainer(
                              state.lessonItem[index].description.toString(),
                              fontSize: 10,
                              color: AppColors.primaryThreeElementText),
                        ],
                      )
                    ],
                  ),
                  Container(
                    child: Image(
                      height: 24.h,
                      width: 24.w,
                      image: AssetImage("assets/icons/arrow_right.png",
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}

Widget ListContainer(String name, {double fontSize =13 , Color color =AppColors.primaryText}){
  return  Container(
    width: 200,
    margin: EdgeInsets.only(left: 6),
    child: Text(
      name,
      overflow: TextOverflow.clip,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),),
  );
}
