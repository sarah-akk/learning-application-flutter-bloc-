import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/Course/Contributor/Contributor_controller.dart';
import 'package:learningapplication/Pages/Course/Contributor/Contributor_widgets.dart';
import 'package:learningapplication/Pages/Course/Contributor/bloc/Contributor_Cubits.dart';
import 'package:learningapplication/Pages/Course/Contributor/bloc/Contributor_states.dart';
import 'package:learningapplication/common/values/colors.dart';

import '../../../common/widgets/base_text_Widget.dart';
import '../courseDetails/course_detail_widgets.dart';

class Contributor extends StatefulWidget {
  const Contributor({super.key});

  @override
  State<Contributor> createState() => _ContributorState();
}

class _ContributorState extends State<Contributor> {

  late ContributorController contributorController;

  @override
  void didChangeDependencies(){
  super.didChangeDependencies();
  contributorController = ContributorController(context: context);
  contributorController.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContributorCubits,ContributorStates>(builder: (context,state){
      if (state.authorItem == null) {
        return Center(
          child: CircularProgressIndicator(), // Or any other loading indicator
        );
      } else {
      return  Scaffold(
        appBar: buildAppBar("Contributor"),
        body: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25 ,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 370,
                    height: 260,
                    child: Stack(
                      children: [
                        Background(),
                        SizedBox(height: 5,),
                        Positioned(
                          left: 0,
                            bottom: 0,
                            child: Container(
                              width: 350,height: 170,
                              child: authorView(context, state),
                        ),
                        ),
                      ],
                    ),
                  ),
                  authorDescription(state),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: (){
                     contributorController.GoChat(state.authorItem!);
                    },
                      child: appPrimaryButton("go chat")),
                  SizedBox(height: 30),
                  reusableText("Author course list"),
                  authorCourseList(state),
              ]
              )
            ),
          ),
        ),
      );
    }});
  }
}


