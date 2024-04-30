import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:learningapplication/global.dart';
import '../../common/apis/user_api.dart';
import '../../common/entities/User.dart';
import '../../common/values/constant.dart';
import 'bloc/register_bloc.dart';

class RegisterController{

  final BuildContext context;

  const RegisterController({
    required this.context,
  });

  Future<void> handleRegister() async {
    try {
      // final state = BlocProvider.of<SignInBloc>(context).state;
      final state = context
          .read<RegisterBloc>()
          .state;

      String name = state.userName;
      String emailAddress = state.email;
      String password = state.password;
      String repassword = state.repassword;

      String photoURL = "${AppConstants.SERVER_API_URL}uploads/default.jpg";
      User user = User(name: name, email: emailAddress, password: password,photoURL: photoURL);
      asyncpostAllData(user);
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
    var userApi = UserRegisterApi(); // Create an instance of the UserApi class
    var result = await userApi.register(params: user);
    print(result);
    if (result['message'] == "registered successfully") {
      Global.storageservice.setString(
        AppConstants.STORAGE_USER_PROFILE_KEY,
        json.encode(result['user']), // Convert the map to a JSON string
      );
      Global.storageservice.setString(
        AppConstants.STORAGE_USER_TOKEN_KEY,
        result['token'],
      );
      EasyLoading.dismiss();
      Navigator.of(context).pushNamedAndRemoveUntil(
        "application",
            (route) => false,
      );
    }
  }


}