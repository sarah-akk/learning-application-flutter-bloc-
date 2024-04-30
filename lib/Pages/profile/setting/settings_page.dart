import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/Home/bloc/home_page_blocs.dart';
import 'package:learningapplication/Pages/Home/bloc/home_page_events.dart';
import 'package:learningapplication/global.dart';
import '../../../common/routes/names.dart';
import '../../../common/values/constant.dart';
import '../../application/bloc/app_blocs.dart';
import '../../application/bloc/app_events.dart';
import "settings_widgets.dart";
import 'package:learningapplication/Pages/profile/setting/bloc/settings_blocs.dart';
import 'package:learningapplication/Pages/profile/setting/bloc/settings_states.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  void removeData(){
    context.read<AppBlocs>().add(TriggerAppEvents(0));
    context.read<HomePageBlocs>().add(HomePageDots(0));
    Global.storageservice.Remove(AppConstants.STORAGE_USER_TOKEN_KEY);
    Global.storageservice.Remove(AppConstants.STORAGE_USER_PROFILE_KEY);
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.SignIn,(route)=>false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:buildAppBar(),
      body:SingleChildScrollView(
        child: BlocBuilder<SettingsBlocs,SettingsStates>(
            builder : (context,state){
              return   Container(
                child: Column(
                  children:[
                    settingsButton(context,removeData),
                  ]

                ),
              );
            }
        )

      )
    );
  }
}
