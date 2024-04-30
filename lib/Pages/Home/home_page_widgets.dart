import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/common/values/constant.dart';

import '../../common/entities/course.dart';
import '../../common/values/colors.dart';
import '../../common/widgets/base_text_Widget.dart';
import 'bloc/home_page_blocs.dart';
import 'bloc/home_page_events.dart';
import 'bloc/home_page_states.dart';

AppBar buildAppBar(String avatar){
  return AppBar(
      title : Container(
          margin :EdgeInsets.only(left:7.w,right:7.w),
          child : Row(
              mainAxisAlignment : MainAxisAlignment.spaceBetween,
              crossAxisAlignment : CrossAxisAlignment.center,
              children : [
                SizedBox(
                    width : 18.w,
                    height:12.h,
                    child:Image.asset("assets/icons/menu.png")
                ),
                GestureDetector(
                    child : Container(
                        width:50,
                        height:50,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                            image:DecorationImage(
                                image: NetworkImage(avatar)
                            )
                        )
                    )
                )
              ]
          )
      )
  );
}


Widget homePageText(String text,{Color? color=AppColors.primaryText,int? top}){
  return  Container(
    margin :EdgeInsets.only(top:5.h,left:20),
    child:Text(
      text,
      style:TextStyle(
        color:color,
        fontSize:24.sp,
        fontWeight : FontWeight.bold,
      ),
    ),
  );
}


Widget SlideView(BuildContext context,HomePageStates state){
  return Column(
      crossAxisAlignment : CrossAxisAlignment.center,
      children:[
        Container(
            margin :EdgeInsets.only(top:15),
            width:325,
            height:140.h,
            child:PageView(
                onPageChanged : (value){
                  context.read<HomePageBlocs>().add(HomePageDots(value));
                },
                children:[
                  SlidersContainer(path:"assets/icons/Art.png"),
                  SlidersContainer(path:"assets/icons/Image(1).png"),
                  SlidersContainer(path:"assets/icons/Image(2).png"),

                ]
            )
        ),
        Container(
          child : DotsIndicator(
              dotsCount : 3,
              position:state.index,
              decorator : DotsDecorator(
                  color:AppColors.primaryThreeElementText,
                  activeColor :AppColors.primaryElement,
                  size : const Size.square(5.0),
                  activeSize : const Size(17.0,5.0),
                  activeShape:RoundedRectangleBorder(
                    borderRadius : BorderRadius.circular(5.0),
                  )
              )

          ),
        ),
      ]
  );
}

Widget SlidersContainer({String path = "assets/icons/Art.png"}){
  return Container(
      width:325,
      height:150.h,
      child:PageView(
          children:[
            Container(
                width:325,
                height:150.h,
                decoration : BoxDecoration(
                  borderRadius:BorderRadius.all(Radius.circular(20.h)),

                  image :DecorationImage(
                    fit:BoxFit.fill,
                    image: AssetImage(path),

                  ),
                )
            )
          ]
      )
  );

}

Widget menuView(){
  return Column(
      children:[
        Container(
          width:325.w,
          margin :EdgeInsets.only(top:15),
          child : Row(
            mainAxisAlignment : MainAxisAlignment.spaceBetween,
            crossAxisAlignment : CrossAxisAlignment.end,
            children : [
              reusableMenuText("Choose your course"),
              GestureDetector(child: reusableMenuText("See all",color :AppColors.primaryText,fontSize:10)),
            ],
          ),
        ),
        Container(
          margin :EdgeInsets.only(top:20.w),
          child:Row(
              children:[
                reusableMenuItem("All"),
                reusableMenuItem("popular",textcolor:AppColors.primaryThreeElementText ,background:Colors.white),
                reusableMenuItem("newest",textcolor:AppColors.primaryThreeElementText,background:Colors.white),

              ]
          ),
        ),
      ]
  );

}

Widget reusableMenuText(String text,{Color color =AppColors.primaryText,int fontSize=16}){
  return  Container(
    child: Text(
      text,
      style:TextStyle(
        color : color,
        fontWeight:FontWeight.bold,
        fontSize:fontSize.sp,
      ),
    ),
  );
}

Widget reusableMenuItem(String text,{Color textcolor = AppColors.primaryElementText , Color background = AppColors.primaryElement })
{
  return
    Container(
      margin :EdgeInsets.only(left:20.w),
      padding : EdgeInsets.only(left:15.w,right:15.w,top:5.w,bottom:5.w),
      decoration:BoxDecoration(
          color:background,
          borderRadius:BorderRadius.circular(7.w),
          border : Border.all( color:background)
      ),
      child:reusableMenuText(text,color :textcolor,fontSize:11),



    );

}


Widget courseGrid(CourseItem courseItem){
  return
    Container(
      margin :EdgeInsets.all(10.w),
      padding:EdgeInsets.all(12),
      child :Column(
          mainAxisAlignment:MainAxisAlignment.end,
          crossAxisAlignment:CrossAxisAlignment.start,

          children:[
            Text(
                courseItem.name??" ",
                maxLines:1,
                textAlign:TextAlign.left,
                softWrap:false,
                overflow:TextOverflow.fade,
                style:TextStyle(
                  color:AppColors.primaryElementText,
                  fontWeight:FontWeight.bold,
                  fontSize:11.sp,
                )
            ),

            Text(
                courseItem.description??" ",
                maxLines:1,
                textAlign:TextAlign.left,
                softWrap:false,
                overflow:TextOverflow.fade,
                style:TextStyle(
                  color:AppColors.primaryFourElementText,
                  fontWeight:FontWeight.normal,
                  fontSize:8.sp,
                )
            ),
          ]
      ),
      decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(15.w),
          image : DecorationImage(
            fit :BoxFit.fill,
            image:
                NetworkImage(AppConstants.SERVER_UPLOADS+courseItem.thumbnail!)
          )
      ),
    );

}