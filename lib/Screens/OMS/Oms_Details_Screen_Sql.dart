// ignore_for_file: unused_local_variable, unused_catch_stack, unnecessary_null_comparison

import 'dart:convert';

import 'package:WMS_Application/Model/Project/OmsSqlMasterModel.dart';
import 'package:WMS_Application/Operations/StateselectionOperation.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/Screens/OMS/8day_schedule_Screen_SQL.dart';
// import 'package:WMS_Application/Screens/OMS/8days_schedule_screen.dart';
import 'package:WMS_Application/Screens/OMS/Oms_Details_Screen.dart';
import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:WMS_Application/core/app_export.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

OmsSqlMasterModel? modelData;
var _search = '';
var cheklist = ['All'];
int _page = 0;
int _limit = 20;

//run karo

// ignore: must_be_immutable
class OMS_Details_Screen_Sql extends StatefulWidget {
  String? ProjectName;

  OMS_Details_Screen_Sql(OmsSqlMasterModel? _modelData, String project) {
    modelData = _modelData ?? null;
    ProjectName = project;
  }

  @override
  State<OMS_Details_Screen_Sql> createState() => _OMS_Details_Screen_SqlState();
}

class _OMS_Details_Screen_SqlState extends State<OMS_Details_Screen_Sql> {
  var area = 'All';
  var distibutory = 'ALL';
  String? OMSStatusCheck = 'ALL';
  String? DamageStatusCheck = 'ALL';
  @override
  Widget build(BuildContext context) {
    double height = 400;
    double width = 200;

    int length = 6;
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
            await _reload();
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
                              color: (modelData!.isConnected == 1
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
                                  modelData!.chakNo.toString(),
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
                              ///Battery
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, right: 10),
                                    child: Stack(children: [
                                      Image(
                                        image: AssetImage(
                                          getBattreydata_new(getBatpercentage(
                                              modelData!.batteryLevel != null
                                                  ? modelData!.batteryLevel!
                                                  : 0.0)),
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
                                            getBatpercentage(modelData!
                                                                .batteryLevel !=
                                                            null
                                                        ? modelData!
                                                            .batteryLevel!
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
                                    (modelData!.solarVoltage ?? 0.0)
                                            .toStringAsFixed(0) +
                                        " V",
                                    textScaleFactor: 1,
                                    style: TextStyle(fontSize: 8),
                                  )
                                ],
                              ),

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

                          ///Data
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Container(
                                    // width: 190,
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                              (modelData!.distributaryName ??
                                                      '-')
                                                  .trim()
                                                  .toString(),
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Chak Area : ',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              (modelData!.chakArea ?? 0.0)
                                                      .toString() +
                                                  " HA",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Solar Voltage : ',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              (modelData!.solarVoltage ?? 0.0)
                                                      .toStringAsFixed(2) +
                                                  " V",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: getSolarColor(
                                                      (modelData!
                                                              .solarVoltage ??
                                                          0.0)),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(children: [
                                          Text(
                                            'Design Press : ',
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                            (modelData!.designPressure ?? 0.0)
                                                    .toStringAsFixed(2) +
                                                " m",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                        ]),
                                        Row(
                                          children: [
                                            Text(
                                              'Inlet Press : ',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              (convertBartoMeter(modelData!
                                                              .inLetPressure) ??
                                                          0.0)
                                                      .toString() +
                                                  " m",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: modelData!
                                                              .inLetPressure !=
                                                          0
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
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              (modelData!.sustainingPressure ??
                                                          0.0)
                                                      .toStringAsFixed(2) +
                                                  " m",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: modelData!
                                                              .sustainingPressure !=
                                                          0
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
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              (modelData!.setFlow ?? 0.0)
                                                      .toStringAsFixed(2) +
                                                  " LPS",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: modelData!.setFlow != 0
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
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              (modelData!.calculatedVolume ??
                                                          0.0)
                                                      .toStringAsFixed(2) +
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
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              widget.ProjectName!
                                                      .toLowerCase()
                                                      .contains('cluster')
                                                  ? getOmsMode_Odisha(
                                                      modelData!.oMODE ?? 0)
                                                  : getOmsMode(
                                                      modelData!.oMODE ?? 0),
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
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                                    // color: Colors.deepPurple.shade300,
                                    // width: 190,
                                    height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Sub Area : ',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Expanded(
                                              child: Text(
                                                (modelData!.subArea ?? '-')
                                                    .toString(),
                                                textScaleFactor: 1,
                                                // values[index].areaName!,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              (modelData!.door1 == true ||
                                                      modelData!.door2 == true
                                                  ? "OPEN"
                                                  : "CLOSE"),
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: (modelData!.door1 ==
                                                              true ||
                                                          modelData!.door2 ==
                                                              true
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
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                                (modelData!.batteryLevel ?? 0.0)
                                                        .toString() +
                                                    " V",
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color:
                                                        ((modelData!.batteryLevel ??
                                                                    0.0) >
                                                                17
                                                            ? Colors.green
                                                            : Colors.red),
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Design Flow Rate : ',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              getdesignflowrate() + ' LPS',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Outlet Press : ',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                                (convertBartoMeter(modelData!
                                                                .outLetPressure) ??
                                                            0.0)
                                                        .toString() +
                                                    " m",
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: modelData!
                                                                .outLetPressure !=
                                                            0
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
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              ((modelData!.reducingPressure) ??
                                                          0.0)
                                                      .toStringAsFixed(2) +
                                                  " m",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: modelData!
                                                              .inLetPressure !=
                                                          0
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
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              (((modelData!.flowRate) ?? 0.0) /
                                                          3.6)
                                                      .toStringAsFixed(2) +
                                                  " LPS",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      modelData!.flowRate != 0
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
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              ((modelData!.scheduleStatus == 1
                                                          ? 'PRESENT'
                                                          : 'ABSENT'))
                                                      .toString() +
                                                  " ",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: modelData!
                                                              .scheduleStatus !=
                                                          0
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
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              (getRomsMode(
                                                  modelData!.romsMode ?? 0)),
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
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              (modelData!.sIRR == 1
                                                          ? 'STOPPED'
                                                          : 'STARTED')
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
                          ),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 80.0),
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
                                                      (convertBartoMeter(modelData!
                                                                  .inLetPressure) ??
                                                              0.0) +
                                                          " m",
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),

                                                  ///Pipe
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5,
                                                        bottom: 5,
                                                        left: 3),
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                          Color.fromARGB(26,
                                                              199, 199, 199),
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                        ])),
                                                    // color: Colors.red,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.11,
                                                    height: 15,
                                                  ),

                                                  ///text
                                                  SizedBox(
                                                    height: 16,
                                                    child: Text(
                                                      ((modelData!.flowRate ??
                                                                      0.0) /
                                                                  3.6)
                                                              .toStringAsFixed(
                                                                  2) +
                                                          " LPS",
                                                      style: TextStyle(
                                                          fontSize: 10),
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5.0)),
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
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0))),
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
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: Color.fromARGB(255, 235, 232, 20), //dcc600
                                                          color: getpfcmdcolor(
                                                              (modelData!
                                                                      .valvePosition ??
                                                                  0),
                                                              (modelData!
                                                                      .flowRate ??
                                                                  0)),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      widget.ProjectName!
                                                              .toLowerCase()
                                                              .contains(
                                                                  'cluster')
                                                          ? getOmsMode_Odisha(
                                                              modelData!
                                                                      .oMODE ??
                                                                  0)
                                                          : getOmsMode(
                                                              modelData!
                                                                      .oMODE ??
                                                                  0),
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
                                                        (modelData!.valvePosition ??
                                                                    0.0)
                                                                .toStringAsFixed(
                                                                    2) +
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
                                      padding:
                                          const EdgeInsets.only(bottom: 80.0),
                                      child: Container(
                                        width: 6,
                                        // width: width * 0.1,
                                        height: 30,
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
                                    ),

                                    ///pipe cap2
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 80.0),
                                      child: Container(
                                        width: 4,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade500,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5.0),
                                              bottomRight:
                                                  Radius.circular(5.0)),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 80.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 16,
                                            child: Text(
                                              (modelData!.outLetPressure ?? 0.0)
                                                      .toStringAsFixed(2) +
                                                  " m",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                  Colors.grey.shade500,
                                                  Colors.grey.shade500,
                                                  Color.fromARGB(
                                                      26, 199, 199, 199),
                                                  Colors.grey.shade500,
                                                  Colors.grey.shade500,
                                                ])),
                                            width: 40,
                                            height: 15,
                                          ),
                                          SizedBox(
                                            height: 16,
                                            child: Text(
                                              (modelData!.calculatedVolume ??
                                                          0.0)
                                                      .toStringAsFixed(1) +
                                                  " m³",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    ///Valves
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ///valve 1 and 5
                                            Column(children: [
                                              if (modelData!.v1IsAvailable != 0)
                                                Column(
                                                  children: [
                                                    if (modelData!
                                                            .v1IsAvailable !=
                                                        0)
                                                      Text(
                                                        "V1",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    SizedBox(
                                                      height: 30.0,
                                                      width: 30,
                                                      child: Image(
                                                          image: AssetImage(
                                                              getValvecolor(
                                                                  modelData!
                                                                          .v1IsInIrr ??
                                                                      0))),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
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
                                              if (modelData!.v5IsAvailable != 0)
                                                Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    SizedBox(
                                                      height: 30.0,
                                                      width: 30,
                                                      child: Image(
                                                          image: AssetImage(
                                                              getValvecolor(
                                                                  modelData!
                                                                          .v5IsInIrr ??
                                                                      0))),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    Text(
                                                      "V5",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              if (modelData!.v5IsAvailable != 1)
                                                SizedBox(
                                                  height: 92,
                                                )
                                            ]),

                                            ///valve 2 and 6
                                            Column(children: [
                                              if (modelData!.v2IsAvailable != 0)
                                                Column(
                                                  children: [
                                                    Text(
                                                      "V2",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    SizedBox(
                                                      height: 30.0,
                                                      width: 30,
                                                      child: Image(
                                                          image: AssetImage(
                                                              getValvecolor(
                                                                  modelData!
                                                                          .v2IsInIrr ??
                                                                      0))),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 30,
                                                      height: 15,
                                                    ),
                                                  ],
                                                ),
                                              if (modelData!.v6IsAvailable != 0)
                                                Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    SizedBox(
                                                      height: 30.0,
                                                      width: 30,
                                                      child: Image(
                                                          image: AssetImage(
                                                              getValvecolor(
                                                                  modelData!
                                                                          .v6IsInIrr ??
                                                                      0))),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    Text(
                                                      "V6",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              if (modelData!.v6IsAvailable != 1)
                                                SizedBox(
                                                  height: 92,
                                                ),
                                            ]),

                                            ///valve 3 and 7
                                            Column(children: [
                                              if (modelData!.v3IsAvailable != 0)
                                                Column(
                                                  children: [
                                                    Text(
                                                      "V3",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    SizedBox(
                                                      height: 30.0,
                                                      width: 30,
                                                      child: Image(
                                                          image: AssetImage(
                                                              getValvecolor(
                                                                  modelData!
                                                                          .v3IsInIrr ??
                                                                      0))),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 30,
                                                      height: 15,
                                                    ),
                                                  ],
                                                ),
                                              if (modelData!.v7IsAvailable != 0)
                                                Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    SizedBox(
                                                      height: 30.0,
                                                      width: 30,
                                                      child: Image(
                                                          image: AssetImage(
                                                              getValvecolor(
                                                                  modelData!
                                                                          .v7IsInIrr ??
                                                                      0))),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    Text(
                                                      "V7",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              if (modelData!.v7IsAvailable != 1)
                                                SizedBox(
                                                  height: 92,
                                                ),
                                            ]),

                                            ///valve 4 and 8
                                            Column(children: [
                                              if (modelData!.v4IsAvailable != 0)
                                                Column(
                                                  children: [
                                                    Text(
                                                      "V4",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    SizedBox(
                                                      height: 30.0,
                                                      width: 30,
                                                      child: Image(
                                                          image: AssetImage(
                                                              getValvecolor(
                                                                  modelData!
                                                                          .v4IsInIrr ??
                                                                      0))),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 30,
                                                      height: 15,
                                                    ),
                                                  ],
                                                ),
                                              if (modelData!.v8IsAvailable != 0)
                                                Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    SizedBox(
                                                      height: 30.0,
                                                      width: 30,
                                                      child: Image(
                                                          image: AssetImage(
                                                              getValvecolor(
                                                                  modelData!
                                                                          .v8IsInIrr ??
                                                                      0))),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                            Color.fromARGB(26,
                                                                199, 199, 199),
                                                            Colors
                                                                .grey.shade500,
                                                            Colors
                                                                .grey.shade500,
                                                          ])),
                                                      width: 8,
                                                      height: 25,
                                                    ),
                                                    Text(
                                                      "V8",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              if (modelData!.v8IsAvailable != 1)
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
                                              getRomsMode(
                                                  modelData!.romsMode ?? 0),
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
                          ),

                          /// Button
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
                                        .contains('cluster-x')) {
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
                                                  Schedule_Screen_SQL(
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
                                child: modelData!.lastResponseTime1 != null
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

                          ///Last routine check
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
                              Padding(
                                padding: EdgeInsets.only(
                                    top: getVerticalSize(
                                      13.00,
                                    ),
                                    left: getHorizontalSize(3.00)),
                                child: modelData!.workedOn != null
                                    ? Text(
                                        getlongDate(
                                            modelData!.workedOn!.toString()),
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text("NA",
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                              ),
                            ],
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

  Future _reload() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //int? userid = preferences.getInt('userid');
      String? conString = preferences.getString('conString');
      //String? project = preferences.getString('project');
      String? liststatus = cheklist.join(',');
      _search = modelData!.chakNo!;
      var aid = modelData!.areaId!;
      var did = modelData!.distributroyId!;
      final res = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/Project/OMSDisplayList?Search=$_search&_aid=$aid&_did=$did&_OMSStatus=$OMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString'));

      // print("----------------------------------------------------");
      // print(
      //     'http://wmsservices.seprojects.in/api/Project/OMSDisplayList?Search=$_search&_aid=$aid&_did=$did&_OMSStatus=$OMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString');

      var json = jsonDecode(res.body);
      List<OmsSqlMasterModel> fetchedData = <OmsSqlMasterModel>[];
      json.forEach((e) => fetchedData.add(new OmsSqlMasterModel.fromJson(e)));
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
  }

  getlongDate(String date) {
    final DateTime now = DateTime.parse(date);
    final DateFormat formatter = DateFormat('EEEE, d MMMM y H:m:s');
    final String formatted = formatter.format(now);
    // print(formatted); // something like 2013-04-20
    return formatted;
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

  String getGSMlevel(int LevelStatus) {
    {
      if (LevelStatus == 1) {
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

  getOmsMode_Odisha(int oms) {
    if (oms == 1) {
      return 'OPEN/CLOSE';
    } else if (oms == 2) {
      return 'Flow Control';
    } else if (oms == 3) {
      return 'Position Control';
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
      return 'Flow Control';
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

  getdesignflowrate() {
    var chakarea;
    chakarea = modelData!.chakArea;
    var flowrate;
    flowrate = modelData!.flowratePerHa;

    var designflowratehr = chakarea * flowrate;

    return designflowratehr.toStringAsFixed(2);
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

  getBatpercentage(double BatLevel) {
    try {
      if (BatLevel == 0) {
        return 0.0;
      } else {
        var BatLvl = widget.ProjectName!.toLowerCase().contains("cluster")
            ? ((BatLevel - 2.8) * 100 / (3.3 - 2.8))
            : ((BatLevel - 11.1) * 100 / (16.8 - 11.1));

        if (BatLvl > 100.00) {
          return 100.00;
        } else if (BatLvl <= 0.0) {
          return 0.0;
        } else {
          return BatLvl;
        }
      }
    } catch (_, ex) {}
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

  convertBartoMeter(dynamic data) {
    if (data == null) {
      return '0.0';
    } else {
      var converted = data * 10.2;
      return converted.toStringAsFixed(2);
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
}
