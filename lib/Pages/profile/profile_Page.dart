import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/profile/Bloc/profile_blocs.dart';
import 'package:learningapplication/Pages/profile/Bloc/profile_events.dart';
import 'package:learningapplication/Pages/profile/Bloc/profile_states.dart';
import 'package:learningapplication/Pages/profile/profile_page_widgets.dart';
import 'package:learningapplication/common/entities/User.dart';
import 'package:learningapplication/common/values/colors.dart';

import '../../global.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    var userProfile = Global.storageservice.getUserProfile();
    context.read<ProfileBlocs>().add(TriggerProfileName(userProfile as User));
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBlocs,ProfileStates>(builder: (context,state){
      return Scaffold(
          appBar:buildAppBar(),
          body:SingleChildScrollView(
              child:Container(
                width:MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children:[

                      profileIconEdit(),
                      SizedBox(height:30.h),
                      state.userProfile==null?Container():Container(
                        child: Text(
                          textAlign: TextAlign.center,
                          state.userProfile?.name??"no Name"
                        ,style: TextStyle(
                         color: AppColors.primarySecondaryElementText,
                        fontWeight: FontWeight.normal,
                        fontSize: 15.sp),),
                      ),
                      SizedBox(height:20.h),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildRowListView(context),
                      ),
                      SizedBox(height:30.h),
                      Padding(
                        padding: const EdgeInsets.only(left:25.0),
                        child: buildColumnListView(context),
                      ),]
                ),
              )
          )
      );
    });
  }
}
