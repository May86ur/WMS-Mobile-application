// ignore_for_file: must_be_immutable, camel_case_types, non_constant_identifier_names, unused_element, unnecessary_null_comparison, unused_catch_stack, unused_local_variable

import 'dart:convert';
import 'package:WMS_Application/Model/Project/OMS_Overview_model.dart';
import 'package:WMS_Application/Model/Project/OmsMasterModel.dart';
import 'package:WMS_Application/Operations/StateselectionOperation.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/Screens/OMS/8days_schedule_screen.dart';
import 'package:WMS_Application/Screens/OMS/Graphical_Screen_Sql.dart';
import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:WMS_Application/core/app_export.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/Project/RMSMastermodel.dart';
import '../RMS/RMS_Details_Screen.dart';

OmsMasterModel? modelData;
List<OmsMasterModel>? _DisplayList = <OmsMasterModel>[];

var _search = '';

var cheklist = ['All'];
int _page = 0;
int _limit = 20;
bool showButton = false;
bool _hasNextPage = true;

var _isFirstLoadRunning = false;

class OMS_Details_Screen extends StatefulWidget {
  String? ProjectName;

  OMS_Details_Screen(OmsMasterModel? _modelData, String project) {
    modelData = _modelData ?? null;
    ProjectName = project;
  }

  @override
  State<OMS_Details_Screen> createState() => _OMS_Details_ScreenState();
}

class _OMS_Details_ScreenState extends State<OMS_Details_Screen> {
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
        backgroundColor: ColorConstant.whiteA700,
        drawer: MyDrawerScreen(),
        appBar: AppBar(
            title: Text(
              widget.ProjectName!
                      .toString()
                      .replaceAll("_", " ")
                      .toUpperCase() +
                  ' - OMS',
              textScaleFactor: 1,
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
        body: RefreshIndicator(
          onRefresh: () async {
            await modelData;
          },
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(image: backgroundImage),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        left: getHorizontalSize(
                          9.00,
                        ),
                        top: getVerticalSize(
                          6.00,
                        ),
                        right: getHorizontalSize(
                          9.00,
                        ),
                        bottom: getVerticalSize(
                          8.00,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteA700,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ///Heading
                          Container(
                            alignment: Alignment.center,
                            height: getVerticalSize(
                              25.00,
                            ),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: (modelData!.oNLINE == "ON"
                                  ? Colors.green
                                  : Colors.red),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  modelData!.chakNo1.toString(),
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.whiteA700,
                                    fontSize: getFontSize(
                                      14,
                                    ),
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
                                        EdgeInsets.only(bottom: 1, left: 5),
                                    alignment: Alignment.center,
                                    onPressed: () async {
                                      await _reload();
                                      getpop(context);
                                      new Future.delayed(
                                          new Duration(seconds: 1), () {
                                        Navigator.pop(context); //pop dialog
                                      });
                                    },
                                    icon: Icon(
                                      Icons.refresh,
                                    ))
                              ],
                            ),
                          ),

                          ///Icons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ///Thermometer
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      modelData!.temperature.toString() + '°C',
                                      textScaleFactor: 1,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, right: 10),
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/thermometer.png"),
                                          height: 30,
                                          width: 30),
                                    ),
                                  ],
                                ),
                              ),

                              ///Door
                              /*Column(children: [
                                Padding(
                                    padding: EdgeInsets.only(top: 10, right: 10),
                                    child: Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: (modelData!.door1 == 1 ||
                                                    modelData!.door2 == 1 ||
                                                    modelData!.door3 == 1
                                                ? Colors.red
                                                : Colors.green)),
                                        height: 40,
                                        width: 40,
                                      ),
                                      Positioned(
                                        top: 6,
                                        left: 5,
                                        child: Image(
                                            image: (modelData!.door1 == 1 ||
                                                    modelData!.door2 == 1 ||
                                                    modelData!.door3 == 1
                                                ? AssetImage(
                                                    "assets/images/door_open.png")
                                                : AssetImage(
                                                    "assets/images/door_closed.png")),
                                            height: 30,
                                            width: 30),
                                      )
                                    ]))
                              ]),*/

                              /*///signal
                              Padding(
                                padding: EdgeInsets.only(top: 10, right: 10),
                                child: Image(
                                    image: AssetImage(
                                        getGSMlevel(modelData!.oNLINE!)),
                                    height: 30,
                                    width: 25),
                              ),
*/
                              ///Battery
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, right: 10),
                                    child: Stack(children: [
                                      Image(
                                        image: AssetImage(
                                          getBattreydata_new(
                                              /*getBatpercentage(
                                              modelData!.batteryType != null
                                                  ? modelData!.batteryType
                                                  : 0,
                                              modelData!.batteryLevel != null
                                                  ? modelData!.batteryLevel!
                                                  : 0.0)*/
                                              modelData!.batteryLevel1 != null
                                                  ? modelData!.batteryLevel1!
                                                  : 0.0),
                                        ),
                                        width: 40,
                                        height: 40,
                                      ),
                                      Positioned(
                                          top: 16,
                                          left: 10,
                                          child: Text(
                                            // modelData!.batteryLevel!
                                            //         .toStringAsFixed(0) +
                                            /*getBatpercentage(
                                                        modelData!.batteryType !=
                                                                null
                                                            ? modelData!
                                                                .batteryType
                                                            : 0,
                                                        modelData!.batteryLevel !=
                                                                null
                                                            ? modelData!
                                                                .batteryLevel!
                                                            : 0.0)*/
                                            (modelData!.batteryLevel1 != null &&
                                                            modelData!
                                                                    .batteryLevel1! >
                                                                0
                                                        ? modelData!
                                                            .batteryLevel1!
                                                        : 0.0)
                                                    .toStringAsFixed(1) +
                                                "%",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w500),
                                          ))
                                    ]),
                                  ),
                                ],
                              ),

                              ///Solar
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, right: 10),
                                    child: Image(
                                      image: AssetImage(getSolarLevel(
                                          (modelData!.solarVoltage ?? 0.0)
                                              .toInt())),
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  Text(
                                    modelData!.solarVoltage!
                                            .toStringAsFixed(0) +
                                        " V",
                                    textScaleFactor: 1,
                                    style: TextStyle(fontSize: 8),
                                  )
                                ],
                              ),

                              //REFRESH

                              ///Navigation
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    openMap(modelData!.coordinates.toString());
                                  },
                                  child: Image(
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

                          SizedBox(
                            height: 17,
                          ),

                          ///Table Data
                          if (!widget.ProjectName!
                              .toLowerCase()
                              .contains('hanuman'))
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
/*                              ///valve Details
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 235, 232, 169),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      child: Text(
                                        'VALVE\nDETAILS',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 168, 211, 237),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "PT (m)",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 168, 211, 237),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "POS(%)",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 168, 211, 237),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "POS SET\n POINT (%)",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 168, 211, 237),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "FLOW (LPS)",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 168, 211, 237),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "FLOW SET\nPOINT (LPS)",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 168, 211, 237),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "VOL (m³)",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 168, 211, 237),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "PR-SUS (m)",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 168, 211, 237),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "PR-RED (m)",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 168, 211, 237),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "Schedule\n Present/abs".toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 168, 211, 237),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        "IRRIGATION\nSTATUS",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              ///PFCMD1
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 235, 232, 169),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      child: Text(
                                        'PFCMD1',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              ///PFCMD2
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 235, 232, 169),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      child: Text(
                                        'PFCMD2',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              ///PFCMD3
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 235, 232, 169),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      child: Text(
                                        'PFCMD3',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              ///PFCMD4
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 235, 232, 169),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      child: Text(
                                        'PFCMD4',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              ///PFCMD5
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 235, 232, 169),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      child: Text(
                                        'PFCMD5',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              ///PFCMD6
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 30,
                                    color: Color.fromARGB(255, 235, 232, 169),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      child: Text(
                                        'PFCMD6',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
*/
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ///PFCMD
                                    Container(
                                      padding: EdgeInsets.all(3),
                                      height: 30,
                                      width: size.width * 0.880,
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
                                            ColorConstant.cyan301,
                                          ],
                                        ),
                                        // Color.fromARGB(255, 235, 232, 169),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          if ((modelData!.subChakQty ?? 0) >= 1)
                                            Container(
                                              width: 45,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 2),
                                                child: Text(
                                                  'PFCMD1',
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          if ((modelData!.subChakQty ?? 0) >= 2)
                                            Container(
                                              width: 45,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 2),
                                                child: Text(
                                                  'PFCMD2',
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          if ((modelData!.subChakQty ?? 0) >= 3)
                                            Container(
                                              width: 45,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 2),
                                                child: Text(
                                                  'PFCMD3',
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          if ((modelData!.subChakQty ?? 0) >= 4)
                                            Container(
                                              width: 45,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 2),
                                                child: Text(
                                                  'PFCMD4',
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          if ((modelData!.subChakQty ?? 0) >= 5)
                                            Container(
                                              width: 45,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 2),
                                                child: Text(
                                                  'PFCMD5',
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          if ((modelData!.subChakQty ?? 0) >= 6)
                                            Container(
                                              width: 45,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 2),
                                                child: Text(
                                                  'PFCMD6',
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),

                                    ///PT
                                    Container(
                                      height: 30,
                                      width: size.width * 0.88,
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 168, 211, 237),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(),
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  "PT (m)",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                1)
                                              Container(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      convertBartoMeter(
                                                              modelData!.pT2Valve1 !=
                                                                      null
                                                                  ? modelData!
                                                                      .pT2Valve1
                                                                  : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                                width: 48,
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                2)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      convertBartoMeter(
                                                              modelData!.pT2Valve2 !=
                                                                      null
                                                                  ? modelData!
                                                                      .pT2Valve2
                                                                  : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                3)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      convertBartoMeter(
                                                              modelData!.pT2Valve3 !=
                                                                      null
                                                                  ? modelData!
                                                                      .pT2Valve3
                                                                  : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                4)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      convertBartoMeter(
                                                              modelData!.pT2Valve4 !=
                                                                      null
                                                                  ? modelData!
                                                                      .pT2Valve4
                                                                  : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                5)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      convertBartoMeter(
                                                              modelData!.pT2Valve5 !=
                                                                      null
                                                                  ? modelData!
                                                                      .pT2Valve5
                                                                  : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                6)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      convertBartoMeter(
                                                              modelData!.pT2Valve6 !=
                                                                      null
                                                                  ? modelData!
                                                                      .pT2Valve6
                                                                  : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
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
                                      width: size.width * 0.88,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 168, 211, 237),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  "Position(%)",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                1)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      (modelData!.posValve1 !=
                                                                  null
                                                              ? modelData!
                                                                  .posValve1
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                2)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      (modelData!.posValve2 !=
                                                                  null
                                                              ? modelData!
                                                                  .posValve2
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                3)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      (modelData!.posValve3 !=
                                                                  null
                                                              ? modelData!
                                                                  .posValve3
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                4)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      (modelData!.posValve4 !=
                                                                  null
                                                              ? modelData!
                                                                  .posValve4
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                5)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      (modelData!.posValve5 !=
                                                                  null
                                                              ? modelData!
                                                                  .posValve5
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                6)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      (modelData!.posValve6 !=
                                                                  null
                                                              ? modelData!
                                                                  .posValve6
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
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
                                      width: size.width * 0.88,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 168, 211, 237),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  "Pos Set\n Point (%)",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                1)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      modelData!.posSetPt1 ==
                                                              null
                                                          ? "0.0"
                                                          : modelData!.posSetPt1
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                2)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      modelData!.posSetPt2 ==
                                                              null
                                                          ? "0.0"
                                                          : modelData!.posSetPt2
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                3)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      modelData!.posSetPt3 ==
                                                              null
                                                          ? "0.0"
                                                          : modelData!.posSetPt3
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                4)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      modelData!.posSetPt4 ==
                                                              null
                                                          ? "0.0"
                                                          : modelData!.posSetPt4
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                5)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      modelData!.posSetPt5 ==
                                                              null
                                                          ? "0.0"
                                                          : modelData!.posSetPt5
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                6)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      modelData!.posSetPt6 ==
                                                              null
                                                          ? "0.0"
                                                          : modelData!.posSetPt6
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
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
                                      width: size.width * 0.88,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 168, 211, 237),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 70,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  "Flow(LPS)",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                1)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      (modelData!.flowValve1 !=
                                                                  null
                                                              ? convertm3hrToLps(
                                                                  modelData!
                                                                      .flowValve1!)
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                2)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      (modelData!.flowValve2 !=
                                                                  null
                                                              ? convertm3hrToLps(
                                                                  modelData!
                                                                      .flowValve2!)
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                3)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      (modelData!.flowValve3 !=
                                                                  null
                                                              ? convertm3hrToLps(
                                                                  modelData!
                                                                      .flowValve3!)
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                4)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      (modelData!.flowValve4 !=
                                                                  null
                                                              ? convertm3hrToLps(
                                                                  modelData!
                                                                      .flowValve4!)
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                5)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      (modelData!.flowValve5 !=
                                                                  null
                                                              ? convertm3hrToLps(
                                                                  modelData!
                                                                      .flowValve5!)
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                6)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      (modelData!.flowValve6 !=
                                                                  null
                                                              ? convertm3hrToLps(
                                                                  modelData!
                                                                      .flowValve6!)
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
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
                                      width: size.width * 0.88,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 168, 211, 237),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  "Flow Set\nPoint(lps)",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                1)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      modelData!.flowSetPt1 ==
                                                              null
                                                          ? "0.0"
                                                          : convertm3hrToLps(
                                                                  modelData!
                                                                      .flowSetPt1)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                2)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      modelData!.flowSetPt2 ==
                                                              null
                                                          ? "0.0"
                                                          : convertm3hrToLps(
                                                                  modelData!
                                                                      .flowSetPt2)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                3)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      modelData!.flowSetPt3 ==
                                                              null
                                                          ? "0.0"
                                                          : convertm3hrToLps(
                                                                  modelData!
                                                                      .flowSetPt3)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                4)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      modelData!.flowSetPt4 ==
                                                              null
                                                          ? "0.0"
                                                          : convertm3hrToLps(
                                                                  modelData!
                                                                      .flowSetPt4)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                5)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      modelData!.flowSetPt5 ==
                                                              null
                                                          ? "0.0"
                                                          : convertm3hrToLps(
                                                                  modelData!
                                                                      .flowSetPt5)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                6)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 15,
                                                    ),
                                                    child: Text(
                                                      modelData!.flowSetPt6 ==
                                                              null
                                                          ? "0.0"
                                                          : convertm3hrToLps(
                                                                  modelData!
                                                                      .flowSetPt6)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
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
                                      width: size.width * 0.88,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 168, 211, 237),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  "Vol(m³)",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                1)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      (modelData!.volValve1 !=
                                                                  null
                                                              ? modelData!
                                                                  .volValve1
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                2)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      (modelData!.volValve2 !=
                                                                  null
                                                              ? modelData!
                                                                  .volValve2
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                3)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      (modelData!.volValve3 !=
                                                                  null
                                                              ? modelData!
                                                                  .volValve3
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                4)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      (modelData!.volValve4 !=
                                                                  null
                                                              ? modelData!
                                                                  .volValve4
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                5)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      (modelData!.volValve5 !=
                                                                  null
                                                              ? modelData!
                                                                  .volValve5
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                6)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      (modelData!.volValve6 !=
                                                                  null
                                                              ? modelData!
                                                                  .volValve6
                                                              : 0.0)
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
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
                                      width: size.width * 0.88,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 168, 211, 237),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  "Pr-Sus(m)",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                1)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.sustPress1 ==
                                                              null
                                                          ? "0.0"
                                                          : convertBartoMeter(
                                                                  modelData!
                                                                      .sustPress1)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          //TODO
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                2)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.sustPress2 ==
                                                              null
                                                          ? "0.0"
                                                          : convertBartoMeter(
                                                                  modelData!
                                                                      .sustPress2)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                3)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.sustPress3 ==
                                                              null
                                                          ? "0.0"
                                                          : convertBartoMeter(
                                                                  modelData!
                                                                      .sustPress3)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                4)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.sustPress4 ==
                                                              null
                                                          ? "0.0"
                                                          : convertBartoMeter(
                                                                  modelData!
                                                                      .sustPress4)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                5)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.sustPress5 ==
                                                              null
                                                          ? "0.0"
                                                          : convertBartoMeter(
                                                                  modelData!
                                                                      .sustPress5)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                6)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.sustPress6 ==
                                                              null
                                                          ? "0.0"
                                                          : convertBartoMeter(
                                                                  modelData!
                                                                      .sustPress6)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
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
                                      width: size.width * 0.88,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 168, 211, 237),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  "Pr-Red(m)",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                1)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.redPress1 ==
                                                              null
                                                          ? "0.0"
                                                          : convertBartoMeter(
                                                                  modelData!
                                                                      .redPress1)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                2)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.redPress2 ==
                                                              null
                                                          ? "0.0"
                                                          : convertBartoMeter(
                                                                  modelData!
                                                                      .redPress2)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                3)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.redPress3 ==
                                                              null
                                                          ? "0.0"
                                                          : convertBartoMeter(
                                                                  modelData!
                                                                      .redPress3)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                4)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.redPress4 ==
                                                              null
                                                          ? "0.0"
                                                          : convertBartoMeter(
                                                                  modelData!
                                                                      .redPress4)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                5)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.redPress5 ==
                                                              null
                                                          ? "0.0"
                                                          : convertBartoMeter(
                                                                  modelData!
                                                                      .redPress5)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                6)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.redPress6 ==
                                                              null
                                                          ? "0.0"
                                                          : convertBartoMeter(
                                                                  modelData!
                                                                      .redPress6)
                                                              .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
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
                                      width: size.width * 0.88,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 168, 211, 237),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  "Schedule\nPresent/abs",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                1)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.schedule
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                2)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 0),
                                                    child: Text(
                                                      modelData!.schedule
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                3)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Text(
                                                      modelData!.schedule
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                4)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 0),
                                                    child: Text(
                                                      modelData!.schedule
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                5)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 0),
                                                    child: Text(
                                                      modelData!.schedule
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                6)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 0),
                                                    child: Text(
                                                      modelData!.schedule
                                                          .toString(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
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
                                      width: size.width * 0.88,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 168, 211, 237),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  "Irrigation\nStatus",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                1)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15, left: 2),
                                                    child: Text(
                                                      getIrrigationStatus(
                                                          modelData!.sIRR1 ??
                                                              0),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                2)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15, left: 2),
                                                    child: Text(
                                                      getIrrigationStatus(
                                                          modelData!.sIRR2 ??
                                                              0),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                3)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15, left: 2),
                                                    child: Text(
                                                      getIrrigationStatus(
                                                          modelData!.sIRR3 ??
                                                              0),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                4)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15, left: 2),
                                                    child: Text(
                                                      getIrrigationStatus(
                                                          modelData!.sIRR4 ??
                                                              0),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                5)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15, left: 2),
                                                    child: Text(
                                                      getIrrigationStatus(
                                                          modelData!.sIRR5 ??
                                                              0),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            if ((modelData!.subChakQty ?? 0) >=
                                                6)
                                              Container(
                                                width: 48,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 15, left: 2),
                                                    child: Text(
                                                      getIrrigationStatus(
                                                          modelData!.sIRR6 ??
                                                              0),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
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
                              top: getVerticalSize(
                                9.00,
                              ),
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
                                                child: AlertDialog(
                                                    title: Center(
                                                        child: Text(
                                                      'Interrogate',
                                                      textScaleFactor: 1,
                                                    )),
                                                    content: Container(
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
                                      height: getVerticalSize(
                                        27.00,
                                      ),
                                      width: getHorizontalSize(
                                        70.77,
                                      ),
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
                                            ColorConstant.cyan301,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: Text(
                                        "INTERROGATE",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorConstant.whiteA700,
                                          fontSize: getFontSize(
                                            9,
                                          ),
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
                                                child: AlertDialog(
                                                    title: Center(
                                                        child: Text(
                                                      'REFRESH',
                                                      textScaleFactor: 1,
                                                    )),
                                                    content: Container(
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
                                      height: getVerticalSize(
                                        27.00,
                                      ),
                                      width: getHorizontalSize(
                                        70.77,
                                      ),
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
                                            ColorConstant.cyan301,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: Text(
                                        "REFRESH",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorConstant.whiteA700,
                                          fontSize: getFontSize(
                                            9,
                                          ),
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
                                                child: AlertDialog(
                                                    title: Center(
                                                        child: Text(
                                                      'Irrigation Start/Stop',
                                                      textScaleFactor: 1,
                                                    )),
                                                    content: Container(
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
                                      height: getVerticalSize(
                                        27.00,
                                      ),
                                      width: getHorizontalSize(
                                        70.77,
                                      ),
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
                                            ColorConstant.cyan301,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: Text(
                                        "Irrigation \nStart/Stop",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorConstant.whiteA700,
                                          fontSize: getFontSize(
                                            9,
                                          ),
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
                                                child: AlertDialog(
                                                    title: Center(
                                                        child: Text(
                                                      '8 Days Schedule',
                                                      textScaleFactor: 1,
                                                    )),
                                                    content: Container(
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
                                                      modelData)));
                                    }
                                  }),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: getVerticalSize(
                                      27.00,
                                    ),
                                    width: getHorizontalSize(
                                      70.77,
                                    ),
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
                                          ColorConstant.cyan301,
                                        ],
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Text(
                                      "8 DAYS\nSCHEDULE",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorConstant.whiteA700,
                                        fontSize: getFontSize(
                                          9,
                                        ),
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
                                                child: AlertDialog(
                                                    title: Center(
                                                        child: Text(
                                                      'RMS Details',
                                                      textScaleFactor: 1,
                                                    )),
                                                    content: Container(
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
                                      await getRmsData(modelData!.rmsId!,
                                              modelData!.rmsNo!)
                                          .then((value) {
                                        if (value != null)
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RMS_Details_Screen(
                                                          value,
                                                          widget
                                                              .ProjectName!)));
                                      });
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: getVerticalSize(
                                      27.00,
                                    ),
                                    width: getHorizontalSize(
                                      70.77,
                                    ),
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
                                          ColorConstant.cyan301,
                                        ],
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Text(
                                      "RMS Details",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorConstant.whiteA700,
                                        fontSize: getFontSize(
                                          9,
                                        ),
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
                                  left: getHorizontalSize(
                                    6.00,
                                  ),
                                  top: getVerticalSize(
                                    13.00,
                                  ),
                                ),
                                child: Text(
                                  "LAST RESPONSE TIME :",
                                  textScaleFactor: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      9,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: getVerticalSize(
                                      13.00,
                                    ),
                                    left: getHorizontalSize(3.00)),
                                child:
                                    modelData!.lastResponseTime1!.length != null
                                        ? Text(
                                            getlongDate(modelData!
                                                .lastResponseTime1!
                                                .toString()),
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text("Never Connected",
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
                              left: getHorizontalSize(
                                6.00,
                              ),
                              top: getVerticalSize(
                                13.00,
                              ),
                              bottom: getVerticalSize(
                                3.00,
                              ),
                              right: getHorizontalSize(
                                10.00,
                              ),
                            ),
                            child: Text(
                              "LAST ROUTINE CHECK DONE ON :",
                              textScaleFactor: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorConstant.black900,
                                fontSize: getFontSize(
                                  9,
                                ),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                child: Container(
                  // width: 190,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Distributory : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                          Text(
                            (modelData!.distributaryName ?? '-').toString(),
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Chak Area : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData!.chakArea ?? 0.0).toString() + " HA",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Solar Voltage : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData!.solarVoltage ?? 0.0)
                                    .toStringAsFixed(2) +
                                " V",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                color: getSolarColor(
                                    (modelData!.solarVoltage ?? 0.0)),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(children: [
                        Text(
                          'Design Press : ',
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.normal),
                        ),
                        Text(
                          (modelData!.availableResidualHead ?? 0.0)
                                  .toStringAsFixed(2) +
                              " m",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      ]),
                      Row(
                        children: [
                          Text(
                            'Inlet Press : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (convertBartoMeter(modelData!.aI1) ?? 0.0)
                                    .toString() +
                                " m",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: modelData!.aI1 != 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Sus Press : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData!.sustPress1 ?? 0.0).toStringAsFixed(2) +
                                " m",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: modelData!.sustPress1 != 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Flow Set Point : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData!.flow ?? 0.0).toStringAsFixed(2) +
                                " LPS",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: modelData!.flowSetPt1 != 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Calculated Volume : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData!.dailyVolume ?? 0.0).toStringAsFixed(2) +
                                " m³",
                            textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              // color:
                              //     modelData!.calculatedVolume !=
                              //             0
                              //         ? Colors.green
                              //         : Colors.red
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'OMS MODE : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            getOmsMode(modelData!.mode ?? 0),
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Valve Postition : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData!.valvePosition ?? 0.0)
                                    .toStringAsFixed(2) +
                                " %",
                            textScaleFactor: 1,
                            style: TextStyle(
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
                child: Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sub Area : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Expanded(
                            child: Text(
                              (modelData!.subChakArea1 ?? '-').toString(),
                              textScaleFactor: 1,
                              // values[index].areaName!,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Door : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData!.door1 == true ||
                                    modelData!.door2 == true
                                ? "OPEN"
                                : "CLOSE"),
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                color: (modelData!.door1 == true ||
                                        modelData!.door2 == true
                                    ? Colors.red
                                    : Colors.green),
                                // color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Battery Voltage : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                              (modelData!.batteryLevel ?? 0.0).toString() +
                                  " V",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: ((modelData!.batteryLevel ?? 0.0) > 17
                                      ? Colors.green
                                      : Colors.red),
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Design Flow Rate : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            getdesignflowrate() + ' LPS',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Outlet Press : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                              (convertBartoMeter(modelData!.outletPT) ?? 0.0)
                                      .toString() +
                                  " m",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: modelData!.outletPT != 0
                                      ? Colors.green
                                      : Colors.red))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Red Press : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            ((modelData!.redPress1) ?? 0.0).toStringAsFixed(2) +
                                " m",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: modelData!.redPress1 != 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Actual Flow Rate : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (((modelData!.flow) ?? 0.0) / 3.6)
                                    .toStringAsFixed(2) +
                                " LPS",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: modelData!.flow != 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Schedule : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            ((modelData!.schedule == 1 ? 'PRESENT' : 'ABSENT'))
                                    .toString() +
                                " ",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: modelData!.schedule != 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'ROMS MODE : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (getRomsMode(modelData!.rmode ?? 0)),
                            textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              // color:
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Irrigation Status : ',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            (modelData!.sIRR == 1 ? 'STOPPED' : 'STARTED')
                                    .toString() +
                                " ",
                            textScaleFactor: 1,
                            style: TextStyle(
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
              padding: EdgeInsets.only(left: 8),
              // color: Colors.lightBlue.shade300,
              width: 190,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        'Distributory : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      Expanded(
                        child: Text(
                          modelData!.distributaryName ?? '-',
                          textScaleFactor: 1,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Chak Area : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        (modelData!.chakArea ?? 0.0).toString() + " HA",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Solar Voltage : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        (modelData!.solarVoltage ?? 0.0).toStringAsFixed(2) +
                            " V",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10,
                            color: getSolarColor(modelData!.solarVoltage!),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(children: [
                    Text(
                      'Design Press : ',
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      (modelData!.availableResidualHead ?? 0.0)
                              .toStringAsFixed(2) +
                          " m",
                      textScaleFactor: 1,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ]),
                  Row(
                    children: [
                      Text(
                        'Inlet Press : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        (convertBartoMeter(modelData!.controllertype! == 'BOC'
                                        ? modelData!.aI1
                                        : modelData!.aI4) ??
                                    0.0)
                                .toString() +
                            " m",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: modelData!.aI4 != 0
                                ? Colors.green
                                : Colors.red),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              // color: Colors.deepPurple.shade300,
              width: 190,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sub Area : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Expanded(
                        child: Text(
                          (modelData!.areaName ?? '-').toString(),
                          textScaleFactor: 1,
                          // values[index].areaName!,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Door : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        (modelData!.door1 == 1 ||
                                modelData!.door2 == 1 ||
                                modelData!.door3 == 1
                            ? "OPEN"
                            : "CLOSE"),
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10,
                            color: (modelData!.door1 == 1 ||
                                    modelData!.door2 == 1 ||
                                    modelData!.door3 == 1
                                ? Colors.red
                                : Colors.green),
                            // color: Colors.green,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Battery Voltage : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text((modelData!.batteryLevel ?? 0.0).toString() + " V",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 10,
                              color: getbatteryvoltageColor(modelData!),
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Design Flow Rate : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        (((modelData!.duty ?? 0.0) *
                                        (modelData!.chakArea ?? 0.0)) ??
                                    0.0)
                                .toStringAsFixed(2) +
                            ' LPS',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Outlet Press : ',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                          (convertBartoMeter(modelData!.controllertype! == 'BOC'
                                          ? modelData!.aI2
                                          : modelData!.aI3) ??
                                      0.0)
                                  .toString() +
                              " m",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: (modelData!.controllertype! == 'BOC'
                                          ? modelData!.aI2
                                          : modelData!.aI3) !=
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
      if (widget.ProjectName!.toLowerCase().contains('hanuman')) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                ///text
                                Container(
                                  height: 16,
                                  child: Text(
                                    (convertBartoMeter(
                                                modelData!.controllertype ==
                                                        'BOC'
                                                    ? modelData!.aI1
                                                    : modelData!.aI4) ??
                                            0.0) +
                                        " m",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),

                                ///Pipe
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 3),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                        Colors.grey.shade500,
                                        Colors.grey.shade500,
                                        Color.fromARGB(26, 199, 199, 199),
                                        Colors.grey.shade500,
                                        Colors.grey.shade500,
                                      ])),
                                  // color: Colors.red,
                                  width:
                                      MediaQuery.of(context).size.width * 0.11,
                                  height: 15,
                                ),

                                ///text
                                SizedBox(
                                  height: 16,
                                  child: Text(
                                    ((modelData!.flow ?? 0.0) / 3.6)
                                            .toStringAsFixed(2) +
                                        " LPS",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ],
                            ),

                            ///pipe cap2
                            Container(
                              width: 4,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade500,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0)),
                              ),
                            ),

                            ///pipe cap1
                            Container(
                              width: 6,
                              // width: width * 0.1,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade500,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                            ),

                            ///PFCMD
                            Container(
                              width: 45,
                              height: 140,
                              // color: Colors.blue,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 60,
                                    child: Container(
                                      width: 50,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        // color: Color.fromARGB(255, 235, 232, 20), //dcc600
                                        color: getpfcmdcolor(
                                            (modelData!.valvePosition ?? 0),
                                            (modelData!.flow ?? 0)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    getOmsMode(modelData!.mode ?? 0),
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 12,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Positioned(
                                    top: 45,
                                    left: 7,
                                    child: Text(
                                      (modelData!.valvePosition ?? 0.0)
                                              .toStringAsFixed(2) +
                                          " %",
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        fontSize: 9,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///pipe cap1
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: Container(
                      width: 6,
                      // width: width * 0.1,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                          // BorderRadius.only(
                          //     bottomLeft: Radius
                          //         .circular(
                          //             5.0),
                          //     bottomRight: Radius
                          //         .circular(
                          //             5.0)),
                          ),
                    ),
                  ),

                  ///pipe cap2
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0)),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: Column(
                      children: [
                        Container(
                          height: 16,
                          child: Text(
                            (convertBartoMeter(
                                        modelData!.controllertype == 'BOC'
                                            ? modelData!.aI2
                                            : modelData!.aI3) ??
                                    0.0) +
                                " m",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.grey.shade500,
                                Colors.grey.shade500,
                                Color.fromARGB(26, 199, 199, 199),
                                Colors.grey.shade500,
                                Colors.grey.shade500,
                              ])),
                          width: 40,
                          height: 15,
                        ),
                        SizedBox(
                          height: 16,
                          child: Text(
                            (modelData!.dailyVolume ?? 0.0).toStringAsFixed(1) +
                                " m³",
                            style: TextStyle(fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),

                  ///Valves
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ///valve 1 and 5
                          Column(children: [
                            if (modelData!.subChakQty != 0)
                              Column(
                                children: [
                                  if (modelData!.subChakQty! >= 1)
                                    Text(
                                      "V1",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                    width: 30,
                                    child: Image(
                                        image: AssetImage(getValvecolor(
                                            modelData!.statusValve1 ?? 0))),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                          Colors.grey.shade500,
                                          Colors.grey.shade500,
                                          Color.fromARGB(26, 199, 199, 199),
                                          Colors.grey.shade500,
                                          Colors.grey.shade500,
                                        ])),
                                    width: 30,
                                    height: 15,
                                  ),
                                  // if (modelData!
                                  //         .v5IsAvailable ==
                                  //     0)
                                  //   Text(
                                  //     "  ",
                                  //   ),
                                ],
                              ),
                            if (modelData!.subChakQty! >= 5)
                              Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                    width: 30,
                                    child: Image(
                                        image: AssetImage(getValvecolor(
                                            modelData!.statusValve5 ?? 0))),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  Text(
                                    "V5",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            if (modelData!.subChakQty! < 5)
                              SizedBox(
                                height: 92,
                              )
                          ]),

                          ///valve 2 and 6
                          Column(children: [
                            if (modelData!.subChakQty! >= 2)
                              Column(
                                children: [
                                  Text(
                                    "V2",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                    width: 30,
                                    child: Image(
                                        image: AssetImage(getValvecolor(
                                            modelData!.statusValve2 ?? 0))),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                          Colors.grey.shade500,
                                          Colors.grey.shade500,
                                          Color.fromARGB(26, 199, 199, 199),
                                          Colors.grey.shade500,
                                          Colors.grey.shade500,
                                        ])),
                                    width: 30,
                                    height: 15,
                                  ),
                                ],
                              ),
                            if (modelData!.subChakQty! >= 6)
                              Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                    width: 30,
                                    child: Image(
                                        image: AssetImage(getValvecolor(
                                            modelData!.statusValve6 ?? 0))),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  Text(
                                    "V6",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            if (modelData!.subChakQty! < 6)
                              SizedBox(
                                height: 92,
                              ),
                          ]),

                          ///valve 3 and 7
                          Column(children: [
                            if (modelData!.subChakQty! >= 3)
                              Column(
                                children: [
                                  Text(
                                    "V3",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                    width: 30,
                                    child: Image(
                                        image: AssetImage(getValvecolor(
                                            modelData!.statusValve3 ?? 0))),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                          Colors.grey.shade500,
                                          Colors.grey.shade500,
                                          Color.fromARGB(26, 199, 199, 199),
                                          Colors.grey.shade500,
                                          Colors.grey.shade500,
                                        ])),
                                    width: 30,
                                    height: 15,
                                  ),
                                ],
                              ),
                            if (modelData!.subChakQty! >= 7)
                              Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                    width: 30,
                                    child: Image(
                                        image: AssetImage(getValvecolor(
                                            modelData!.statusValve7 ?? 0))),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  Text(
                                    "V7",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            if (modelData!.subChakQty! < 7)
                              SizedBox(
                                height: 92,
                              ),
                          ]),

                          ///valve 4 and 8
                          Column(children: [
                            if (modelData!.subChakQty! >= 4)
                              Column(
                                children: [
                                  Text(
                                    "V4",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                    width: 30,
                                    child: Image(
                                        image: AssetImage(getValvecolor(
                                            modelData!.statusValve4 ?? 0))),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                          Colors.grey.shade500,
                                          Colors.grey.shade500,
                                          Color.fromARGB(26, 199, 199, 199),
                                          Colors.grey.shade500,
                                          Colors.grey.shade500,
                                        ])),
                                    width: 30,
                                    height: 15,
                                  ),
                                ],
                              ),
                            if (modelData!.subChakQty! >= 8)
                              Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                    width: 30,
                                    child: Image(
                                        image: AssetImage(getValvecolor(
                                            modelData!.statusValve8 ?? 0))),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                    ])),
                                    width: 8,
                                    height: 25,
                                  ),
                                  Text(
                                    "V8",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            if (modelData!.subChakQty! < 8)
                              SizedBox(
                                height: 92,
                              ),
                          ]),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '',
                            // getRomsMode(modelData!.romsMode ?? 0),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      } else {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(
              left: getHorizontalSize(
                3.00,
              ),
              top: getVerticalSize(
                2.00,
              ),
            ),
            child: Container(
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
                            Container(
                              margin: const EdgeInsets.only(left: 7, top: 10),
                              // width: height * 0.03,
                              height: height * 0.07,
                              //color: Colors.grey,
                              child: Text(
                                "P1 : \n" +
                                    (convertBartoMeter(
                                                modelData!.controllertype ==
                                                        'BOC'
                                                    ? modelData!.aI1
                                                    : modelData!.aI4) ??
                                            0.0)
                                        .toString() +
                                    "m",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getFontSize(
                                    8,
                                  ),
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
                                "P2 : \n" +
                                    (convertBartoMeter(
                                                modelData!.controllertype ==
                                                        'BOC'
                                                    ? modelData!.aI2
                                                    : modelData!.aI3) ??
                                            0.0)
                                        .toString() +
                                    "m",
                                textScaleFactor: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getFontSize(
                                    8,
                                  ),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 2),
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
                                    left: 20,
                                  ),
                                  height: height * 0.01,
                                  width: width * 0.09,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Container(
                              height: 15,
                              width: 4,
                              color: Colors.black,
                            ),
                            Row(
                              children: [
                                Center(
                                  child: Container(
                                    height: height * 0.055,
                                    width: width * 0.025,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
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
                                    border: Border.all(color: Colors.grey),
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
                                            colors: modelData!.filterChoke == 0
                                                ? [
                                                    ColorConstant
                                                        .lightGreenA700,
                                                    ColorConstant.green900,
                                                    ColorConstant.whiteA700
                                                  ]
                                                : [
                                                    ColorConstant.redA700,
                                                    ColorConstant.redA701,
                                                    ColorConstant.whiteA700
                                                  ]),
                                        borderRadius: BorderRadius.all(
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: height * 0.01,
                              width: width * 0.15,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.black,
                              ),
                            ),
                            Container(
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
                              height: height * 0.03,
                              width: width * 0.025,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: height * 0.03,
                                  width: width * 0.022,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  height: height * 0.01,
                                  width: width * 0.045,
                                  decoration:
                                      const BoxDecoration(color: Colors.black),
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
                              "△P : \n" +
                                  (getPDeltaValue(
                                          ((modelData!.controllertype! == 'BOC'
                                                  ? modelData!.aI1
                                                  : modelData!.aI4) ??
                                              0.0),
                                          ((modelData!.controllertype! == 'BOC'
                                                  ? modelData!.aI2
                                                  : modelData!.aI3) ??
                                              0.0)))
                                      .toStringAsFixed(2) +
                                  "m",
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: getFontSize(
                                  8,
                                ),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        for (var i = 1; i <= modelData!.subChakQty!; i++)
                          Padding(
                            padding: const EdgeInsets.only(top: 28.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.grey.shade500,
                                      Colors.grey.shade500,
                                      Color.fromARGB(26, 199, 199, 199),
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
                                          Color.fromARGB(26, 199, 199, 199),
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
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5.0),
                                            topRight: Radius.circular(5.0)),
                                      ),
                                    ),
                                    Container(
                                      width: 27,
                                      height: height * 0.015,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade500,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 14.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
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
                                                                modelData!, i)
                                                            .toString(),
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 2,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Container(
                                                  width: 13,
                                                  height: 13,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    color: Colors.grey[350],
                                                  ),
                                                  // color: Colors
                                                  //         .grey[
                                                  //     350],
                                                  child: Center(
                                                    child: Text(
                                                        // "f",
                                                        getsmodevalve(
                                                                modelData!, i)
                                                            .toString(),
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
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
                                              color: getPFCMDContainerColor(
                                                  modelData!, i))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 27,
                                      // width: width * 0.1,
                                      height: height * 0.015,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade500,
                                          borderRadius: BorderRadius.all(
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
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5.0),
                                            bottomRight: Radius.circular(5.0)),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                        colors: [
                                          Colors.grey.shade500,
                                          Colors.grey.shade500,
                                          Color.fromARGB(26, 199, 199, 199),
                                          Colors.grey.shade500,
                                          Colors.grey.shade500
                                        ],
                                      )),
                                      width: width * 0.06,
                                      height: height * 0.04,
                                      // color: Colors.red,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Text(
                                        "PFCMD" + i.toString(),
                                        textScaleFactor: 1,
                                        style: TextStyle(
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
          ),
        );
      }
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
    chakarea = (modelData!.chakArea ?? 0.0);
    var flowrate;
    flowrate = (modelData!.duty ?? 0);

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
      _search = modelData!.chakNo!;
      var aid = modelData!.areaId!;
      var did = modelData!.distributaryId!;
      final res = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/Project/OMSDisplayList?Search=$_search&_aid=$aid&_did=$did&_OMSStatus=$OMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString'));
      print(
          'http://wmsservices.seprojects.in/api/Project/OMSDisplayList?Search=$_search&_aid=$aid&_did=$did&_OMSStatus=$OMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString');

      var json = jsonDecode(res.body);
      List<OmsMasterModel> fetchedData = <OmsMasterModel>[];
      json.forEach((e) => fetchedData.add(new OmsMasterModel.fromJson(e)));
      if (fetchedData.length > 0) {
        setState(() {
          modelData = fetchedData
              .singleWhere((element) => element.omsId! == modelData!.omsId!);
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
        posValve = (model.posValve1 == null ? 0.0 : model.posValve1);
        flowValve = (model.flowValve1 == null ? 0.0 : model.flowValve1);
        break;
      case 2:
        posValve = (model.posValve2 == null ? 0.0 : model.posValve2);
        flowValve = (model.flowValve2 == null ? 0.0 : model.flowValve2);
        break;
      case 3:
        posValve = (model.posValve3 == null ? 0.0 : model.posValve3);
        flowValve = (model.flowValve3 == null ? 0.0 : model.flowValve3);
        break;
      case 4:
        posValve = (model.posValve4 == null ? 0.0 : model.posValve4);
        flowValve = (model.flowValve4 == null ? 0.0 : model.flowValve4);
        break;
      case 5:
        posValve = (model.posValve5 == null ? 0.0 : model.posValve5);
        flowValve = (model.flowValve5 == null ? 0.0 : model.flowValve5);
        break;
      case 6:
        posValve = model.posValve6 == null ? 0.0 : model.posValve6;
        flowValve = model.flowValve6 == null ? 0.0 : model.flowValve6;
        break;
    }
    if (posValve < 2) {
      return Colors.red[900];
    } else if (posValve >= 2 && flowValve == 0) {
      return ColorConstant.yellowA400;
    } else if (posValve >= 2 && flowValve > 0) {
      return ColorConstant.green900;
    } else {
      return ColorConstant.gray300;
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
        if (modelData!.modeValve1 == 1) {
          return 'O';
        } else if (modelData!.modeValve1 == 2) {
          return 'F';
        } else if (modelData!.modeValve1 == 3) {
          return 'P';
        } else
          return 'N';
      case 2:
        if (modelData!.modeValve2 == 1) {
          return 'O';
        } else if (modelData!.modeValve2 == 2) {
          return 'F';
        } else if (modelData!.modeValve2 == 3) {
          return 'P';
        } else
          return 'N';

      case 3:
        if (modelData!.modeValve3 == 1) {
          return 'O';
        } else if (modelData!.modeValve3 == 2) {
          return 'F';
        } else if (modelData!.modeValve3 == 3) {
          return 'P';
        } else
          return 'N';
      case 4:
        if (modelData!.modeValve4 == 1) {
          return 'O';
        } else if (modelData!.modeValve4 == 2) {
          return 'F';
        } else if (modelData!.modeValve4 == 3) {
          return 'P';
        } else
          return 'N';

      case 5:
        if (modelData!.modeValve5 == 1) {
          return 'O';
        } else if (modelData!.modeValve5 == 2) {
          return 'F';
        } else if (modelData!.modeValve5 == 3) {
          return 'P';
        } else
          return 'N';

      case 6:
        if (modelData!.modeValve6 == 1) {
          return 'O';
        } else if (modelData!.modeValve6 == 2) {
          return 'F';
        } else if (modelData!.modeValve6 == 3) {
          return 'P';
        } else
          return 'N';
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
    List<OmsMasterModel>? _DisplayList = <OmsMasterModel>[];
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
      json.forEach((e) => fetchedData.add(new OmsMasterModel.fromJson(e)));
      _DisplayList = [];
      if (fetchedData.length > 0) {
        setState(() {
          _DisplayList!.addAll(fetchedData);
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
        if (modelData!.smodeValve1 == 1) {
          return 'A';
        } else if (modelData!.smodeValve1 == 2) {
          return 'M';
        } else if (modelData!.smodeValve1 == 3) {
          return 'T';
        } else
          return 'N';
      case 2:
        if (modelData!.smodeValve2 == 1) {
          return 'A';
        } else if (modelData!.smodeValve2 == 2) {
          return 'M';
        } else if (modelData!.smodeValve2 == 3) {
          return 'T';
        } else
          return 'N';
      case 3:
        if (modelData!.smodeValve3 == 1) {
          return 'A';
        } else if (modelData!.smodeValve3 == 2) {
          return 'M';
        } else if (modelData!.smodeValve3 == 3) {
          return 'T';
        } else
          return 'N';
      case 4:
        if (modelData!.smodeValve4 == 1) {
          return 'A';
        } else if (modelData!.smodeValve4 == 2) {
          return 'M';
        } else if (modelData!.smodeValve4 == 3) {
          return 'T';
        } else
          return 'N';

      case 5:
        if (modelData!.smodeValve5 == 1) {
          return 'A';
        } else if (modelData!.smodeValve5 == 2) {
          return 'M';
        } else if (modelData!.smodeValve5 == 3) {
          return 'T';
        } else
          return 'N';
      case 6:
        if (modelData!.smodeValve6 == 1) {
          return 'A';
        } else if (modelData!.smodeValve6 == 2) {
          return 'M';
        } else if (modelData!.smodeValve6 == 3) {
          return 'T';
        } else
          return 'N';
    }
  }

  getpop(context) {
    return showDialog(
      barrierDismissible: false,
      useSafeArea: false,
      context: context,
      builder: (ctx) => Container(
        child: Center(
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
      json.forEach((e) => fetchedData.add(new RMSMastermodel.fromJson(e)));
      if (fetchedData.length > 0) {
        return fetchedData.singleWhere((element) => element.rmsId! == rmsId!);
      }
    } catch (err) {}
  }
}
