// ignore_for_file: must_be_immutable, camel_case_types, non_constant_identifier_names, unused_element, unnecessary_null_comparison, unused_catch_stack, unused_local_variable, prefer_const_constructors, deprecated_member_use

import 'dart:convert';
import 'package:water_management_system/Model/Project/OMS_Overview_model.dart';
import 'package:water_management_system/Model/Project/OmsMasterModel.dart';
import 'package:water_management_system/Operations/StateselectionOperation.dart';
import 'package:water_management_system/Screens/Login/MyDrawerScreen.dart';
import 'package:water_management_system/Screens/OMS/8days_schedule_screen.dart';
import 'package:water_management_system/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/Project/RMSMastermodel.dart';
import '../RMS/RMS_Details_Screen.dart';

List<OmsMasterModel>? modelData = [];
List<OmsMasterModel>? _DisplayList = <OmsMasterModel>[];

int index = 0;
var _search = '';

var cheklist = ['All'];
int _page = 0;
int _limit = 20;
bool showButton = false;
bool _hasNextPage = true;

var _isFirstLoadRunning = false;

class PFCMD10_Details_Screen extends StatefulWidget {
  String? ProjectName;

  PFCMD10_Details_Screen(
      List<OmsMasterModel>? _modelData, String project, int _index,
      {super.key}) {
    modelData = _modelData;
    ProjectName = project;
    index = _index;
  }

  @override
  State<PFCMD10_Details_Screen> createState() => _PFCMD10_Details_ScreenState();
}

class _PFCMD10_Details_ScreenState extends State<PFCMD10_Details_Screen> {
  // Initial Selected Value
  var area = 'All';
  var distibutory = 'ALL';
  String? OMSStatusCheck = 'ALL';
  String? DamageStatusCheck = 'ALL';
  @override
  Widget build(BuildContext context) {
    double height = 400;
    double width = 200;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const MyDrawerScreen(),
        appBar: AppBar(
            title: Text(
              '${widget.ProjectName!.toString().replaceAll("_", " ").toUpperCase()} - OMS',
              textScaleFactor: 1,
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(color: Colors.lightBlue),
            ),
            leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
            )),
        body: RefreshIndicator(
          onRefresh: () async {
            modelData;
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(image: backgroundImage),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Container(
                    // elevation: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///Heading
                        Container(
                          alignment: Alignment.center,
                          height: 25.00,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: (modelData![index].oNLINE == "ON"
                                ? Colors.green
                                : Colors.red),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Text(
                                modelData![index].chakNo1.toString(),
                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(right: 10),
                              //   child: Image(
                              //     fit: BoxFit.fitHeight,
                              //     image:
                              //         AssetImage("assets/images/reload.png"),
                              //     width: 25,
                              //     height: 25,
                              //   ),
                              // ),
                              IconButton(
                                  color: Colors.white,
                                  iconSize: 30,
                                  padding:
                                      const EdgeInsets.only(bottom: 1, left: 5),
                                  alignment: Alignment.center,
                                  onPressed: () async {
                                    await _reload();
                                    getpop(context);
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      Navigator.pop(context); //pop dialog
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.refresh,
                                  ))
                            ],
                          ),
                        ),

                        ///Icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ///Navigation
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: InkWell(
                                onTap: () {
                                  openMap(
                                      modelData![index].coordinates.toString());
                                },
                                child: const Image(
                                  height: 25,
                                  width: 25,
                                  image: AssetImage(
                                      'assets/images/navigation2.png'),
                                ),
                              ),
                            )
                          ],
                        ),

                        ///Chak No.
                        getNodeDetails(),

                        ///PFCMD diagram
                        getPFCDMDDiagram(height, width),

                        const SizedBox(
                          height: 17,
                        ),

                        ///Table Data

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ///PFCMD
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.880,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: const Alignment(
                                        -0.11693549743786386,
                                        5.232387891851431e-7,
                                      ),
                                      end: const Alignment(
                                        1.016128983862346,
                                        0.8571436124054905,
                                      ),
                                      colors: [
                                        Colors.lightBlue.shade700,
                                        Colors.cyan.shade300,
                                      ],
                                    ),
                                    // Color.fromARGB(255, 235, 232, 169),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        width: 60,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: Text(
                                            'VALVE\nDETAILS',
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      if ((modelData![index].subChakQty ?? 0) >=
                                          1)
                                        const SizedBox(
                                          width: 45,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              'PFCMD1',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      if ((modelData![index].subChakQty ?? 0) >=
                                          2)
                                        const SizedBox(
                                          width: 45,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              'PFCMD2',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      if ((modelData![index].subChakQty ?? 0) >=
                                          3)
                                        const SizedBox(
                                          width: 45,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              'PFCMD3',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      if ((modelData![index].subChakQty ?? 0) >=
                                          4)
                                        const SizedBox(
                                          width: 45,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              'PFCMD4',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      if ((modelData![index].subChakQty ?? 0) >=
                                          5)
                                        const SizedBox(
                                          width: 45,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              'PFCMD5',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      if ((modelData![index].subChakQty ?? 0) >=
                                          6)
                                        const SizedBox(
                                          width: 45,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              'PFCMD6',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                ///PT
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(),
                                          width: 70,
                                          child: const Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "PT (m)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  convertBartoMeter(
                                                          modelData![index]
                                                                  .pT2Valve1 ??
                                                              0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  convertBartoMeter(
                                                          modelData![index]
                                                                  .pT2Valve2 ??
                                                              0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  convertBartoMeter(
                                                          modelData![index]
                                                                  .pT2Valve3 ??
                                                              0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  convertBartoMeter(
                                                          modelData![index]
                                                                  .pT2Valve4 ??
                                                              0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  convertBartoMeter(
                                                          modelData![index]
                                                                  .pT2Valve5 ??
                                                              0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  convertBartoMeter(
                                                          modelData![index]
                                                                  .pT2Valve6 ??
                                                              0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///POS
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Position(%)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index]
                                                              .posValve1 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index]
                                                              .posValve2 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index]
                                                              .posValve3 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index]
                                                              .posValve4 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index]
                                                              .posValve5 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index]
                                                              .posValve6 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///POS SET
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Pos Set\n Point (%)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index].posSetPt1 ==
                                                          null
                                                      ? "0.0"
                                                      : modelData![index]
                                                          .posSetPt1
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index].posSetPt2 ==
                                                          null
                                                      ? "0.0"
                                                      : modelData![index]
                                                          .posSetPt2
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index].posSetPt3 ==
                                                          null
                                                      ? "0.0"
                                                      : modelData![index]
                                                          .posSetPt3
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index].posSetPt4 ==
                                                          null
                                                      ? "0.0"
                                                      : modelData![index]
                                                          .posSetPt4
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index].posSetPt5 ==
                                                          null
                                                      ? "0.0"
                                                      : modelData![index]
                                                          .posSetPt5
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index].posSetPt6 ==
                                                          null
                                                      ? "0.0"
                                                      : modelData![index]
                                                          .posSetPt6
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///FLOW
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Flow(LPS)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  (modelData![index]
                                                                  .flowValve1 !=
                                                              null
                                                          ? convertm3hrToLps(
                                                              modelData![index]
                                                                  .flowValve1!)
                                                          : 0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  (modelData![index]
                                                                  .flowValve2 !=
                                                              null
                                                          ? convertm3hrToLps(
                                                              modelData![index]
                                                                  .flowValve2!)
                                                          : 0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  (modelData![index]
                                                                  .flowValve3 !=
                                                              null
                                                          ? convertm3hrToLps(
                                                              modelData![index]
                                                                  .flowValve3!)
                                                          : 0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  (modelData![index]
                                                                  .flowValve4 !=
                                                              null
                                                          ? convertm3hrToLps(
                                                              modelData![index]
                                                                  .flowValve4!)
                                                          : 0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  (modelData![index]
                                                                  .flowValve5 !=
                                                              null
                                                          ? convertm3hrToLps(
                                                              modelData![index]
                                                                  .flowValve5!)
                                                          : 0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  (modelData![index]
                                                                  .flowValve6 !=
                                                              null
                                                          ? convertm3hrToLps(
                                                              modelData![index]
                                                                  .flowValve6!)
                                                          : 0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///FLOW SET
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Flow Set\nPoint(lps)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index]
                                                              .flowSetPt1 ==
                                                          null
                                                      ? "0.0"
                                                      : convertm3hrToLps(
                                                              modelData![index]
                                                                  .flowSetPt1)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index]
                                                              .flowSetPt2 ==
                                                          null
                                                      ? "0.0"
                                                      : convertm3hrToLps(
                                                              modelData![index]
                                                                  .flowSetPt2)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index]
                                                              .flowSetPt3 ==
                                                          null
                                                      ? "0.0"
                                                      : convertm3hrToLps(
                                                              modelData![index]
                                                                  .flowSetPt3)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index]
                                                              .flowSetPt4 ==
                                                          null
                                                      ? "0.0"
                                                      : convertm3hrToLps(
                                                              modelData![index]
                                                                  .flowSetPt4)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index]
                                                              .flowSetPt5 ==
                                                          null
                                                      ? "0.0"
                                                      : convertm3hrToLps(
                                                              modelData![index]
                                                                  .flowSetPt5)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index]
                                                              .flowSetPt6 ==
                                                          null
                                                      ? "0.0"
                                                      : convertm3hrToLps(
                                                              modelData![index]
                                                                  .flowSetPt6)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///VOL
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Vol(m³)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index]
                                                              .volValve1 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index]
                                                              .volValve2 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index]
                                                              .volValve3 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index]
                                                              .volValve4 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index]
                                                              .volValve5 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index]
                                                              .volValve6 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///PR-SUS
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Pr-Sus(m)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index]
                                                              .sustPress1 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![index]
                                                                  .sustPress1)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      //TODO
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index]
                                                              .sustPress2 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![index]
                                                                  .sustPress2)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index]
                                                              .sustPress3 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![index]
                                                                  .sustPress3)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index]
                                                              .sustPress4 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![index]
                                                                  .sustPress4)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index]
                                                              .sustPress5 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![index]
                                                                  .sustPress5)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index]
                                                              .sustPress6 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![index]
                                                                  .sustPress6)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///PR-RED
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Pr-Red(m)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index].redPress1 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![index]
                                                                  .redPress1)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index].redPress2 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![index]
                                                                  .redPress2)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index].redPress3 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![index]
                                                                  .redPress3)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index].redPress4 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![index]
                                                                  .redPress4)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index].redPress5 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![index]
                                                                  .redPress5)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index].redPress6 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![index]
                                                                  .redPress6)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///Schedule
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Schedule\nPresent/abs",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index]
                                                      .schedule
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Text(
                                                  modelData![index]
                                                      .schedule
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index]
                                                      .schedule
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Text(
                                                  modelData![index]
                                                      .schedule
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Text(
                                                  modelData![index]
                                                      .schedule
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Text(
                                                  modelData![index]
                                                      .schedule
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///Irrigation Status
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Irrigation\nStatus",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, left: 2),
                                                child: Text(
                                                  getIrrigationStatus(
                                                      modelData![index].sIRR1 ??
                                                          0),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, left: 2),
                                                child: Text(
                                                  getIrrigationStatus(
                                                      modelData![index].sIRR2 ??
                                                          0),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, left: 2),
                                                child: Text(
                                                  getIrrigationStatus(
                                                      modelData![index].sIRR3 ??
                                                          0),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, left: 2),
                                                child: Text(
                                                  getIrrigationStatus(
                                                      modelData![index].sIRR4 ??
                                                          0),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, left: 2),
                                                child: Text(
                                                  getIrrigationStatus(
                                                      modelData![index].sIRR5 ??
                                                          0),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, left: 2),
                                                child: Text(
                                                  getIrrigationStatus(
                                                      modelData![index].sIRR6 ??
                                                          0),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ///PFCMD
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.880,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: const Alignment(
                                        -0.11693549743786386,
                                        5.232387891851431e-7,
                                      ),
                                      end: const Alignment(
                                        1.016128983862346,
                                        0.8571436124054905,
                                      ),
                                      colors: [
                                        Colors.lightBlue.shade700,
                                        Colors.cyan.shade300,
                                      ],
                                    ),
                                    // Color.fromARGB(255, 235, 232, 169),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        width: 60,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: Text(
                                            'VALVE\nDETAILS',
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      if ((modelData![index + 1].subChakQty ??
                                              0) >=
                                          1)
                                        const SizedBox(
                                          width: 45,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              'PFCMD1',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      if ((modelData![index + 1].subChakQty ??
                                              0) >=
                                          2)
                                        const SizedBox(
                                          width: 45,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              'PFCMD2',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      if ((modelData![index + 1].subChakQty ??
                                              0) >=
                                          3)
                                        const SizedBox(
                                          width: 45,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              'PFCMD3',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      if ((modelData![index + 1].subChakQty ??
                                              0) >=
                                          4)
                                        const SizedBox(
                                          width: 45,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              'PFCMD4',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      if ((modelData![index + 1].subChakQty ??
                                              0) >=
                                          5)
                                        const SizedBox(
                                          width: 45,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              'PFCMD5',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      if ((modelData![index + 1].subChakQty ??
                                              0) >=
                                          6)
                                        const SizedBox(
                                          width: 45,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Text(
                                              'PFCMD6',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                ///PT
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(),
                                          width: 70,
                                          child: const Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "PT (m)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  convertBartoMeter(
                                                          modelData![index + 1]
                                                                  .pT2Valve1 ??
                                                              0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  convertBartoMeter(
                                                          modelData![index + 1]
                                                                  .pT2Valve2 ??
                                                              0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  convertBartoMeter(
                                                          modelData![index + 1]
                                                                  .pT2Valve3 ??
                                                              0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  convertBartoMeter(
                                                          modelData![index + 1]
                                                                  .pT2Valve4 ??
                                                              0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  convertBartoMeter(
                                                          modelData![index + 1]
                                                                  .pT2Valve5 ??
                                                              0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  convertBartoMeter(
                                                          modelData![index + 1]
                                                                  .pT2Valve6 ??
                                                              0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///POS
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Position(%)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index + 1]
                                                              .posValve1 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index + 1]
                                                              .posValve2 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index + 1]
                                                              .posValve3 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index + 1]
                                                              .posValve4 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index + 1]
                                                              .posValve5 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index + 1]
                                                              .posValve6 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///POS SET
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Pos Set\n Point (%)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .posSetPt1 ==
                                                          null
                                                      ? "0.0"
                                                      : modelData![index + 1]
                                                          .posSetPt1
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .posSetPt2 ==
                                                          null
                                                      ? "0.0"
                                                      : modelData![index + 1]
                                                          .posSetPt2
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .posSetPt3 ==
                                                          null
                                                      ? "0.0"
                                                      : modelData![index + 1]
                                                          .posSetPt3
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .posSetPt4 ==
                                                          null
                                                      ? "0.0"
                                                      : modelData![index + 1]
                                                          .posSetPt4
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .posSetPt5 ==
                                                          null
                                                      ? "0.0"
                                                      : modelData![index + 1]
                                                          .posSetPt5
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .posSetPt6 ==
                                                          null
                                                      ? "0.0"
                                                      : modelData![index + 1]
                                                          .posSetPt6
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///FLOW
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Flow(LPS)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  (modelData![index + 1]
                                                                  .flowValve1 !=
                                                              null
                                                          ? convertm3hrToLps(
                                                              modelData![
                                                                      index + 1]
                                                                  .flowValve1!)
                                                          : 0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  (modelData![index + 1]
                                                                  .flowValve2 !=
                                                              null
                                                          ? convertm3hrToLps(
                                                              modelData![
                                                                      index + 1]
                                                                  .flowValve2!)
                                                          : 0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  (modelData![index + 1]
                                                                  .flowValve3 !=
                                                              null
                                                          ? convertm3hrToLps(
                                                              modelData![
                                                                      index + 1]
                                                                  .flowValve3!)
                                                          : 0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  (modelData![index + 1]
                                                                  .flowValve4 !=
                                                              null
                                                          ? convertm3hrToLps(
                                                              modelData![
                                                                      index + 1]
                                                                  .flowValve4!)
                                                          : 0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  (modelData![index + 1]
                                                                  .flowValve5 !=
                                                              null
                                                          ? convertm3hrToLps(
                                                              modelData![
                                                                      index + 1]
                                                                  .flowValve5!)
                                                          : 0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  (modelData![index + 1]
                                                                  .flowValve6 !=
                                                              null
                                                          ? convertm3hrToLps(
                                                              modelData![
                                                                      index + 1]
                                                                  .flowValve6!)
                                                          : 0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///FLOW SET
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Flow Set\nPoint(lps)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .flowSetPt1 ==
                                                          null
                                                      ? "0.0"
                                                      : convertm3hrToLps(
                                                              modelData![
                                                                      index + 1]
                                                                  .flowSetPt1)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .flowSetPt2 ==
                                                          null
                                                      ? "0.0"
                                                      : convertm3hrToLps(
                                                              modelData![
                                                                      index + 1]
                                                                  .flowSetPt2)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .flowSetPt3 ==
                                                          null
                                                      ? "0.0"
                                                      : convertm3hrToLps(
                                                              modelData![
                                                                      index + 1]
                                                                  .flowSetPt3)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .flowSetPt4 ==
                                                          null
                                                      ? "0.0"
                                                      : convertm3hrToLps(
                                                              modelData![
                                                                      index + 1]
                                                                  .flowSetPt4)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .flowSetPt5 ==
                                                          null
                                                      ? "0.0"
                                                      : convertm3hrToLps(
                                                              modelData![
                                                                      index + 1]
                                                                  .flowSetPt5)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                ),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .flowSetPt6 ==
                                                          null
                                                      ? "0.0"
                                                      : convertm3hrToLps(
                                                              modelData![
                                                                      index + 1]
                                                                  .flowSetPt6)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///VOL
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Vol(m³)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index + 1]
                                                              .volValve1 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index + 1]
                                                              .volValve2 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index + 1]
                                                              .volValve3 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index + 1]
                                                              .volValve4 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index + 1]
                                                              .volValve5 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  (modelData![index + 1]
                                                              .volValve6 ??
                                                          0.0)
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///PR-SUS
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Pr-Sus(m)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .sustPress1 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![
                                                                      index + 1]
                                                                  .sustPress1)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      //TODO
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .sustPress2 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![
                                                                      index + 1]
                                                                  .sustPress2)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .sustPress3 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![
                                                                      index + 1]
                                                                  .sustPress3)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .sustPress4 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![
                                                                      index + 1]
                                                                  .sustPress4)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .sustPress5 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![
                                                                      index + 1]
                                                                  .sustPress5)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .sustPress6 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![
                                                                      index + 1]
                                                                  .sustPress6)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///PR-RED
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Pr-Red(m)",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .redPress1 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![
                                                                      index + 1]
                                                                  .redPress1)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .redPress2 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![
                                                                      index + 1]
                                                                  .redPress2)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .redPress3 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![
                                                                      index + 1]
                                                                  .redPress3)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .redPress4 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![
                                                                      index + 1]
                                                                  .redPress4)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .redPress5 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![
                                                                      index + 1]
                                                                  .redPress5)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                              .redPress6 ==
                                                          null
                                                      ? "0.0"
                                                      : convertBartoMeter(
                                                              modelData![
                                                                      index + 1]
                                                                  .redPress6)
                                                          .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///Schedule
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Schedule\nPresent/abs",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                      .schedule
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Text(
                                                  modelData![index + 1]
                                                      .schedule
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: Text(
                                                  modelData![index + 1]
                                                      .schedule
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Text(
                                                  modelData![index + 1]
                                                      .schedule
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Text(
                                                  modelData![index + 1]
                                                      .schedule
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                child: Text(
                                                  modelData![index + 1]
                                                      .schedule
                                                      .toString(),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                ),

                                ///Irrigation Status
                                Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 168, 211, 237),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Irrigation\nStatus",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            1)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, left: 2),
                                                child: Text(
                                                  getIrrigationStatus(
                                                      modelData![index + 1]
                                                              .sIRR1 ??
                                                          0),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            2)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, left: 2),
                                                child: Text(
                                                  getIrrigationStatus(
                                                      modelData![index + 1]
                                                              .sIRR2 ??
                                                          0),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            3)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, left: 2),
                                                child: Text(
                                                  getIrrigationStatus(
                                                      modelData![index + 1]
                                                              .sIRR3 ??
                                                          0),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            4)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, left: 2),
                                                child: Text(
                                                  getIrrigationStatus(
                                                      modelData![index + 1]
                                                              .sIRR4 ??
                                                          0),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            5)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, left: 2),
                                                child: Text(
                                                  getIrrigationStatus(
                                                      modelData![index + 1]
                                                              .sIRR5 ??
                                                          0),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                        if ((modelData![index + 1].subChakQty ??
                                                0) >=
                                            6)
                                          SizedBox(
                                            width: 48,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15, left: 2),
                                                child: Text(
                                                  getIrrigationStatus(
                                                      modelData![index + 1]
                                                              .sIRR6 ??
                                                          0),
                                                  textScaleFactor: 1,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                      ]),
                                )
                              ],
                            )
                          ],
                        ),

                        // Button
                        Padding(
                          padding: EdgeInsets.only(
                            top: 9.00,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ///Interogate
                              if (showButton == true)
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              child: const AlertDialog(
                                                  title: Center(
                                                      child: Text(
                                                    'Interrogate',
                                                    textScaleFactor: 1,
                                                  )),
                                                  content: SizedBox(
                                                    height: 100,
                                                    child: Center(
                                                      child: Text(
                                                        "Page Under Development",
                                                        textScaleFactor: 1,
                                                      ),
                                                    ),
                                                  )));
                                        });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 70.77,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: const Alignment(
                                          -0.11693549743786386,
                                          5.232387891851431e-7,
                                        ),
                                        end: const Alignment(
                                          1.016128983862346,
                                          0.8571436124054905,
                                        ),
                                        colors: [
                                          Colors.lightBlue.shade700,
                                          Colors.cyan.shade300,
                                        ],
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: Text(
                                      "INTERROGATE",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),

                              ///Refresh
                              if (showButton == true)
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              child: const AlertDialog(
                                                  title: Center(
                                                      child: Text(
                                                    'REFRESH',
                                                    textScaleFactor: 1,
                                                  )),
                                                  content: SizedBox(
                                                    height: 100,
                                                    child: Center(
                                                      child: Text(
                                                        "Page Under Development",
                                                        textScaleFactor: 1,
                                                      ),
                                                    ),
                                                  )));
                                        });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 70.77,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: const Alignment(
                                          -0.11693549743786386,
                                          5.232387891851431e-7,
                                        ),
                                        end: const Alignment(
                                          1.016128983862346,
                                          0.8571436124054905,
                                        ),
                                        colors: [
                                          Colors.lightBlue.shade700,
                                          Colors.cyan.shade300,
                                        ],
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: Text(
                                      "REFRESH",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),

                              ///Irrigation Start/Stop
                              if (showButton == true)
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              child: const AlertDialog(
                                                  title: Center(
                                                      child: Text(
                                                    'Irrigation Start/Stop',
                                                    textScaleFactor: 1,
                                                  )),
                                                  content: SizedBox(
                                                    height: 100,
                                                    child: Center(
                                                      child: Text(
                                                        "Page Under Development",
                                                        textScaleFactor: 1,
                                                      ),
                                                    ),
                                                  )));
                                        });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 70.77,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: const Alignment(
                                          -0.11693549743786386,
                                          5.232387891851431e-7,
                                        ),
                                        end: const Alignment(
                                          1.016128983862346,
                                          0.8571436124054905,
                                        ),
                                        colors: [
                                          Colors.lightBlue.shade700,
                                          Colors.cyan.shade300,
                                        ],
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: Text(
                                      "Irrigation \nStart/Stop",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),

                              // ///8 days Schedule
                              InkWell(
                                onTap: (() {
                                  if (widget.ProjectName!
                                      .toLowerCase()
                                      .contains('hanuman')) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              child: const AlertDialog(
                                                  title: Center(
                                                      child: Text(
                                                    '8 Days Schedule',
                                                    textScaleFactor: 1,
                                                  )),
                                                  content: SizedBox(
                                                    height: 100,
                                                    child: Center(
                                                      child: Text(
                                                        "Page Under Development",
                                                        textScaleFactor: 1,
                                                      ),
                                                    ),
                                                  )));
                                        });
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Schedule_Screen(
                                                    widget.ProjectName!,
                                                    modelData![index])));
                                  }
                                }),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 27.00,
                                  width: 70.77,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: const Alignment(
                                        -0.11693549743786386,
                                        5.232387891851431e-7,
                                      ),
                                      end: const Alignment(
                                        1.016128983862346,
                                        0.8571436124054905,
                                      ),
                                      colors: [
                                        Colors.lightBlue.shade700,
                                        Colors.cyan.shade300,
                                      ],
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  child: Text(
                                    "8 DAYS\nSCHEDULE",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),

                              ///RMS Details
                              InkWell(
                                onTap: () async {
                                  if (widget.ProjectName!
                                      .toLowerCase()
                                      .contains('hanuman')) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              child: const AlertDialog(
                                                  title: Center(
                                                      child: Text(
                                                    'RMS Details',
                                                    textScaleFactor: 1,
                                                  )),
                                                  content: SizedBox(
                                                    height: 100,
                                                    child: Center(
                                                      child: Text(
                                                        "Page Under Development",
                                                        textScaleFactor: 1,
                                                      ),
                                                    ),
                                                  )));
                                        });
                                  } else {
                                    await getRmsData(modelData![index].rmsId!,
                                            modelData![index].rmsNo!)
                                        .then((value) {
                                      if (value != null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RMS_Details_Screen(value,
                                                        widget.ProjectName!)));
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 27.00,
                                  width: 70.77,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: const Alignment(
                                        -0.11693549743786386,
                                        5.232387891851431e-7,
                                      ),
                                      end: const Alignment(
                                        1.016128983862346,
                                        0.8571436124054905,
                                      ),
                                      colors: [
                                        Colors.lightBlue.shade700,
                                        Colors.cyan.shade300,
                                      ],
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  child: Text(
                                    "RMS Details",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 6.00,
                                top: 13.00,
                              ),
                              child: Text(
                                "LAST RESPONSE TIME :",
                                textScaleFactor: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 9,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 13.00, left: 3.00),
                              child:
                                  modelData![index].lastResponseTime1!.length !=
                                          null
                                      ? Text(
                                          getlongDate(modelData![index]
                                              .lastResponseTime1!
                                              .toString()),
                                          textScaleFactor: 1,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : const Text("Never Connected",
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),

                        ///Last response time
                        Padding(
                          padding: EdgeInsets.only(
                            left: 6.00,
                            top: 13.00,
                            bottom: 3.00,
                            right: 10.00,
                          ),
                          child: Text(
                            "LAST ROUTINE CHECK DONE ON :",
                            textScaleFactor: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 9,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getNodeDetails() {
    try {
      if (widget.ProjectName!.toLowerCase().contains('hanuman')) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: SizedBox(
                  // width: 190,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Distributory : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                          Text(
                            (modelData![index].distributaryName ?? '-')
                                .toString(),
                            textScaleFactor: 1,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Chak Area : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "${modelData![index].chakArea ?? 0.0} HA",
                            textScaleFactor: 1,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Solar Voltage : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData![index].solarVoltage ?? 0.0)
                                    .toStringAsFixed(2) +
                                " V",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                color: getSolarColor(
                                    (modelData![index].solarVoltage ?? 0.0)),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(children: [
                        const Text(
                          'Design Press : ',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.normal),
                        ),
                        Text(
                          (modelData![index].availableResidualHead ?? 0.0)
                                  .toStringAsFixed(2) +
                              " m",
                          textScaleFactor: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      ]),
                      Row(
                        children: [
                          const Text(
                            'Inlet Press : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "${convertBartoMeter(modelData![index].aI1) ?? 0.0} m",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: modelData![index].aI1 != 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Sus Press : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData![index].sustPress1 ?? 0.0)
                                    .toStringAsFixed(2) +
                                " m",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: modelData![index].sustPress1 != 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Flow Set Point : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData![index].flow ?? 0.0).toStringAsFixed(2) +
                                " LPS",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: modelData![index].flowSetPt1 != 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Calculated Volume : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData![index].dailyVolume ?? 0.0)
                                    .toStringAsFixed(2) +
                                " m³",
                            textScaleFactor: 1,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              // color:
                              //     modelData![index].calculatedVolume !=
                              //             0
                              //         ? Colors.green
                              //         : Colors.red
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'OMS MODE : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            getOmsMode(modelData![index].mode ?? 0),
                            textScaleFactor: 1,
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Valve Postition : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData![index].valvePosition ?? 0.0)
                                    .toStringAsFixed(2) +
                                " %",
                            textScaleFactor: 1,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sub Area : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Expanded(
                            child: Text(
                              (modelData![index].subChakArea1 ?? '-')
                                  .toString(),
                              textScaleFactor: 1,
                              // values[index].areaName!,
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Door : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData![index].door1 == true ||
                                    modelData![index].door2 == true
                                ? "OPEN"
                                : "CLOSE"),
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                color: (modelData![index].door1 == true ||
                                        modelData![index].door2 == true
                                    ? Colors.red
                                    : Colors.green),
                                // color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Battery Voltage : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text("${modelData![index].batteryLevel ?? 0.0} V",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 10,
                                  color:
                                      ((modelData![index].batteryLevel ?? 0.0) >
                                              17
                                          ? Colors.green
                                          : Colors.red),
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Design Flow Rate : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            getdesignflowrate() + ' LPS',
                            textScaleFactor: 1,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Outlet Press : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                              "${convertBartoMeter(modelData![index].outletPT) ?? 0.0} m",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: modelData![index].outletPT != 0
                                      ? Colors.green
                                      : Colors.red))
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Red Press : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            ((modelData![index].redPress1) ?? 0.0)
                                    .toStringAsFixed(2) +
                                " m",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: modelData![index].redPress1 != 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Actual Flow Rate : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (((modelData![index].flow) ?? 0.0) / 3.6)
                                    .toStringAsFixed(2) +
                                " LPS",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: modelData![index].flow != 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Schedule : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "${modelData![index].schedule == 1 ? 'PRESENT' : 'ABSENT'} ",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: modelData![index].schedule != 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'ROMS MODE : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (getRomsMode(modelData![index].rmode ?? 0)),
                            textScaleFactor: 1,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              // color:
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Irrigation Status : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "${modelData![index].sIRR == 1 ? 'STOPPED' : 'STARTED'} ",
                            textScaleFactor: 1,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8),
              // color: Colors.lightBlue.shade300,
              width: 180,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Distributory : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      Expanded(
                        child: Text(
                          modelData![index].distributaryName ?? '-',
                          textScaleFactor: 1,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Chak Area : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${modelData![index].chakArea ?? 0.0} HA",
                        textScaleFactor: 1,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Solar Voltage : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        (modelData![index].solarVoltage ?? 0.0)
                                .toStringAsFixed(2) +
                            " V",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10,
                            color:
                                getSolarColor(modelData![index].solarVoltage!),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(children: [
                    const Text(
                      'Design Press : ',
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      (modelData![index].availableResidualHead ?? 0.0)
                              .toStringAsFixed(2) +
                          " m",
                      textScaleFactor: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ]),
                  Row(
                    children: [
                      const Text(
                        'Inlet Press : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${convertBartoMeter(modelData![index].controllertype! == 'BOC' ? modelData![index].aI1 : modelData![index].aI4) ?? 0.0} m",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: modelData![index].aI4 != 0
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              // color: Colors.deepPurple.shade300,
              width: 180,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sub Area : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Expanded(
                        child: Text(
                          (modelData![index].areaName ?? '-').toString(),
                          textScaleFactor: 1,
                          // values[index].areaName!,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Door : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        (modelData![index].door1 == 1 ||
                                modelData![index].door2 == 1 ||
                                modelData![index].door3 == 1
                            ? "OPEN"
                            : "CLOSE"),
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10,
                            color: (modelData![index].door1 == 1 ||
                                    modelData![index].door2 == 1 ||
                                    modelData![index].door3 == 1
                                ? Colors.red
                                : Colors.green),
                            // color: Colors.green,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Battery Voltage : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text("${modelData![index].batteryLevel ?? 0.0} V",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 10,
                              color: getbatteryvoltageColor(modelData![index]),
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Design Flow Rate : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        (((modelData![index].duty ?? 0.0) *
                                        (modelData![index].chakArea ?? 0.0)) ??
                                    0.0)
                                .toStringAsFixed(2) +
                            ' LPS',
                        textScaleFactor: 1,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Outlet Press : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                          "${convertBartoMeter(modelData![index].controllertype! == 'BOC' ? modelData![index].aI2 : modelData![index].aI3) ?? 0.0} m",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: (modelData![index].controllertype! == 'BOC'
                                          ? modelData![index].aI2
                                          : modelData![index].aI3) !=
                                      0
                                  ? Colors.green
                                  : Colors.red))
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      }
    } catch (ex, _) {
      return Container(
        child: Text(ex.toString()),
      );
    }
  }

  getPFCDMDDiagram(double height, double width) {
    try {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(
            left: 25.00,
            top: 0.00,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Container(
                  width: 15,
                  height: 250,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.grey.shade500,
                          Colors.grey.shade500,
                          const Color.fromARGB(26, 199, 199, 199),
                          Colors.grey.shade500,
                          Colors.grey.shade500
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 10),
                                        // width: height * 0.03,
                                        height: height * 0.07,
                                        //color: Colors.grey,
                                        child: Text(
                                          "P1 : \n${convertBartoMeter(modelData![index].controllertype == 'BOC' ? modelData![index].aI1 : modelData![index].aI4) ?? 0.0}m",
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        // color: Colors.grey,
                                        height: height * 0.07,
                                        // color: Colors.grey,
                                        child: Text(
                                          "P2 : \n${convertBartoMeter(modelData![index].controllertype == 'BOC' ? modelData![index].aI2 : modelData![index].aI3) ?? 0.0}m",
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 80,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ///Thermometer
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${modelData![index].temperature}°C',
                                            textScaleFactor: 1,
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Image(
                                                image: AssetImage(
                                                    "assets/images/thermometer.png"),
                                                height: 30,
                                                width: 30),
                                          ),
                                        ],
                                      ),

                                      ///Battery
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Stack(children: [
                                              Image(
                                                image: AssetImage(
                                                  getBattreydata_new(
                                                      /*getBatpercentage(
                                              modelData![index].batteryType != null
                                                  ? modelData![index].batteryType
                                                  : 0,
                                              modelData![index].batteryLevel != null
                                                  ? modelData![index].batteryLevel!
                                                  : 0.0)*/
                                                      modelData![index]
                                                                  .batteryLevel1 !=
                                                              null
                                                          ? modelData![index]
                                                              .batteryLevel1!
                                                          : 0.0),
                                                ),
                                                width: 40,
                                                height: 40,
                                              ),
                                              Positioned(
                                                  top: 16,
                                                  left: 10,
                                                  child: Text(
                                                    // modelData![index].batteryLevel!
                                                    //         .toStringAsFixed(0) +
                                                    /*getBatpercentage(
                                                        modelData![index].batteryType !=
                                                                null
                                                            ? modelData![index]
                                                                .batteryType
                                                            : 0,
                                                        modelData![index].batteryLevel !=
                                                                null
                                                            ? modelData![index]
                                                                .batteryLevel!
                                                            : 0.0)*/
                                                    (modelData![index].batteryLevel1 !=
                                                                        null &&
                                                                    modelData![index]
                                                                            .batteryLevel1! >
                                                                        0
                                                                ? modelData![
                                                                        index]
                                                                    .batteryLevel1!
                                                                : 0.0)
                                                            .toStringAsFixed(
                                                                1) +
                                                        "%",
                                                    textScaleFactor: 1,
                                                    style: const TextStyle(
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ))
                                            ]),
                                          ),
                                        ],
                                      ),

                                      ///Solar
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Image(
                                              image: AssetImage(getSolarLevel(
                                                  (modelData![index]
                                                              .solarVoltage ??
                                                          0.0)
                                                      .toInt())),
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          Text(
                                            modelData![index]
                                                    .solarVoltage!
                                                    .toStringAsFixed(0) +
                                                " V",
                                            textScaleFactor: 1,
                                            style: const TextStyle(fontSize: 8),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          right: 20,
                                          left: 28,
                                        ),
                                        height: height * 0.01,
                                        width: width * 0.09,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 20,
                                      left: 28,
                                    ),
                                    height: 15,
                                    width: 4,
                                    color: Colors.black,
                                  ),
                                  Row(
                                    children: [
                                      Center(
                                        child: Container(
                                          width: 12,
                                          height: 14,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.grey.shade500,
                                              Colors.grey.shade500,
                                              const Color.fromARGB(
                                                  26, 199, 199, 199),
                                              Colors.grey.shade500,
                                              Colors.grey.shade500
                                            ],
                                          )),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          height: height * 0.055,
                                          width: width * 0.025,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: 12,
                                          height: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.13,
                                        height: height * 0.08,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5)),
                                          color: Colors.black,
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: height * 0.02,
                                            width: height * 0.02,
                                            decoration: BoxDecoration(
                                              gradient: RadialGradient(
                                                  radius: 5,
                                                  colors: modelData![index]
                                                              .filterChoke ==
                                                          0
                                                      ? [
                                                          Colors
                                                              .lightGreenAccent
                                                              .shade700,
                                                          Colors.green.shade900,
                                                          Colors.white
                                                        ]
                                                      : [
                                                          Colors.redAccent
                                                              .shade700,
                                                          Colors.red,
                                                          Colors.white
                                                        ]),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: 12,
                                          height: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          height: height * 0.055,
                                          width: width * 0.025,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 7,
                                      left: 20,
                                    ),
                                    height: height * 0.01,
                                    width: width * 0.15,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 7,
                                      left: 19,
                                    ),
                                    width: width * 0.13,
                                    height: height * 0.115,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5)),
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 7,
                                      left: 19,
                                    ),
                                    height: height * 0.03,
                                    width: width * 0.025,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          right: 0,
                                          left: 12,
                                        ),
                                        height: height * 0.03,
                                        width: width * 0.022,
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.01,
                                        width: width * 0.045,
                                        decoration: const BoxDecoration(
                                            color: Colors.black),
                                      ),
                                      Container(
                                        width: width * 0.065,
                                        height: height * 0.0325,
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                        width: width * 0.045,
                                      ),
                                      SizedBox(
                                        height: height * 0.03,
                                        width: width * 0.025,
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 7,
                                      left: 19,
                                    ),
                                    height: height * 0.02,
                                    width: width * 0.025,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.015,
                                  ),
                                  Text(
                                    "${"△P : \n" + (getPDeltaValue(((modelData![index].controllertype! == 'BOC' ? modelData![index].aI1 : modelData![index].aI4) ?? 0.0), ((modelData![index].controllertype! == 'BOC' ? modelData![index].aI2 : modelData![index].aI3) ?? 0.0))).toStringAsFixed(2)}m",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              for (var i = 1;
                                  i <= modelData![index].subChakQty!;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(top: 28.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.grey.shade500,
                                            Colors.grey.shade500,
                                            const Color.fromARGB(
                                                26, 199, 199, 199),
                                            Colors.grey.shade500,
                                            Colors.grey.shade500
                                          ],
                                        )),
                                        width: 50,
                                        height: 14,
                                        // color: Colors.grey,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                              colors: [
                                                Colors.grey.shade500,
                                                Colors.grey.shade500,
                                                const Color.fromARGB(
                                                    26, 199, 199, 199),
                                                Colors.grey.shade500,
                                                Colors.grey.shade500
                                              ],
                                            )),
                                            width: width * 0.06,
                                            height: height * 0.04,
                                            // color: Colors.grey,
                                          ),
                                          Container(
                                            width: width * 0.08,
                                            height: height * 0.01,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade500,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5.0),
                                                      topRight:
                                                          Radius.circular(5.0)),
                                            ),
                                          ),
                                          Container(
                                            width: 27,
                                            height: height * 0.015,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade500,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 14.0),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        right: 2,
                                                        // top: 5,
                                                        // bottom:5
                                                      ),
                                                      child: Container(
                                                        width: 13,
                                                        height: 13,
                                                        color: Colors.grey[350],
                                                        child: Center(
                                                          child: Text(
                                                              getmodevalve(
                                                                      modelData![
                                                                          index],
                                                                      i)
                                                                  .toString(),
                                                              textScaleFactor:
                                                                  1,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 2,
                                                              top: 5,
                                                              bottom: 5),
                                                      child: Container(
                                                        width: 13,
                                                        height: 13,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5)),
                                                          color:
                                                              Colors.grey[350],
                                                        ),
                                                        // color: Colors
                                                        //         .grey[
                                                        //     350],
                                                        child: Center(
                                                          child: Text(
                                                              // "f",
                                                              getsmodevalve(
                                                                      modelData![
                                                                          index],
                                                                      i)
                                                                  .toString(),
                                                              textScaleFactor:
                                                                  1,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                    width: 20,
                                                    height: 40,
                                                    color:
                                                        getPFCMDContainerColor(
                                                            modelData![index],
                                                            i))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 27,
                                            // width: width * 0.1,
                                            height: height * 0.015,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade500,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5.0))
                                                // BorderRadius.only(
                                                //     bottomLeft: Radius
                                                //         .circular(
                                                //             5.0),
                                                //     bottomRight: Radius
                                                //         .circular(
                                                //             5.0)),
                                                ),
                                          ),
                                          Container(
                                            width: width * 0.08,
                                            height: height * 0.01,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade500,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(5.0),
                                                      bottomRight:
                                                          Radius.circular(5.0)),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                              colors: [
                                                Colors.grey.shade500,
                                                Colors.grey.shade500,
                                                const Color.fromARGB(
                                                    26, 199, 199, 199),
                                                Colors.grey.shade500,
                                                Colors.grey.shade500
                                              ],
                                            )),
                                            width: width * 0.06,
                                            height: height * 0.04,
                                            // color: Colors.red,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              "PFCMD$i",
                                              textScaleFactor: 1,
                                              style: const TextStyle(
                                                  color: Colors.lightBlue,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 10),
                                        // width: height * 0.03,
                                        height: height * 0.07,
                                        //color: Colors.grey,
                                        child: Text(
                                          "P1 : \n${convertBartoMeter(modelData![index + 1].controllertype == 'BOC' ? modelData![index + 1].aI1 : modelData![index + 1].aI4) ?? 0.0}m",
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        // color: Colors.grey,
                                        height: height * 0.07,
                                        // color: Colors.grey,
                                        child: Text(
                                          "P2 : \n${convertBartoMeter(modelData![index + 1].controllertype == 'BOC' ? modelData![index + 1].aI2 : modelData![index + 1].aI3) ?? 0.0}m",
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 80,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ///Thermometer
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${modelData![index + 1].temperature}°C',
                                            textScaleFactor: 1,
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Image(
                                                image: AssetImage(
                                                    "assets/images/thermometer.png"),
                                                height: 30,
                                                width: 30),
                                          ),
                                        ],
                                      ),

                                      ///Battery
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Stack(children: [
                                              Image(
                                                image: AssetImage(
                                                  getBattreydata_new(
                                                      /*getBatpercentage(
                                              modelData![index+1].batteryType != null
                                                  ? modelData![index+1].batteryType
                                                  : 0,
                                              modelData![index+1].batteryLevel != null
                                                  ? modelData![index+1].batteryLevel!
                                                  : 0.0)*/
                                                      modelData![index + 1]
                                                                  .batteryLevel1 !=
                                                              null
                                                          ? modelData![
                                                                  index + 1]
                                                              .batteryLevel1!
                                                          : 0.0),
                                                ),
                                                width: 40,
                                                height: 40,
                                              ),
                                              Positioned(
                                                  top: 16,
                                                  left: 10,
                                                  child: Text(
                                                    // modelData![index+1].batteryLevel!
                                                    //         .toStringAsFixed(0) +
                                                    /*getBatpercentage(
                                                        modelData![index+1].batteryType !=
                                                                null
                                                            ? modelData![index+1]
                                                                .batteryType
                                                            : 0,
                                                        modelData![index+1].batteryLevel !=
                                                                null
                                                            ? modelData![index+1]
                                                                .batteryLevel!
                                                            : 0.0)*/
                                                    (modelData![index + 1].batteryLevel1 !=
                                                                        null &&
                                                                    modelData![index +
                                                                                1]
                                                                            .batteryLevel1! >
                                                                        0
                                                                ? modelData![
                                                                        index +
                                                                            1]
                                                                    .batteryLevel1!
                                                                : 0.0)
                                                            .toStringAsFixed(
                                                                1) +
                                                        "%",
                                                    textScaleFactor: 1,
                                                    style: const TextStyle(
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ))
                                            ]),
                                          ),
                                        ],
                                      ),

                                      ///Solar
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Image(
                                              image: AssetImage(getSolarLevel(
                                                  (modelData![index + 1]
                                                              .solarVoltage ??
                                                          0.0)
                                                      .toInt())),
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          Text(
                                            modelData![index + 1]
                                                    .solarVoltage!
                                                    .toStringAsFixed(0) +
                                                " V",
                                            textScaleFactor: 1,
                                            style: const TextStyle(fontSize: 8),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          right: 20,
                                          left: 28,
                                        ),
                                        height: height * 0.01,
                                        width: width * 0.09,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 20,
                                      left: 28,
                                    ),
                                    height: 15,
                                    width: 4,
                                    color: Colors.black,
                                  ),
                                  Row(
                                    children: [
                                      Center(
                                        child: Container(
                                          width: 12,
                                          height: 14,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.grey.shade500,
                                              Colors.grey.shade500,
                                              const Color.fromARGB(
                                                  26, 199, 199, 199),
                                              Colors.grey.shade500,
                                              Colors.grey.shade500
                                            ],
                                          )),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          height: height * 0.055,
                                          width: width * 0.025,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: 12,
                                          height: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.13,
                                        height: height * 0.08,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5)),
                                          color: Colors.black,
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: height * 0.02,
                                            width: height * 0.02,
                                            decoration: BoxDecoration(
                                              gradient: RadialGradient(
                                                  radius: 5,
                                                  colors: modelData![index + 1]
                                                              .filterChoke ==
                                                          0
                                                      ? [
                                                          Colors
                                                              .lightGreenAccent
                                                              .shade700,
                                                          Colors.green.shade900,
                                                          Colors.white
                                                        ]
                                                      : [
                                                          Colors.redAccent
                                                              .shade700,
                                                          Colors.red,
                                                          Colors.white
                                                        ]),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: 12,
                                          height: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          height: height * 0.055,
                                          width: width * 0.025,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 7,
                                      left: 20,
                                    ),
                                    height: height * 0.01,
                                    width: width * 0.15,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 7,
                                      left: 19,
                                    ),
                                    width: width * 0.13,
                                    height: height * 0.115,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5)),
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 7,
                                      left: 19,
                                    ),
                                    height: height * 0.03,
                                    width: width * 0.025,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          right: 0,
                                          left: 12,
                                        ),
                                        height: height * 0.03,
                                        width: width * 0.022,
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.01,
                                        width: width * 0.045,
                                        decoration: const BoxDecoration(
                                            color: Colors.black),
                                      ),
                                      Container(
                                        width: width * 0.065,
                                        height: height * 0.0325,
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                        width: width * 0.045,
                                      ),
                                      SizedBox(
                                        height: height * 0.03,
                                        width: width * 0.025,
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 7,
                                      left: 19,
                                    ),
                                    height: height * 0.02,
                                    width: width * 0.025,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.015,
                                  ),
                                  Text(
                                    "${"△P : \n" + (getPDeltaValue(((modelData![index + 1].controllertype! == 'BOC' ? modelData![index + 1].aI1 : modelData![index + 1].aI4) ?? 0.0), ((modelData![index + 1].controllertype! == 'BOC' ? modelData![index + 1].aI2 : modelData![index + 1].aI3) ?? 0.0))).toStringAsFixed(2)}m",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              for (var i = 1;
                                  i <= modelData![index + 1].subChakQty!;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(top: 28.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.grey.shade500,
                                            Colors.grey.shade500,
                                            const Color.fromARGB(
                                                26, 199, 199, 199),
                                            Colors.grey.shade500,
                                            Colors.grey.shade500
                                          ],
                                        )),
                                        width: 50,
                                        height: 14,
                                        // color: Colors.grey,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                              colors: [
                                                Colors.grey.shade500,
                                                Colors.grey.shade500,
                                                const Color.fromARGB(
                                                    26, 199, 199, 199),
                                                Colors.grey.shade500,
                                                Colors.grey.shade500
                                              ],
                                            )),
                                            width: width * 0.06,
                                            height: height * 0.04,
                                            // color: Colors.grey,
                                          ),
                                          Container(
                                            width: width * 0.08,
                                            height: height * 0.01,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade500,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5.0),
                                                      topRight:
                                                          Radius.circular(5.0)),
                                            ),
                                          ),
                                          Container(
                                            width: 27,
                                            height: height * 0.015,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade500,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 14.0),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        right: 2,
                                                        // top: 5,
                                                        // bottom:5
                                                      ),
                                                      child: Container(
                                                        width: 13,
                                                        height: 13,
                                                        color: Colors.grey[350],
                                                        child: Center(
                                                          child: Text(
                                                              getmodevalve(
                                                                      modelData![
                                                                          index +
                                                                              1],
                                                                      i)
                                                                  .toString(),
                                                              textScaleFactor:
                                                                  1,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 2,
                                                              top: 5,
                                                              bottom: 5),
                                                      child: Container(
                                                        width: 13,
                                                        height: 13,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5)),
                                                          color:
                                                              Colors.grey[350],
                                                        ),
                                                        // color: Colors
                                                        //         .grey[
                                                        //     350],
                                                        child: Center(
                                                          child: Text(
                                                              // "f",
                                                              getsmodevalve(
                                                                      modelData![
                                                                          index +
                                                                              1],
                                                                      i)
                                                                  .toString(),
                                                              textScaleFactor:
                                                                  1,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                    width: 20,
                                                    height: 40,
                                                    color:
                                                        getPFCMDContainerColor(
                                                            modelData![
                                                                index + 1],
                                                            i))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 27,
                                            // width: width * 0.1,
                                            height: height * 0.015,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade500,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5.0))
                                                // BorderRadius.only(
                                                //     bottomLeft: Radius
                                                //         .circular(
                                                //             5.0),
                                                //     bottomRight: Radius
                                                //         .circular(
                                                //             5.0)),
                                                ),
                                          ),
                                          Container(
                                            width: width * 0.08,
                                            height: height * 0.01,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade500,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(5.0),
                                                      bottomRight:
                                                          Radius.circular(5.0)),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                              colors: [
                                                Colors.grey.shade500,
                                                Colors.grey.shade500,
                                                const Color.fromARGB(
                                                    26, 199, 199, 199),
                                                Colors.grey.shade500,
                                                Colors.grey.shade500
                                              ],
                                            )),
                                            width: width * 0.06,
                                            height: height * 0.04,
                                            // color: Colors.red,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              "PFCMD$i",
                                              textScaleFactor: 1,
                                              style: const TextStyle(
                                                  color: Colors.lightBlue,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } catch (_, ex) {
      return Container();
    }
  }

  String getValvecolor(int irristatus) {
    try {
      if (irristatus == 1) {
        return 'assets/images/triangle-green.png';
      } else {
        return 'assets/images/triangle-red.png';
      }
    } catch (_, ex) {
      return 'assets/images/triangle-red.png';
    }
  }

  getRomsMode(int roms) {
    if (roms == 0) {
      return 'Auto';
    } else if (roms == 1) {
      return 'Manual';
    } else if (roms == 2) {
      return 'Testing';
    } else {
      return 'Not Set';
    }
  }

  getOmsMode(int oms) {
    if (oms == 1) {
      return 'OPEN/CLOSE';
    } else if (oms == 2) {
      return 'Flow bypass';
    } else if (oms == 3) {
      return 'Flow Control';
    } else if (oms == 4) {
      return 'Differential pressure';
    } else if (oms == 5) {
      return 'Pressure relief';
    } else if (oms == 6) {
      return 'Postion';
    } else if (oms == 7) {
      return 'Sprinkler';
    } else if (oms == 8) {
      return 'Design flow control';
    } else if (oms == 9) {
      return 'Design Flow';
    } else if (oms == 10) {
      return 'Pressurize irrigation';
    } else if (oms == 11) {
      return 'Auto position';
    } else {
      return 'Not Set';
    }
  }

  getpfcmdcolor(var valpos, var flow) {
    if (valpos < 2) {
      return Colors.red;
    } else if (valpos > 2 && flow == 0) {
      return Colors.yellow;
    } else if (valpos > 2 && flow > 0) {
      return Colors.green;
    }
  }

  getbatteryvoltageColor(OmsMasterModel model) {
    try {
      if (model.controllertype == 'BOC') {
        if ((model.batteryLevel ?? 0.0) >= 3.2) {
          return Colors.green;
        } else {
          return Colors.red;
        }
      } else {
        if ((model.batteryLevel ?? 0.0) > 17) {
          return Colors.green;
        } else {
          return Colors.red;
        }
      }
    } catch (_, ex) {
      return Colors.yellowAccent;
    }
  }

  getdesignflowrate() {
    var chakarea;
    chakarea = (modelData![index].chakArea ?? 0.0);
    var flowrate;
    flowrate = (modelData![index].duty ?? 0);

    var designflowratehr = (chakarea * flowrate);

    return designflowratehr.toStringAsFixed(2);
  }

  Future<List<OMS_Overview_model>>? OmsListFuture;
  List<OMS_Overview_model>? OmsOverviewList = [];
  Future<List<OmsMasterModel>>? DisplayListFuture;
  Future GetOmsOverviewModel() async {
    try {
      setState(() {
        OmsListFuture = getOmsOverviewdata(OMSStatusCheck!, DamageStatusCheck!,
            area.toString(), distibutory.toString());
        OmsListFuture!.then((value) {
          setState(() {
            OmsOverviewList = value;
          });
          // SetTotalStatusCount(value);
        });
      });
      _DisplayList = [];
      // getScount();
      _firstLoad();
      return OmsListFuture;
    } catch (_, ex) {}
  }

  Future _reload() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //int? userid = preferences.getInt('userid');
      String? conString = preferences.getString('conString');
      //String? project = preferences.getString('project');
      String? liststatus = cheklist.join(',');
      _search = modelData![index].chakNo!;
      var aid = modelData![index].areaId!;
      var did = modelData![index].distributaryId!;
      final res = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/Project/OMSDisplayList?Search=$_search&_aid=$aid&_did=$did&_OMSStatus=$OMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString'));
      print(
          'http://wmsservices.seprojects.in/api/Project/OMSDisplayList?Search=$_search&_aid=$aid&_did=$did&_OMSStatus=$OMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString');

      var json = jsonDecode(res.body);
      List<OmsMasterModel> fetchedData = <OmsMasterModel>[];
      json.forEach((e) => fetchedData.add(OmsMasterModel.fromJson(e)));
      if (fetchedData.isNotEmpty) {
        setState(() {
          modelData![index] = fetchedData.singleWhere(
              (element) => element.omsId! == modelData![index].omsId!);
          getOmsOverviewdata(OMSStatusCheck!, DamageStatusCheck!,
              area.toString(), distibutory.toString());
          //_DisplayList!.addAll(fetchedData);
        });
      }
    } catch (err) {
      print('Something went wrong');
    }
    setState(() {
      _page = 0;
      _DisplayList = [];
    });

    await GetOmsOverviewModel();
  }

  getlongDate(String date) {
    try {
      final DateTime now = DateTime.parse(date);
      final DateFormat formatter = DateFormat('EEEE, d MMMM y H:m:s');
      final String formatted = formatter.format(now);
      print(formatted); // something like 2013-04-20
      return formatted;
    } catch (e) {
      return 'Never Connected';
    }
  }

  String getBattreydata_new(double LevelStatus) {
    try {
      if (LevelStatus <= 100 && LevelStatus >= 90) {
        return "assets/images/battery100.png";
      } else if (LevelStatus < 90 && LevelStatus >= 80) {
        return "assets/images/battery80.png";
      } else if (LevelStatus < 80 && LevelStatus >= 60) {
        return "assets/images/battery70.png";
      } else if (LevelStatus < 60 && LevelStatus >= 40) {
        return "assets/images/battery55.png";
      } else if (LevelStatus < 40 && LevelStatus > 20) {
        return "assets/images/battery25.png";
      } else {
        return "assets/images/battery10.png";
      }
    } catch (_, ex) {
      return "assets/images/battery10.png";
    }
  }

  String getGSMlevel(String LevelStatus) {
    {
      if (LevelStatus == "ON") {
        return "assets/images/ExcellentSignal.png";
      } else {
        return "assets/images/BadSignal.png";
      }
    }
  }

  String convertm3hrToLps(double data) {
    double res = 0.0;
    try {
      res = (data / 3.6);
    } catch (_, ex) {}
    return res.toStringAsFixed(2);
  }

  String getSolarLevel(int LevelStatus) {
    if (LevelStatus == null) {
      return "assets/images/solar_weak.png";
    } else if (LevelStatus <= 0) {
      return "assets/images/solar_weak.png";
    } else if (LevelStatus > 0 && LevelStatus < 21) {
      return "assets/images/solar_normal.png";
    } else {
      return "assets/images/solar_weak.png";
    }
  }

  getSolarColor(double LevelStatus) {
    if (LevelStatus == null) {
      return Colors.red;
    } else if (LevelStatus <= 0) {
      return Colors.red;
    } else if (LevelStatus > 0 && LevelStatus < 21) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  getBatpercentage(int BatType, double BatLevel) {
    var batper;
    try {
      if (BatLevel == 0) {
        return 0.0;
      } else {
        if (BatType == 1) {
          batper = (BatLevel - 11) * 100 / (16.5 - 11);
          return batper;
        } else {
          batper = (BatLevel - 10.8) * 100 / (14.8 - 10.8);
          return batper;
        }
      }
    } catch (_, ex) {}

    // return batper > 0 ? 0.0 : batper;
    return batper;
  }

  getPFCMDContainerColor(OmsMasterModel model, int index) {
    double posValve = 0.0, flowValve = 0.0;
    switch (index) {
      case 1:
        posValve = (model.posValve1 ?? 0.0);
        flowValve = (model.flowValve1 ?? 0.0);
        break;
      case 2:
        posValve = (model.posValve2 ?? 0.0);
        flowValve = (model.flowValve2 ?? 0.0);
        break;
      case 3:
        posValve = (model.posValve3 ?? 0.0);
        flowValve = (model.flowValve3 ?? 0.0);
        break;
      case 4:
        posValve = (model.posValve4 ?? 0.0);
        flowValve = (model.flowValve4 ?? 0.0);
        break;
      case 5:
        posValve = (model.posValve5 ?? 0.0);
        flowValve = (model.flowValve5 ?? 0.0);
        break;
      case 6:
        posValve = model.posValve6 ?? 0.0;
        flowValve = model.flowValve6 ?? 0.0;
        break;
    }
    if (posValve < 2) {
      return Colors.red[900];
    } else if (posValve >= 2 && flowValve == 0) {
      return Colors.yellowAccent.shade400;
    } else if (posValve >= 2 && flowValve > 0) {
      return Colors.green.shade900;
    } else {
      return Colors.grey;
    }
  }

  getPDeltaValue(double pt1, double pt2) {
    double value = 0.0;
    try {
      value = double.parse(convertBartoMeter(pt1)) -
          double.parse(convertBartoMeter(pt2));
      if (value < 0) value = value * (-1);
    } catch (_, ex) {}
    return value;
  }

  getmodevalve(OmsMasterModel model, int mode) {
    switch (mode) {
      case 1:
        if (modelData![index].modeValve1 == 1) {
          return 'O';
        } else if (modelData![index].modeValve1 == 2) {
          return 'F';
        } else if (modelData![index].modeValve1 == 3) {
          return 'P';
        } else {
          return 'N';
        }
      case 2:
        if (modelData![index].modeValve2 == 1) {
          return 'O';
        } else if (modelData![index].modeValve2 == 2) {
          return 'F';
        } else if (modelData![index].modeValve2 == 3) {
          return 'P';
        } else {
          return 'N';
        }

      case 3:
        if (modelData![index].modeValve3 == 1) {
          return 'O';
        } else if (modelData![index].modeValve3 == 2) {
          return 'F';
        } else if (modelData![index].modeValve3 == 3) {
          return 'P';
        } else {
          return 'N';
        }
      case 4:
        if (modelData![index].modeValve4 == 1) {
          return 'O';
        } else if (modelData![index].modeValve4 == 2) {
          return 'F';
        } else if (modelData![index].modeValve4 == 3) {
          return 'P';
        } else {
          return 'N';
        }

      case 5:
        if (modelData![index].modeValve5 == 1) {
          return 'O';
        } else if (modelData![index].modeValve5 == 2) {
          return 'F';
        } else if (modelData![index].modeValve5 == 3) {
          return 'P';
        } else {
          return 'N';
        }

      case 6:
        if (modelData![index].modeValve6 == 1) {
          return 'O';
        } else if (modelData![index].modeValve6 == 2) {
          return 'F';
        } else if (modelData![index].modeValve6 == 3) {
          return 'P';
        } else {
          return 'N';
        }
    }
  }

  convertBartoMeter(dynamic data) {
    try {
      if (data == null) {
        return '0.0';
      } else {
        var converted = data * 10.2;
        return converted.toStringAsFixed(2);
      }
    } catch (_) {}
    return '0.0';
  }

  void _firstLoad() async {
    List<OmsMasterModel>? DisplayList = <OmsMasterModel>[];
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //int? userid = preferences.getInt('userid');
      String? conString = preferences.getString('conString');
      //String? project = preferences.getString('project');
      String? liststatus = cheklist.join(',');
      final res = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/Project/OMSDisplayList?Search=$_search&_aid=$area&_did=$distibutory&_OMSStatus=$OMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString'));

      print(
          'http://wmsservices.seprojects.in/api/Project/OMSDisplayList?Search=$_search&_aid=$area&_did=$distibutory&_OMSStatus=$OMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString');

      var json = jsonDecode(res.body);
      List<OmsMasterModel> fetchedData = <OmsMasterModel>[];
      json.forEach((e) => fetchedData.add(OmsMasterModel.fromJson(e)));
      DisplayList = [];
      if (fetchedData.isNotEmpty) {
        setState(() {
          DisplayList!.addAll(fetchedData);
        });
      }
    } catch (err) {
      print('Something went wrong');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  getIrrigationStatus(int irristatus) {
    try {
      if (irristatus == 0) {
        return 'Start';
      } else if (irristatus == 1) {
        return 'Stop';
      } else {
        return 'Not Set';
      }
    } catch (_, ex) {
      return 'Not Set';
    }
  }

  getsmodevalve(OmsMasterModel model, int mode) {
    switch (mode) {
      case 1:
        if (modelData![index].smodeValve1 == 1) {
          return 'A';
        } else if (modelData![index].smodeValve1 == 2) {
          return 'M';
        } else if (modelData![index].smodeValve1 == 3) {
          return 'T';
        } else {
          return 'N';
        }
      case 2:
        if (modelData![index].smodeValve2 == 1) {
          return 'A';
        } else if (modelData![index].smodeValve2 == 2) {
          return 'M';
        } else if (modelData![index].smodeValve2 == 3) {
          return 'T';
        } else {
          return 'N';
        }
      case 3:
        if (modelData![index].smodeValve3 == 1) {
          return 'A';
        } else if (modelData![index].smodeValve3 == 2) {
          return 'M';
        } else if (modelData![index].smodeValve3 == 3) {
          return 'T';
        } else {
          return 'N';
        }
      case 4:
        if (modelData![index].smodeValve4 == 1) {
          return 'A';
        } else if (modelData![index].smodeValve4 == 2) {
          return 'M';
        } else if (modelData![index].smodeValve4 == 3) {
          return 'T';
        } else {
          return 'N';
        }

      case 5:
        if (modelData![index].smodeValve5 == 1) {
          return 'A';
        } else if (modelData![index].smodeValve5 == 2) {
          return 'M';
        } else if (modelData![index].smodeValve5 == 3) {
          return 'T';
        } else {
          return 'N';
        }
      case 6:
        if (modelData![index].smodeValve6 == 1) {
          return 'A';
        } else if (modelData![index].smodeValve6 == 2) {
          return 'M';
        } else if (modelData![index].smodeValve6 == 3) {
          return 'T';
        } else {
          return 'N';
        }
    }
  }

  getpop(context) {
    return showDialog(
      barrierDismissible: false,
      useSafeArea: false,
      context: context,
      builder: (ctx) => Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future getRmsData(int? rmsId, String? rmsNo) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? conString = preferences.getString('conString');
      String? liststatus = cheklist.join(',');
      _search = rmsNo!;
      final res = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/Project/RMSDisplayList?Search=$_search&_aid=all&_did=all&_RMSStatus=all&_DamageStatus=all&_ListStatus=all&pageIndex=0&pageSize=30&conString=$conString'));
      var json = jsonDecode(res.body);
      List<RMSMastermodel> fetchedData = <RMSMastermodel>[];
      json.forEach((e) => fetchedData.add(RMSMastermodel.fromJson(e)));
      if (fetchedData.isNotEmpty) {
        return fetchedData.singleWhere((element) => element.rmsId! == rmsId!);
      }
    } catch (err) {}
  }
}
