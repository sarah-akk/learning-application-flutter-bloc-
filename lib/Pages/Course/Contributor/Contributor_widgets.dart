import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/common/widgets/base_text_Widget.dart';

import '../../../common/routes/names.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/constant.dart';
import '../courseDetails/course_detail_widgets.dart';
import 'Contributor.dart';
import 'bloc/Contributor_states.dart';

Widget Background(){
  return Container(
    width: 375,
    height: 160,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.h),
        image: DecorationImage(
            image: AssetImage("assets/icons/background.png")
        )
    ),
  );
}

Widget authorView(BuildContext context,ContributorStates  state){
  return Container(
    width: 375,
    margin: EdgeInsets.only(
        left: 10.w,
        bottom: 8.w,
        top: 10
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 110,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  image: DecorationImage(
                      image: NetworkImage (
                          "http://10.0.2.2:8000${state.authorItem!.avatar}"
                      )
                  )
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60,),
                  Container(
                    child: reusableText(state.authorItem?.name?? ""),
                  ),
                  Container(
                    child: reusableText(state.authorItem?.job?? "",color:AppColors.primaryThreeElementText,fontSize: 9),
                  ),
                  authorPopularity(),
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget authorPopularity(){
  return Row(
    children: [
      Container(),
      iconAndNum("assets/icons/people.png", 123),
      iconAndNum("assets/icons/star.png", 76),
      iconAndNum("assets/icons/download.png", 76),
    ],
  );
}

Widget iconAndNum(String iconName,int num){
  return Container(
    margin: EdgeInsets.only(left: 30),
    child: Row(
      children: [
        Image(image: AssetImage(iconName),
          width: 17,height: 17,
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

Widget authorDescription(ContributorStates state)
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      reusableText("About me"),
      reusableText("${state.authorItem!.description}",color: AppColors.primaryThreeElementText,fontSize: 9),
    ],
  );
}

Widget authorCourseList(ContributorStates state){

  return SingleChildScrollView(
    child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.courseItem.length,
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
                                image:NetworkImage("${AppConstants.SERVER_UPLOADS+state.courseItem[index].thumbnail!}")
                            )
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListContainer(state.courseItem[index].name.toString()),
                          ListContainer(
                              state.courseItem[index].description.toString(),
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
