import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Course/my_course/Bloc/myCourseBlocs.dart';
import 'package:learningapplication/Pages/Course/my_course/Bloc/myCourseEvents.dart';
import 'package:learningapplication/Pages/Course/my_course/Bloc/myCourseStates.dart';
import 'package:learningapplication/common/apis/course_api.dart';

class MyCoursesController{
  late BuildContext context;
  MyCoursesController({required this.context});

  void init(){
    asyncLoadCourseData();
  }
   asyncLoadCourseData() async {
    Future.delayed(Duration(seconds: 3),()=>
      context.read<MyCoursesBlocs>().add(LoadingMyCourseEvents()));
      var result = await CourseApi.courseList();
      if(result.code==200){
     if(context.mounted){
       context.read<MyCoursesBlocs>().add(LoadedMyCourseEvents([]));
       context.read<MyCoursesBlocs>().add(DoneLoadingMyCourseEvents());
     }
   }
  }
}