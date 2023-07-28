// ignore_for_file: file_names, non_constant_identifier_names

import 'package:WMS_Application/Model/Constants.dart';

String GetHttpRequest(String ApiPrefix, String CallName) {
  var url = WebApiUrl + ApiPrefix + CallName;
  return url;
}
