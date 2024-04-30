import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:learningapplication/Pages/Home/home_controller.dart';
import 'package:learningapplication/Pages/Sign_in/bloc/sign_in_blocs.dart';
import 'package:http/http.dart' as http;
import 'package:learningapplication/common/apis/user_api.dart';
import '../../common/entities/User.dart';
import '../../common/values/constant.dart';
import '../../global.dart';

class SignInController {

  final BuildContext context;

  const SignInController({
    required this.context,
  });

  Future<void> handleSignIn() async {
    try {
      // final state = BlocProvider.of<SignInBloc>(context).state;
      final state = context
          .read<SignInBloc>()
          .state;

      String emailAddress = state.email;
      String password = state.password;

      User user = User(email: emailAddress, password: password);
      await asyncpostAllData(user);

      await HomeController(context: context).init();

    }
    catch (e) {

    }
  }

  Future<void> asyncpostAllData(User user) async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    var userApi = UserLogInApi(); // Create an instance of the UserApi class
    var result = await userApi.login(params: user);
    print(result);
    if (result['message'] == "user log in successfully") {
      Global.storageservice.setString(
        AppConstants.STORAGE_USER_PROFILE_KEY,
        json.encode(result['user']), // Convert the map to a JSON string
      );
      Global.storageservice.setString(
        AppConstants.STORAGE_USER_TOKEN_KEY,
        result['token'],
      );
      print(AppConstants.STORAGE_USER_TOKEN_KEY);
      EasyLoading.dismiss();
      Navigator.of(context).pushNamedAndRemoveUntil(
        "application",
            (route) => false,
      );
    }
  }
}