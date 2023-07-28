// ignore_for_file: non_constant_identifier_names, unnecessary_new, curly_braces_in_flow_control_structures, file_names, avoid_print, deprecated_member_use, unused_catch_stack, unused_local_variable

import 'dart:convert';
import 'package:WMS_Application/Model/Project/AMSOverviewModel.dart';
import 'package:WMS_Application/Model/Project/CanalGateMasterModel.dart';
import 'package:WMS_Application/Model/Project/PumpstationDropDownModel.dart';
import 'package:WMS_Application/Model/Project/RMS_Overview_model.dart';
import 'package:http/http.dart' as http;
import 'package:WMS_Application/Model/AreaModel.dart';
import 'package:WMS_Application/Model/Constants.dart';
import 'package:WMS_Application/Model/DistibutoryModel.dart';
import 'package:WMS_Application/Model/Project/OMS_Overview_model.dart';
import 'package:WMS_Application/Model/Project/State_list_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/Project/ProjectOverviewModel.dart';
import '../Model/Project/PumpstationMasterModel.dart';

///State List API
Future<List<State_list_Model>> getStateAuthority() async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userid = preferences.getInt('userid');
    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/Project/GetProjectAuthorityForWMS?userid=$userid'));

    print('State List Api');
    /*print(
        'http://wmsservices.seprojects.in/api/Project/GetProjectAuthorityForWMS?userid=$userid');*/
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<State_list_Model> fetchedData = <State_list_Model>[];
      json.forEach((e) => fetchedData.add(new State_list_Model.fromJson(e)));

      return fetchedData;
    } else {
      throw Exception('Failed to load API');
    }
  } catch (e) {
    throw Exception('Failed to load API');
  }
}

///Project Overview API
Future<ProjectOverviewModel> GetProjectOverviewStatus(
    {String? areaId = 'All'}) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? conString = preferences.getString('conString');
    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/Project/GetProjectOverviewStatus?aid=$areaId&did=All&conString=$conString'));
    print(
        'http://wmsservices.seprojects.in/api/Project/GetProjectOverviewStatus?aid=$areaId&did=All&conString=$conString');
    print('Project Overview Api');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      List<ProjectOverviewModel> project = <ProjectOverviewModel>[];
      json.forEach((e) => project.add(new ProjectOverviewModel.fromJson(e)));

      return project.first;
    } else {
      throw Exception('Failed to load API');
    }
  } catch (e) {
    throw Exception('Failed to load API');
  }
}

///PumpStattion Api
Future<List<PumpStationDropDownModel>> getpumpid(
    {String? areaId = 'All'}) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? conString = preferences.getString('conString');
    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/Project/getPSname?areaid=$areaId&conString=$conString'));
    print('PumpStation Name Api');
    print(
        'http://wmsservices.seprojects.in/api/Project/getPSname?areaid=$areaId&conString=$conString');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      List<PumpStationDropDownModel> project = <PumpStationDropDownModel>[];
      json['data']['Response'].forEach(
          (e) => project.add(new PumpStationDropDownModel.fromJson(e)));

      return project.toList();
    } else {
      throw Exception('Failed to load API');
    }
  } catch (_, ex) {
    print(ex.toString());
    throw Exception('Failed to load API');
  }
}

///Pumping Station Api
Future<List<PumpStationMasterModel>> getPumpData(int pumpid) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? conString = preferences.getString('conString');

    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/Project/getPumpData?pumpStationId_=$pumpid&conString=$conString'));
    print('Pump Sation Api');
    print(
        'http://wmsservices.seprojects.in/api/Project/getPumpData?pumpStationId_=$pumpid&conString=$conString');

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      List<PumpStationMasterModel> Result = <PumpStationMasterModel>[];
      json.forEach((v) => Result.add(new PumpStationMasterModel.fromJson(v)));
      // print(json);
      // print(Result.length);
      if (Result.length != 0)
        return Result;
      else
        throw Exception("No Data Available");
    } else {
      throw Exception('Failed to load');
    }
  } catch (e) {
    throw Exception('Failed to load');
  }
}

Future<List<PumpStationMasterModel>> getDC() async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? conString = preferences.getString('conString');

    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/Project/getPumpData?pumpStationId_=0&conString=$conString'));
    print(
        'http://wmsservices.seprojects.in/api/Project/getPumpData?pumpStationId_=0&conString=$conString');

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      List<PumpStationMasterModel> Result = <PumpStationMasterModel>[];
      json.forEach((v) => Result.add(new PumpStationMasterModel.fromJson(v)));
      var data = Result;
      // print(data);
      return Result;
    } else {
      throw Exception('Failed to load API111');
    }
  } catch (e) {
    throw Exception('Failed to load API222');
  }
}

Future<CanalGateMasterModel> getGCI() async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? conString = preferences.getString('conString');

    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/PumpStation/GetCannelData?conString=$conString'));

    print('Canal Gate API');
    /* print(
        'http://wmsservices.seprojects.in/api/PumpStation/GetCannelData?conString=$conString');*/

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      CanalGateMasterModel Result =
          new CanalGateMasterModel.fromJson(json['data']['Response']);

      var data = Result;
      print(data);
      return Result;
    } else {
      throw Exception('Failed to load API111');
    }
  } catch (e) {
    throw Exception('Failed to load API222');
  }
}

///Area Dropdown Api
Future<List<AreaModel>> getAreaid() async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? conString = preferences.getString('conString');
    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/OMS/GetAreaList?conString=$conString'));
    print('Area Id API');
    /*print(
        'http://wmsservices.seprojects.in/api/OMS/GetAreaList?conString=$conString');*/

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['Status'] == WebApiStatusOk) {
        List<AreaModel> Result = <AreaModel>[];
        Result.insert(
            0, new AreaModel(areaid: 0, areaName: 'ALL DISTRIBUTORY'));
        json['data']['Response']
            .forEach((v) => Result.add(AreaModel.fromJson(v)));
        return Result;
      } else {
        throw Exception();
      }
    } else {
      throw Exception('Failed to load API');
    }
  } catch (e) {
    throw Exception('Failed to load API');
  }
}

///Distibutory Dropdown Api
Future<List<DistibutroryModel>> getDistibutoryid(
    {String? areaId = 'All'}) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? conString = preferences.getString('conString');

    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/OMS/GetDistributoryList?areaid=$areaId&deviceType=OMS&conString=$conString'));
    print('Distributory Api');
    /*print(
        'http://wmsservices.seprojects.in/api/OMS/GetDistributoryList?areaid=$areaId&deviceType=OMS&conString=$conString');
    */
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['Status'] == WebApiStatusOk) {
        List<DistibutroryModel> Result = <DistibutroryModel>[];
        Result.insert(0, new DistibutroryModel(id: 0, description: 'ALL AREA'));
        json['data']['Response']
            .forEach((v) => Result.add(DistibutroryModel.fromJson(v)));
        return Result;
      } else {
        throw Exception();
      }
    } else {
      throw Exception('Failed to load API');
    }
  } catch (e) {
    throw Exception('Failed to load API');
  }
}

Future<List<DistibutroryModel>> getAMSDistibutoryid(
    {String? areaId = 'All'}) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? conString = preferences.getString('conString');
    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/OMS/GetDistributoryList?areaid=$areaId&deviceType=AMS&conString=$conString'));
    print('AMS Distibutoty API');
/*    print(
        'http://wmsservices.seprojects.in/api/OMS/GetDistributoryList?areaid=$areaId&deviceType=AMS&conString=$conString');
*/
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['Status'] == WebApiStatusOk) {
        List<DistibutroryModel> Result = <DistibutroryModel>[];
        Result.insert(0, new DistibutroryModel(id: 0, description: 'ALL AREA'));
        json['data']['Response']
            .forEach((v) => Result.add(DistibutroryModel.fromJson(v)));
        return Result;
      } else {
        throw Exception();
      }
    } else {
      throw Exception('Failed to load API');
    }
  } catch (e) {
    throw Exception('Failed to load API');
  }
}

///Oms Count Api
Future<List<OMS_Overview_model>> getOmsOverviewdata(
    String omsStatus, String damageStatus, String aid, String did) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userid = preferences.getInt('userid');
    String? conString = preferences.getString('conString');
    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/Project/OMSSummaryNew?_userid=$userid&_aid=$aid&_did=$did&_userType=Engineer&_OMSStatus=$omsStatus&_DamageStatus=$damageStatus&conString=$conString'));
    print('OMS Overview Api');
/*    print(
        'http://wmsservices.seprojects.in/api/Project/OMSSummaryNew?_userid=$userid&_aid=$aid&_did=$did&_userType=Engineer&_OMSStatus=$omsStatus&_DamageStatus=$damageStatus&conString=$conString');
*/
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      List<OMS_Overview_model> project = <OMS_Overview_model>[];
      json.forEach((e) => project.add(new OMS_Overview_model.fromJson(e)));

      return project.toList();
    } else {
      throw Exception('Failed to load API');
    }
  } catch (e) {
    throw Exception('Failed to load API');
  }
}

Future<List<Ams_Overview_Model>> getAmsOverviewdata(
    String amsStatus, String damageStatus, String aid, String did) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userid = preferences.getInt('userid');
    String? conString = preferences.getString('conString');
    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/AMS/AMSSummaryNew?_userid=$userid&_aid=$aid&_did=$did&_userType=engineer&_AMSStatus=$amsStatus&_DamageStatus=$damageStatus&conString=$conString'));
    print('AMS Overview API');
    /*  print(
        'http://wmsservices.seprojects.in/api/AMS/AMSSummaryNew?_userid=$userid&_aid=$aid&_did=$did&_userType=engineer&_AMSStatus=$amsStatus&_DamageStatus=$damageStatus&conString=$conString');
*/
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      List<Ams_Overview_Model> project = <Ams_Overview_Model>[];
      json.forEach((e) => project.add(new Ams_Overview_Model.fromJson(e)));

      return project.toList();
    } else {
      throw Exception('Failed to load API');
    }
  } catch (e) {
    throw Exception('Failed to load API');
  }
}

Future<List<RMS_Overview_model>> getRmsOverviewdata(
    String rmsStatus, String damageStatus, String aid, String did) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userid = preferences.getInt('userid');
    String? conString = preferences.getString('conString');
    final response = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/Project/RMSSummaryNew?_userid=$userid&_aid=$aid&_did=$did&_userType=Engineer&_RMSStatus=$rmsStatus&_DamageStatus=$damageStatus&conString=$conString'));
    print('RMS Overview Api');
/*    print(
        'http://wmsservices.seprojects.in/api/Project/RMSSummaryNew?_userid=$userid&_aid=$aid&_did=$did&_userType=Engineer&_RMSStatus=$rmsStatus&_DamageStatus=$damageStatus&conString=$conString');
*/
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      List<RMS_Overview_model> project = <RMS_Overview_model>[];
      json.forEach((e) => project.add(new RMS_Overview_model.fromJson(e)));

      return project.toList();
    } else {
      throw Exception('Failed to load API');
    }
  } catch (e) {
    throw Exception('Failed to load API');
  }
}

Future<void> openMap(dynamic coordinate) async {
  String mapurl = "https://www.google.com/maps/place/$coordinate";
  try {
    await launch(mapurl);
  } catch (_, ex) {
    print("Erorr");
  }
}
