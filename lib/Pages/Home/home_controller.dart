import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Home/bloc/home_page_blocs.dart';
import 'package:learningapplication/Pages/Home/bloc/home_page_events.dart';
import 'package:learningapplication/global.dart';

import '../../common/apis/course_api.dart';
import '../../common/entities/User.dart';

class HomeController{
  late BuildContext context;

  User? get userprofile => Global.storageservice.getUserProfile();

  static final HomeController _singleton =HomeController._internal();
  HomeController._internal();

  factory HomeController({required BuildContext context}){
    _singleton.context =context;
    return _singleton;
  }

  Future<void> init() async {
   if(Global.storageservice.getUserToken().isNotEmpty)
     {
       var result  = await CourseApi.courseList();
       if(result.code==200)
       {
         context.read<HomePageBlocs>().add(HomePageCourseItem(result.data!));
         return;
         print("perfect");
         print(result.data?[0].name);
       }
       else
       {
         print(result.code);
         return;
       }

     }
   else
   {
     return;
   }
     }
}