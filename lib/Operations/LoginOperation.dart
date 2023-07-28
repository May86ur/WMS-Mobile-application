// ignore_for_file: unused_catch_stack, curly_braces_in_flow_control_structures, avoid_print, file_names

import 'package:WMS_Application/Model/Project/ChangePasswordMasterModel.dart';
import 'package:http/http.dart' as http;
import 'package:WMS_Application/Model/Constants.dart';

import 'dart:async';
import 'dart:convert';

import 'package:WMS_Application/Model/LoginModel.dart';
import 'package:WMS_Application/Services/RestServices.dart';

Future<LoginModel?> fetchLoginDetails(String mobno, String passwd) async {
  try {
    final response = await http.get(Uri.parse(GetHttpRequest(
        WebApiLoginPrefix, 'Login?MobNo=$mobno&Password=$passwd')));

    print(WebApiLoginPrefix + 'Login?MobNo=$mobno&Password=$passwd');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['Status'] == WebApiStatusOk) {
        //Single Model
        LoginModel loginResult = LoginModel.fromJson(json['data']['Response']);

        //Collection Model
        /*
        List<LoginModel> loginResult = <LoginModel>[];
        json['Response'].forEach((v) => LoginModel.fromJson(v));
        */
        // print(loginResult);
        return loginResult;
      } else
        throw Exception("Login Failed");
    } else {
      throw Exception("Login Failed");
    }
  } on Exception catch (_, ex) {
    return null;
  }
}

Future<ChangePasswordMasterModel?> chnagePassword(
    String mobno, String oldpasswd, String newpasswd) async {
  try {
    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/login/ResetPassword?MobNo=$mobno&OldPassword=$oldpasswd&NewPassword=$newpasswd'));
    print(
        'http://wmsservices.seprojects.in/api/login/ResetPassword?MobNo=$mobno&OldPassword=$oldpasswd&NewPassword=$newpasswd');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['Status'] == WebApiStatusOk) {
        //Single Model
        // String loginResult = 'Password Changed';
        ChangePasswordMasterModel loginResult =
            ChangePasswordMasterModel.fromJson(json['data']);
        // print(loginResult);
        return loginResult;
      } else
        throw Exception("Change Password Failed");
    } else {
      throw Exception("Can't Change Your Password");
    }
  } on Exception catch (_, ex) {
    return null;
  }
}
