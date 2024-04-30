import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/Sign_in/bloc/sign_in_blocs.dart';
import 'package:learningapplication/Pages/Sign_in/bloc/sign_in_states.dart';
import 'package:learningapplication/Pages/Sign_in/sign_in_controller.dart';
import 'package:learningapplication/Pages/Sign_in/widgets/sign_in_widget.dart';

import 'bloc/sign_in_events.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);


  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<SignInBloc,SignInState>(builder: (context,state)
    {return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar:buildAppBar("Log In"),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildThirdPartyLogin(context),
                reusableText("or use you Email account to login"),
                Container(
                  margin: EdgeInsets.only(top: 66.h),
                  padding: EdgeInsets.only(left: 25.w,right: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText("Email"),
                      SizedBox(height: 5.h,),
                      buildTextField("email","Enter your Email","user",
                              (value){
                            context.read<SignInBloc>().add(EmailEvent(value!));
                          }),
                      reusableText("Password"),
                      buildTextField("password","Enter your Password","lock",
                          (value){
                        context.read<SignInBloc>().add(PasswordEvent(value!));
                          }),
                      SizedBox(height: 30.h,),
                      forgetPassword(),
                      buildLogInAdnRegButtom("Log In","login",(){

                        SignInController(context: context).handleSignIn();

                      }),
                      buildLogInAdnRegButtom("Register","register",(){
                         Navigator.of(context).pushNamed("register");
                      }),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    });
  }
}
