import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/search/bloc/search_states.dart';

import '../../common/routes/names.dart';
import '../../common/values/colors.dart';
import '../../common/values/constant.dart';
import '../Course/courseDetails/course_detail_widgets.dart';

Widget listSearch(SearchStates state){
 return ListView.builder(
     shrinkWrap: true,
     itemCount: state.courseItem.length,
     itemBuilder: (context,index){
       return Container(
         margin: EdgeInsets.only(top: 10.h),
         width: 290.w,
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
             Navigator.of(context).pushNamed(AppRoutes.Course_Detail,arguments: {
               "id":state.courseItem[index].id
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
                             image:NetworkImage("${AppConstants.SERVER_UPLOADS}${state.courseItem[index].thumbnail!}")
                         )
                     ),
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       ListContainer(state.courseItem[index].name.toString()),
                       ListContainer(
                           "${ state.courseItem[index].lesson_num} lessons",
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
     });
}