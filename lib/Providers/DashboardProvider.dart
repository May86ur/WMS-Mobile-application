import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_management_system/Model/LoginModel.dart';
import 'package:water_management_system/Utils/Permisstion.dart';

import '../Model/Project/ActiveAlarmMasterModelNotify.dart';
import '../Operations/StateselectionOperation.dart';

enum Keys {
  user,
  userType,
}

class DashboardProvider extends ChangeNotifier {
  //variables
  String? _username;
  LoginModel? _userDetails;

  //setters
  String? get username => _username;
  LoginModel? get userDetails => _userDetails;

  List<ActiveAlarmNotifyMasterModel>? _alarmList;
  List<ActiveAlarmNotifyMasterModel>? get alarmList => _alarmList;

  //Functions
  updateUserDetails(LoginModel? result) {
    storeDataSharedPreferences(Keys.user, jsonEncode(result));
    _userDetails = result;
    notifyListeners();
  }

  // getAlarmData() async {
  //   var res = await getActiveAlarmData();
  //   PermissionHandler.showNotification(res[0].description, res[0].tagName);
  // }

  updateAlarmList(List<ActiveAlarmNotifyMasterModel>? list) {
    _alarmList = list;
  }

  Future<void> getUserFromSharedPref() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final user = sharedPreferences.getString("user");
      if (user != null) {
        final newUserDetails = LoginModel.fromJson(jsonDecode(user));
        _userDetails = newUserDetails;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void getDataFromSharedPreferences(BuildContext context, Keys key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(key.name) != null && context.mounted) {
      getUserFromSharedPref();
    }
  }

  Future<bool> storeDataSharedPreferences(Keys key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = await sharedPreferences.setString(key.name, value);
    if (result == true) {
      return true;
    } else {
      return false;
    }
  }
}
