import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/welcome/bloc/welcome_blocs.dart';
import 'package:learningapplication/Pages/welcome/bloc/welcome_events.dart';
import '../../common/services/storage_service.dart';
import '../../common/values/constant.dart';
import '../../global.dart';
import 'bloc/welcome_states.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: BlocBuilder<WelcomeBloc,WelcomeStates>(
          builder: (context,state){
            return Container(
              width: 375.w,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    controller: pageController,
                    onPageChanged: (index){
                      state.page = index;
                      BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvents());
                    },
                    children: [
                      page(1,
                        context,
                        "next",
                        "First see learning",
                        "Forget about a for of paper all knowledge in one learning! ",
                        "assets/images/reading.png",
                      ),
                      page(2,
                        context,
                        "next",
                        "connect with Everyone",
                        "Always keep in touch with your tutor & friend. Lets get connected",
                        "assets/images/boy.png",
                      ),
                      page(3,
                        context,
                        "get started",
                        "Always Fascinated Learning",
                        "Anywhere,anytime . The time is at our discrtion so study whenever you want !",
                        "assets/images/man.png",
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 100.h,
                    child: DotsIndicator(
                      dotsCount: 3,
                      position: state.page,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                          size: const Size.square(8.0),
                          color: Colors.deepPurple,
                          activeColor: Colors.deepPurpleAccent,
                          activeSize:  Size(15.0,8.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                    ),

                  ),
                ],
              ),
            );
          },
        )
      ),
    );
  }

  Widget page(int index ,
      BuildContext context ,
      String buttonName , String title ,String subtitle,String imagepath){
    return Column(
      children: [

        SizedBox(
          width: 345.w,
          height: 345.w,
          child: Image.asset(imagepath,fit: BoxFit.cover ),
        ),
        Container(
          child: Text(title,style: TextStyle(color: Colors.black45,fontSize:24.sp,fontWeight: FontWeight.normal),),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(left: 30.w,right: 30.w),
          child: Text(subtitle,style: TextStyle(color: Colors.black45.withOpacity(0.5),fontSize:14.sp,fontWeight: FontWeight.normal),),
        ),

        GestureDetector(
          onTap: (){
            if(index<3){
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            }
            else {
            Global.storageservice.setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME,true);
            Navigator.of(context).pushNamedAndRemoveUntil("SignIn", (route) => false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 100.h,left: 25.w,right: 25.w),
            width: 375.w,
            height: 50.h,
            decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.all(Radius.circular(15.w)),
                boxShadow:[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0,1)
                  )
                ]
            ),
            child: Center(
              child: Text(buttonName,style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal
              ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
