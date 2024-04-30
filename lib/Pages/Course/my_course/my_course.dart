import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningapplication/Pages/Course/my_course/Bloc/myCourseBlocs.dart';
import 'package:learningapplication/Pages/Course/my_course/Bloc/myCourseStates.dart';
import 'package:learningapplication/Pages/Course/my_course/my_course_controller.dart';

class MyCourse extends StatefulWidget {
  const MyCourse({super.key});

  @override
  State<MyCourse> createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {

  late MyCoursesController myCoursesController;

  void didChangeDependencies()
  {
    myCoursesController=MyCoursesController(context: context);
    myCoursesController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCoursesBlocs,MyCoursesStates>(builder: (context,state){
     if(state is DoneLoadingMyCourseStates){
       return Scaffold(
           appBar: AppBar(),
           body:  Center(
             child: Text("My Courses"),
           )
       );
     }else{
       return Center(child: CircularProgressIndicator(),);
     }
    });
  }
}
