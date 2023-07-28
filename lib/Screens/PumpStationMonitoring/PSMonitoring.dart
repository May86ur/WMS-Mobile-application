// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_local_variable, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'package:WMS_Application/Model/Project/State_list_Model.dart';
import 'package:WMS_Application/Model/ProjectModel.dart';
import 'package:WMS_Application/Operations/StateselectionOperation.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/Screens/SystemMonitoring/SystemMonitoring_New.dart';
import 'package:WMS_Application/core/app_export.dart';
import 'package:WMS_Application/styles.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/PSMonitoringModel.dart';

class PSMonitoring_New extends StatefulWidget {
  const PSMonitoring_New({Key? key}) : super(key: key);

  @override
  State<PSMonitoring_New> createState() => _PSMonitoring_NewState();
}

String? _search = '';
List<PSMonitoringModel>? _DisplyList = <PSMonitoringModel>[];
List<PSMonitoringModel>? displayCopyList = <PSMonitoringModel>[];

String _selectdropdown = 'ALL';
String devStatus = 'All';

var items1 = ['ALL', 'ONLINE', 'OFFLINE'];

class _PSMonitoring_NewState extends State<PSMonitoring_New> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _search = '';
      _DisplyList = [];
    });
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: MyDrawerScreen(),
      appBar: AppBar(
        title: Text(
          "PUMP STATION MONITORING",
          textScaleFactor: 1,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _firstLoad();
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(image: backgroundImage),
              height: size.height,
              width: double.infinity,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _search = value;
                                      });
                                    },
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.go,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        hintText: "Search"),
                                  ),
                                ),
                                IconButton(
                                  splashColor: Colors.blue,
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    setState(() {
                                      if (_search != null &&
                                          _search!.isNotEmpty) {
                                        _DisplyList = displayCopyList!
                                            .where((element) => element
                                                .projectName!
                                                .toLowerCase()
                                                .contains(
                                                    _search!.toLowerCase()))
                                            .toList();
                                      }
                                      _DisplyList = <PSMonitoringModel>[];
                                    });
                                    _firstLoad();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 168, 211, 237),
                          borderRadius: BorderRadius.circular(5)),
                      width: size.width,
                      child: DropdownButton(
                        underline: Container(color: Colors.transparent),
                        isExpanded: true,
                        value: _selectdropdown,
                        items: items1.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Center(
                              child: Text(
                                items,
                                textScaleFactor: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.black900,
                                  fontSize: getFontSize(
                                    11,
                                  ),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? seletedtype) {
                          setState(() {
                            _DisplyList = displayCopyList!.where((element) {
                              if (seletedtype == "ALL") {
                                _selectdropdown = "ALL";
                                setState(() {
                                  devStatus = 'ALL';
                                });
                                return true;
                              } else if (seletedtype == "ONLINE") {
                                _selectdropdown = "ONLINE";
                                setState(() {
                                  devStatus = '1';
                                });
                                return element.status == 1;
                              } else if (seletedtype == "OFFLINE") {
                                _selectdropdown = "OFFLINE";
                                setState(() {
                                  devStatus = '0';
                                });
                                return element.status == 0;
                              }
                              return true;
                            }).toList();
                          });
                          // _firstLoad();
                          //_DisplyList = [];
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(
                                  -0.11693549743786386,
                                  5.232387891851431e-7,
                                ),
                                end: Alignment(
                                  1.016128983862346,
                                  0.8571436124054905,
                                ),
                                colors: [
                                  ColorConstant.lightBlue701,
                                  ColorConstant.cyan302,
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Project Name',
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                  ],
                                )),
                                Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'PumpStation\nStatus',
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                  ],
                                )),
                                Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'LastResponse\nTime',
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  getPSMList(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//for dropdown list
/*
  void _updateDisplayList() {
    _DisplyList = displayCopyList!.where((element) {
      if (_selectdropdown == "ALL") {
        return true;
      } else if (_selectdropdown == "ONLINE") {
        return element.status == 1;
      } else if (_selectdropdown == "OFFLINE") {
        return element.status == 0;
      } else {
        return true;
      }
    }).toList();

    if (_search != null && _search!.isNotEmpty) {
      _DisplyList = displayCopyList!
          .where((element) => element.projectName!
              .toLowerCase()
              .contains(_search!.toLowerCase()))
          .toList();
    }
  }
*/
  getshortdate(pumpLatResponseTime) {
    try {
      final DateTime now = DateTime.parse(pumpLatResponseTime);
      final DateFormat formatter = DateFormat('yyyy-MMM-dd H:m:s');
      final String formatted = formatter.format(now);
      return formatted;
    } catch (_ex) {
      return 'Never Connected';
    }
  }

  getColor(int Status) {
    try {
      if (Status == 1) {
        return Colors.green;
      } else if (Status == 0) {
        return Colors.red[600];
      }
    } catch (_ex) {}
  }

  getPumpName(PSMonitoringModel model) {
    try {
      if (model.projectName!.toLowerCase().contains('garoth') ||
          model.projectName!.toLowerCase().contains('group of scheme') ||
          model.projectName!.toLowerCase().contains('cluster') ||
          model.projectName!.toLowerCase().contains('mohanpura')) {
        return model.deviceName!.toString();
      } else {
        return "PS" + model.pumpStationId!.toString();
      }
    } catch (_ex) {
      // throw Exception("");
      return "PS";
    }
  }

  getPSMList(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        controller: _controller,
        interactive: true,
        thickness: 12,
        thumbVisibility: true,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: _controller,
          child: Container(
            margin: EdgeInsets.only(
                left: getHorizontalSize(
                  8.00,
                ),
                right: getHorizontalSize(
                  8.00,
                ),
                bottom: getVerticalSize(13.00)),
            decoration: BoxDecoration(
              color: ColorConstant.whiteA700,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorConstant.black90026,
                  spreadRadius: getHorizontalSize(
                    2.00,
                  ),
                  blurRadius: getHorizontalSize(
                    2.00,
                  ),
                  offset: Offset(
                    0,
                    2,
                  ),
                ),
              ],
            ),
            width: size.width,
            child: getBody(),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _DisplyList!.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    // decoration: BoxDecoration(color: Colors.blue),
                    width: 100,
                    child: Text(_DisplyList![index].projectName ?? '',
                        textScaleFactor: 1,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Container(
                    // decoration: BoxDecoration(color: Colors.blue),
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        width: 90,
                        decoration: BoxDecoration(
                          color: getColor(_DisplyList![index].status ?? 0),
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                                child: Text(getPumpName(_DisplyList![index])))),
                      ),
                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(color: Colors.blue),
                    width: 100,
                    child: Text(
                      getshortdate(
                          _DisplyList![index].pumpLatResponseTime ?? ''),
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.blueGrey,
            ),
          ],
        );
      },
    );
  }

  final ScrollController _controller = ScrollController();

  _firstLoad() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      int? userid = preferences.getInt('userid');
      final res = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/PumpStation/GetAllPumpStationData?userid=$userid&Search=$_search&State=All&ProjectName=All&DevStatus=$devStatus'));

      print(
          'http://wmsservices.seprojects.in/api/PumpStation/GetAllPumpStationData?userid=$userid&Search=$_search&State=All&ProjectName=All&DevStaus=$devStatus');

      var json = jsonDecode(res.body);
      List<PSMonitoringModel> fetchedData = <PSMonitoringModel>[];
      json.forEach((e) => fetchedData.add(new PSMonitoringModel.fromJson(e)));
      _DisplyList = [];
      if (fetchedData.length > 0) {
        setState(() {
          _DisplyList!.addAll(fetchedData);
          displayCopyList!.addAll(fetchedData);
        });
      }
    } catch (err) {
      print('Something went wrong');
      return null;
    }
  }
}
