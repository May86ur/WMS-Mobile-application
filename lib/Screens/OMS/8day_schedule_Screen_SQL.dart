// ignore_for_file: unnecessary_null_comparison, camel_case_types, non_constant_identifier_names, must_be_immutable, unused_catch_stack

import 'dart:convert';
import 'package:WMS_Application/Model/Project/OmsSqlMasterModel.dart';
import 'package:WMS_Application/Model/Project/ScheduleSQLMasterModel.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:WMS_Application/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

OmsSqlMasterModel? modelData;

class Schedule_Screen_SQL extends StatefulWidget {
  String? ProjectName;

  Schedule_Screen_SQL(String project, OmsSqlMasterModel? _modelData) {
    ProjectName = project;
    modelData = _modelData ?? null;
  }
  @override
  State<Schedule_Screen_SQL> createState() => _Schedule_Screen_SQLState();
}

class _Schedule_Screen_SQLState extends State<Schedule_Screen_SQL> {
  var pfcmdno = 1;
  int dropdownvalue = 1;
  List<int> items = [];
  var showcdate = true;
  var showydata = true;

  List<ScheduleSQLMasterModel>? _DisplayList = <ScheduleSQLMasterModel>[];
  var cdate = DateFormat("EE dd-MMM-yyyy").format(DateTime.now());
  var ydate = DateFormat("EE dd-MMM-yyyy")
      .format(DateTime.now().subtract(Duration(days: 1)));
  List<DateTime> DateList = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      _DisplayList = [];
      dateList = Set();
      items = new List<int>.generate(modelData!.onOffValvesQty!, (i) => i + 1);

      // DateList = new List<DateTime>.generate(
      //     8, (index) => DateTime.now().add(Duration(days: index - 1)));
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
          width: double.infinity,
          decoration: BoxDecoration(image: backgroundImage),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                /*              ///Chak No. & Sub Chak No.
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ///Chak No
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Chak No : ",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorConstant.black900,
                                fontSize: 12,
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
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Khasara No
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Khasara No : ",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorConstant.black900,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                (modelData!.subArea ?? '-').toString(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: TextStyle(
                                  color: ColorConstant.black900,
                                  fontSize: 11,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorConstant.whiteA700,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Row(children: [
                              Text(
                                "Chak No : ",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.black900,
                                  fontSize: 12,
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
                                  fontSize: 11,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "Khasara No : ",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  (modelData!.subArea ?? '-').toString(),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: 11,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                ),
                for (var item in dateList!)
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
                                      ///Date
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

                                      GetScheduleTime(_DisplayList!
                                          .where((element) =>
                                              element.irriDate == item)
                                          .toList()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget GetScheduleTime(List<ScheduleSQLMasterModel> list) {
    try {
      if (list != null) {
        return

            ///Sechedule Time
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: getColorSchedule(
                              list.elementAt(index).irriDate!.toString()),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      // height: 10,
                      // width: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Valve Pair: '),
                                Text(list.elementAt(index).displayStr!)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Start Time: '),
                                Text(list.elementAt(index).startTime!)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("End Time: "),
                                Text(list.elementAt(index).endTime!)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                  ),
                )

                /*Column(children: [
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
                                        ]),*/
                );
      } else if (list == null) {
        return Container(
          child: Text('No data Found'),
        );
      } else
        throw new Exception();
    } catch (_, ex) {
      return Container();
    }
  }

/*
  String getScheduleTime(DateTime? itemDateVal) {
    try {
      DateTime now = itemDateVal!;
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String itemDate = formatter.format(now);
      ScheduleSQLMasterModel model = _DisplayList!.singleWhere((element) =>
          formatter.format(DateTime.parse(element.irriDate!)) == itemDate);
      if (model != null)
        return model.startTime! + " TO " + model.endTime!;
      else
        throw new Exception();
    } catch (_, e) {
      return "NaN";
    }

    // something like 2013-04-20
  }
*/
  Set<String>? dateList;
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
      List<ScheduleSQLMasterModel> fetchedData = <ScheduleSQLMasterModel>[];
      json.forEach(
          (e) => fetchedData.add(new ScheduleSQLMasterModel.fromJson(e)));
      _DisplayList = [];
      if (fetchedData.length > 0) {
        setState(() {
          dateList = Set();
          _DisplayList!.addAll(fetchedData);
          fetchedData.forEach((element) => dateList!.add(element.irriDate!));
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
      } /*else if (ldate == ydate) {
        return Colors.orangeAccent[400];
      }*/
      else {
        return Colors.grey[300];
      }
    } catch (e, _) {
      return Colors.red;
    }
  }

  getColorSchedule(String date) {
    var ldate = getshortdate(date);

    try {
      if (ldate == cdate) {
        return Colors.lightBlue[400];
      } /*else if (ldate == ydate) {
        return Colors.green[400];
      } */
      else {
        return Colors.orangeAccent[400];
      }
    } catch (e, _) {
      return Colors.red;
    }
  }
}
