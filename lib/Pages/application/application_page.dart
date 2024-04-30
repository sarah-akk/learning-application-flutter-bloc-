import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/values/colors.dart';
import 'application_widgets.dart';
import 'bloc/app_blocs.dart';
import 'bloc/app_events.dart';
import 'bloc/app_states.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  int index=0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBlocs,AppStates>(builder:(context,state){
      return Container(
        color:Colors.white,
        child:SafeArea(
            child:  Scaffold(
              body:buildPage(state.index),
              bottomNavigationBar:Container(
                width:375.w,
                height:58.h,
                decoration : BoxDecoration(
                    color:AppColors.primaryElement,
                    boxShadow:[
                      BoxShadow(
                        color:Colors.grey,
                        spreadRadius:1,
                        blurRadius:1,
                      )
                    ]
                ),
                child:BottomNavigationBar(
                  currentIndex:state.index,
                  showSelectedLabels:false,
                  showUnselectedLabels:false,
                  selectedItemColor:AppColors.primaryElement,
                  unselectedItemColor:AppColors.primaryFourElementText,
                  elevation:0,
                  type:BottomNavigationBarType.fixed,
                  onTap:(value){
                    context.read<AppBlocs>().add(TriggerAppEvents(value));
                  },
                  items:bottomTabs,
                ),
              ),
            )
        ),
      );
    });
  }
}
