import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/messages/message/cubit/message_cubits.dart';
import 'package:learningapplication/Pages/search/bloc/search_blocs.dart';
import '../../common/values/colors.dart';
import '../Home/home_page.dart';
import '../messages/message/message.dart';
import '../profile/profile_Page.dart';
import '../search/search.dart';

Widget buildPage(int index){
  List<Widget> widget =[
   const HomePage(),
    BlocProvider<SearchBlocs>(create: (context)=>SearchBlocs(),child: Search()),
    Center(child:Text("Course")),
    BlocProvider<MessageCubits>(create: (context)=>MessageCubits(),child: Messages()),
    const ProfilePage(),
  ];
  return widget[index];

}

var bottomTabs=[
  BottomNavigationBarItem(
      label:"home",
      icon:SizedBox(
        width:15.w,
        height:15.w,
        child:Image.asset("assets/icons/home.png"),
      ),
      activeIcon:Image.asset("assets/icons/home.png",color:AppColors.primaryElement,)
  ),
  BottomNavigationBarItem(
      label:"search",
      icon:SizedBox(
        width:15.w,
        height:15.w,
        child:Image.asset("assets/icons/search2.png"),
      ),
      activeIcon:Image.asset("assets/icons/search2.png",color:AppColors.primaryElement,)

  ),
  BottomNavigationBarItem(
      label:"course",
      icon:SizedBox(
        width:15.w,
        height:15.w,
        child:Image.asset("assets/icons/play-circle1.png"),
      ),
      activeIcon:Image.asset("assets/icons/play-circle1.png",color:AppColors.primaryElement,)

  ),
  BottomNavigationBarItem(
      label:"chat",
      icon:SizedBox(
        width:15.w,
        height:15.w,
        child:Image.asset("assets/icons/message-circle.png"),
      ),
      activeIcon:Image.asset("assets/icons/message-circle.png",color:AppColors.primaryElement,)

  ),
  BottomNavigationBarItem(
      label:"profile",
      icon:SizedBox(
        width:15.w,
        height:15.w,
        child:Image.asset("assets/icons/person2.png"),
      ),
      activeIcon:Image.asset("assets/icons/person2.png",color:AppColors.primaryElement,)

  ),
];