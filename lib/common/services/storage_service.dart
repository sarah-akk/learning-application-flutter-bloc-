import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../entities/User.dart';
import '../values/constant.dart';

class StorageService {
  late final SharedPreferences prefs;


  Future<StorageService> init() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  Future<bool> Remove(String key) async {
    return await prefs.remove(key);
  }


  bool getDeviceFirstOpen() {
    return prefs.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME) ?? false;
  }

  bool getIsLoggedIn() {
    return prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) == null
        ? false
        : true;
  }

  User? getUserProfile() {
    var profileOfline = prefs.getString(
        AppConstants.STORAGE_USER_PROFILE_KEY) ?? "";
    if (profileOfline.isNotEmpty) {
      return User.fromJson(jsonDecode(profileOfline));
    }
    return null;
  }

  String getUserToken() {
    return prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? "";
  }
}