// ignore_for_file: unnecessary_null_comparison, camel_case_types, non_constant_identifier_names, must_be_immutable, unused_catch_stack

import 'dart:convert';
import 'package:WMS_Application/Model/Project/OmsMasterModel.dart';
import 'package:WMS_Application/Model/Project/ScheduleMasterModel.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:WMS_Application/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

OmsMasterModel? modelData;

class Schedule_Screen extends StatefulWidget {
  String? ProjectName;

  Schedule_Screen(String project, OmsMasterModel? _modelData) {
    ProjectName = project;
    modelData = _modelData ?? null;
  }
  @override
  State<Schedule_Screen> createState() => _Schedule_ScreenState();
}

class _Schedule_ScreenState extends State<Schedule_Screen> {
  var pfcmdno = 1;
  int dropdownvalue = 1;
  List<int> items = [];
  var showcdate = true;
  var showydata = true;

  List<ScheduleMasterModel>? _DisplayList = <ScheduleMasterModel>[];
  var cdate = DateFormat("EE dd-MMM-yyyy").format(DateTime.now());
  var ydate = DateFormat("EE dd-MMM-yyyy")
      .format(DateTime.now().subtract(Duration(days: 1)));
  List<DateTime> DateList = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      _DisplayList = [];
      items = new List<int>.generate(modelData!.subChakQty!, (i) => i + 1);

      DateList = new List<DateTime>.generate(
          8, (index) => DateTime.now().add(Duration(days: index - 1)));
    });
    _firstLoad();
  }

  /*@override
  void dispose() {
    super.dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        drawer: MyDrawerScreen(),
        appBar: AppBar(
            title: Text(
              widget.ProjectName! + '-OMS Schedule'.toUpperCase(),
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(color: Colors.lightBlue),
            ),
            leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
            )),
        body: Container(
          height: size.height,
          decoration: BoxDecoration(image: backgroundImage),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ///Chak No. & Sub Chak No.
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ///Chak No
                          Container(
                            width: 160,
                            height: 47,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Chak No : ",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorConstant.black900,
                                          fontSize: getFontSize(
                                            12,
                                          ),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        modelData!.chakNo.toString(),
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
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Khasara No : ",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorConstant.black900,
                                          fontSize: getFontSize(
                                            12,
                                          ),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        (modelData!.khasaraNo ?? '-')
                                            .toString(),
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          ///Sub Chak No.
                          Container(
                            width: 150,
                            child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "PFCMD NO :",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorConstant.black900,
                                      fontSize: getFontSize(
                                        11,
                                      ),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  DropdownButton(
                                    value: dropdownvalue,
                                    icon: Icon(Icons.arrow_drop_down),
                                    items: items.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                        pfcmdno = newValue;
                                        _firstLoad();
                                      });
                                    },
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                for (var item in DateList)
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      child: Column(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: getColor(item.toString()),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border(
                                              top: BorderSide(
                                                  width: 0.2,
                                                  color: Colors.black),
                                              bottom: BorderSide(
                                                  width: 0.2,
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  width: 0.2,
                                                  color: Colors.black),
                                              left: BorderSide(
                                                  width: 0.2,
                                                  color: Colors.black),
                                            )),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              getshortdate(item.toString()),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'TIME :-',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(getScheduleTime(item)),
                                                  ],
                                                )),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getScheduleTime(DateTime? itemDateVal) {
    try {
      DateTime now = itemDateVal!;
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String itemDate = formatter.format(now);
      ScheduleMasterModel model = _DisplayList!.singleWhere((element) =>
          formatter.format(DateTime.parse(element.date!)) == itemDate);
      if (model != null)
        return model.startTime! +
            " TO " +
            (model.endTime == '00:00' ? '24:00' : model.endTime!);
      else
        throw new Exception();
    } catch (_, e) {
      return "NaN";
    }

    // something like 2013-04-20
  }

  void _firstLoad() async {
    try {
      var omsid = modelData!.omsId;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? conString = preferences.getString('conString');

      final res = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/OMS/GetOMSScheduleData?OmsId=$omsid&PFCMDNo=$pfcmdno&conString=$conString'));

      print(
          'http://wmsservices.seprojects.in/api/OMS/GetOMSScheduleData?OmsId=$omsid&PFCMDNo=$pfcmdno&conString=$conString');

      var json = jsonDecode(res.body);
      List<ScheduleMasterModel> fetchedData = <ScheduleMasterModel>[];
      json.forEach((e) => fetchedData.add(new ScheduleMasterModel.fromJson(e)));
      _DisplayList = [];
      if (fetchedData.length > 0) {
        setState(() {
          _DisplayList!.addAll(fetchedData);
        });
      }
    } catch (err) {
      print('Something went wrong');
    }
  }

  getshortdate(String date) {
    final DateTime now = DateTime.parse(date);
    final DateFormat formatter = DateFormat('EEE dd-MMM-y');
    final String formatted = formatter.format(now);
    return formatted;
  }

  getColor(String date) {
    var ldate = getshortdate(date);
    try {
      if (ldate == cdate) {
        return Colors.lightBlue[400];
      }
      /*else if (ldate == ydate) {
        return Colors.orangeAccent[400];
      }*/
      else {
        return Colors.grey[300];
      }
    } catch (e, _) {
      return Colors.red;
    }
  }

  // getScheduleid(DateTime? date) {
  //   try {
  //     DateTime now = date!;
  //     DateFormat formatter = DateFormat('yyyy-MM-dd');
  //     String itemDate = formatter.format(now);
  //     ScheduleMasterModel model = _DisplayList!.singleWhere((element) =>
  //         formatter.format(DateTime.parse(element.date!)) == itemDate);
  //     if (model != null)
  //       return model.id;
  //     else
  //       throw new Exception();
  //   } catch (_, e) {
  //     return "NaN";
  //   }
  // }
}
