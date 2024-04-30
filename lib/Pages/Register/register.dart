import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningapplication/Pages/Register/register_controller.dart';
import '../Sign_in/widgets/sign_in_widget.dart';
import 'bloc/register_bloc.dart';
import 'bloc/register_events.dart';
import 'bloc/register_states.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {


    return BlocBuilder<RegisterBloc,RegisterStates>(builder: (context,state)
{
      return  Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar:buildAppBar("Sign up"),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                reusableText("Enter your details  to Sign up"),
                Container(
                  margin: EdgeInsets.only(top: 66.h),
                  padding: EdgeInsets.only(left: 25.w,right: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText("User Name"),
                      SizedBox(height: 5.h,),
                      buildTextField("name","Enter your name","user",
                              (value){
                                context.read<RegisterBloc>().add(UserNameEvent(value!));
                          }),
                      reusableText("Email"),
                      SizedBox(height: 5.h,),
                      buildTextField("email","Enter your Email","user",
                              (value){
                            context.read<RegisterBloc>().add(EmailEvent(value!));
                          }),
                      reusableText("Password"),
                      buildTextField("password","Enter your Password","lock",
                              (value){
                            context.read<RegisterBloc>().add(PasswordEvent(value!));
                          }),
                      reusableText("Confirm Password"),
                      buildTextField("repassword","re_enter your Password to Confirm ","lock",
                              (value){
                               context.read<RegisterBloc>().add(RePasswordEvent(value!));
                          }),
                      SizedBox(height: 30.h,),
                      Container(
                       margin:EdgeInsets.only(left: 25.h,),
                        child : reusableText("Enter your details  to Sign up"),
                      ),
                      buildLogInAdnRegButtom("Sign Up","login",(){
                        RegisterController(context: context).handleRegister();

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
