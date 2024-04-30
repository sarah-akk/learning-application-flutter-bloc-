import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:learningapplication/Pages/Course/courseDetails/bloc/course_detail_events.dart';
import 'package:learningapplication/common/apis/course_api.dart';
import 'package:learningapplication/common/apis/lesson_api.dart';
import 'package:learningapplication/common/entities/course.dart';
import 'package:learningapplication/common/entities/lesson.dart';
import 'package:learningapplication/common/routes/names.dart';

import '../payWebView/payment_view.dart';
import 'bloc/course_detail_blocs.dart';

class CourseDetailController{
  final BuildContext context;

  CourseDetailController({required this.context});

  void init()async{

    final args = ModalRoute.of(context)?.settings.arguments as Map;
    asynceLoadCourseData(args["id"]);
    asynceLoadLessonData(args["id"]);
  }

  asynceLoadCourseData(int id)async{
   CourseRequestEntity courseRequestEntity = CourseRequestEntity();
   courseRequestEntity.id=id;
   var result = await CourseApi.courseDetail(params:courseRequestEntity);
   if(result.code==200){
     if(context.mounted){
       context.read<CourseDetailBloc>().add(TriggerCourseDetail(result.data!));
     }
     else{
       print("context is not available");
     }
   }  
   else
     {
       print("something went wrong!");
       print(result.code);
     }
  }

  //////////////////////////////////////////////////////////////////////////


  asynceLoadLessonData(int?id) async {
   LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
   lessonRequestEntity.id=id;
   var result = await LessonApi.lessonList(params:lessonRequestEntity);
   if(result.code==200){
     if(context.mounted){
       context.read<CourseDetailBloc>().add(TriggerLessonList(result.data!));
     }
     else{
       print("context is not available");
     }
   }
   else
   {
     print("something went wrong!");
     print(result.code);
   }

  }


  //////////////////////////////////////////////////////////////////////


  Future<void> goBuy(int id) async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id =id;
    var result = await CourseApi.coursePay(params: courseRequestEntity);
    EasyLoading.dismiss();

    var url = Uri.decodeFull(result.data!);
    Navigator.of(context)?.pushNamed(AppRoutes.Pay_Web_View, arguments: {"url": url});

  }

}