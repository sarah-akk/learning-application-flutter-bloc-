import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/Course/Lesson/Bloc/lessonBlocs.dart';
import 'package:learningapplication/Pages/Course/Lesson/Bloc/lesson_events.dart';
import 'package:learningapplication/Pages/Course/Lesson/Bloc/lesson_states.dart';
import 'package:learningapplication/Pages/Course/Lesson/lesson_Widgets.dart';
import 'package:learningapplication/Pages/Course/Lesson/lesson_controller.dart';
import 'package:learningapplication/Pages/Sign_in/widgets/sign_in_widget.dart';
import 'package:learningapplication/common/entities/lesson.dart';
import 'package:learningapplication/common/values/colors.dart';
import 'package:video_player/video_player.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail({super.key});

  @override
  State<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {

  late LessonController lessonController;
  int videoIndex=0;

  @override
  void didChangeDependencies(){
  super.didChangeDependencies();
  lessonController = LessonController(context: context);
  context.read<LessonBlocs>().add(TriggerUrlItem(null));
  context.read<LessonBlocs>().add(TriggerVideoIndex(0));
  lessonController.init();
  }

  @override
  void dispose(){
    lessonController.videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<LessonBlocs,LessonStates>(builder: (context,state){
       return SafeArea(
           child: Container(
         color: Colors.white,
         child: Scaffold(
           appBar: buildAppBar("Lesson Details"),
           body: CustomScrollView(
             slivers: [
               SliverPadding(padding: EdgeInsets.symmetric(
                 vertical: 20.h,
                 horizontal: 20.w
               ),
                 sliver:  SliverToBoxAdapter(
                   child: Column(
                     children: [
                      videoPlayer(state,lessonController),
                       videoControls(state, lessonController, context)
                     ],
                   ),
                 ),
               ),
               videoList(state , lessonController),
             ],
           ),
         )
       ));
    });
  }

}

