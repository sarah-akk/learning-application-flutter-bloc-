
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/Course/courseDetails/bloc/course_detail_blocs.dart';
import 'package:learningapplication/Pages/Course/courseDetails/bloc/course_detail_states.dart';
import 'package:learningapplication/Pages/Course/courseDetails/course_detail_controller.dart';
import 'package:learningapplication/common/values/colors.dart';
import 'package:learningapplication/common/widgets/base_text_Widget.dart';

import 'course_detail_widgets.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {

  late CourseDetailController courseDetailController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    courseDetailController = CourseDetailController(context: context);
    courseDetailController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar("Course Details"),
      body: BlocBuilder<CourseDetailBloc, CourseDetailStates>(
        builder: (context, state) {
          if (state.courseItem == null) {
            return Center(
              child: CircularProgressIndicator(), // Or any other loading indicator
            );
          } else {
            return Container(
              color: Colors.white,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              thumbnail(state),
                              SizedBox(height: 15,),
                              menuView(context,state),
                              SizedBox(height: 20,),
                              reusableText("course Description"),
                              SizedBox(height: 20,),
                              describeText(state),
                              SizedBox(height: 20,),
                              GestureDetector
                                (child: appPrimaryButton("go buy"),
                              onTap: () {
                                courseDetailController.goBuy(
                                    state.courseItem!.id as int);
                              }),
                              SizedBox(height: 20,),
                              courseSumary(),
                              SizedBox(height: 20,),
                              courseSummaryView(context,state),
                              SizedBox(height: 20,),
                              reusableText("lesson List"),
                              courseLessonList(state),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}