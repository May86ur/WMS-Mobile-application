// ignore_for_file: unused_catch_stack, unused_local_variable, await_only_futures, must_be_immutable, unnecessary_null_comparison, camel_case_types, non_constant_identifier_names

import 'dart:convert';
// import 'dart:js';

import 'package:WMS_Application/Model/Project/OmsMasterModel.dart';
import 'package:WMS_Application/Model/Project/RMSMastermodel.dart';
import 'package:WMS_Application/Model/Project/RMS_Overview_model.dart';
import 'package:WMS_Application/Operations/CommonFunction.dart';
import 'package:WMS_Application/Operations/StateselectionOperation.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:WMS_Application/core/app_export.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

RMSMastermodel? modelData;
List<RMSMastermodel>? _DisplayList = <RMSMastermodel>[];

var _search = '';

var cheklist = ['All'];
int _page = 0;
int _limit = 20;
bool showButton = false;
bool _hasNextPage = true;

var _isFirstLoadRunning = false;

class RMS_Details_Screen extends StatefulWidget {
  String? ProjectName;

  RMS_Details_Screen(RMSMastermodel? _modelData, String project) {
    modelData = _modelData ?? null;
    ProjectName = project;
  }

  @override
  State<RMS_Details_Screen> createState() => _RMS_Details_ScreenState();
}

class _RMS_Details_ScreenState extends State<RMS_Details_Screen> {
  @override
  void initState() {
    _firstLoad();
    super.initState();
    _controller = new ScrollController()..addListener(_firstLoad);
  }

  @override
  void dispose() {
    _controller.removeListener(_firstLoad);
    super.dispose();
  }

  // Initial Selected Value
  var area = 'All';
  var distibutory = 'ALL';
  String? RMSStatusCheck = 'ALL';
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
                  ' - RMS',
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
                                  modelData!.rmsNo.toString(),
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
                              //*Battery
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, right: 10),
                                    child: Stack(children: [
                                      Image(
                                        image: AssetImage(
                                          getBattreydata_new(getBatpercentage(
                                              modelData!.batteryLevel1 ?? 0.0)),
                                        ),
                                        width: 40,
                                        height: 40,
                                      ),
                                      Positioned(
                                          top: 16,
                                          left: 10,
                                          child: Text(
                                            getBatpercentage(modelData!
                                                            .batteryLevel1 ??
                                                        0.0)
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
                          /*                        Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  'Chak No : ',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3, top: 10),
                                child: Text(
                                  modelData!.chakNo1.toString(),
                                  textScaleFactor: 1,
                                  // values[index].chakNo!.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue),
                                ),
                              ),
                            ],
                          ),
*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 8),
                                // color: Colors.lightBlue.shade300,
                                width: 190,
                                height: 120,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //AreaName
                                    Row(
                                      children: [
                                        Text(
                                          'Area Name : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          (modelData!.distributaryName ?? '-')
                                              .toString(),
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    //Valve Size
                                    Row(
                                      children: [
                                        Text(
                                          'Valve Size : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          (modelData!.valveSize ?? 0.0)
                                                  .toString() +
                                              ' mm',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    /*Row(
                                      children: [
                                        Text(
                                          'Operation Mode : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          getoperationmode(
                                              modelData!.rmsMode ?? 0),
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    
                                    */
                                    //Inlet Pressure
                                    Row(children: [
                                      Text(
                                        'Inlet Pressure : ',
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        convertBartoMeter(
                                                (modelData!.controllerType ==
                                                            'BOC'
                                                        ? modelData!.aI1
                                                        : modelData!.aI4) ??
                                                    0.0) +
                                            ' m',
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            color:
                                                (modelData!.aI1 ?? 0.00) != 0.00
                                                    ? Colors.green
                                                    : Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11),
                                      ),
                                    ]),
                                    //Valve Postion
                                    Row(
                                      children: [
                                        Text(
                                          'Valve Position : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          (getvalpos(modelData!) ?? 0.0)
                                              .toString(),
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    //Actual Flow Rate
                                    Row(
                                      children: [
                                        Text(
                                          'Actual Flow Rate : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          convertBartoMeter(
                                                      modelData!.ouletPipe ??
                                                          0.0)
                                                  .toString() +
                                              " m",
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Sus Pressure

                                    Row(
                                      children: [
                                        Text(
                                          'Sustaining Press : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          (convertBartoMeter(modelData!
                                                          .sustainingPressure) ??
                                                      0.0)
                                                  .toString() +
                                              " m",
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: modelData!
                                                          .sustainingPressure !=
                                                      0
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
                                height: 120,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //Network
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Network : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Expanded(
                                          child: Text(
                                            (modelData!.areaName ?? '-')
                                                .toString(),
                                            textScaleFactor: 1,
                                            // values[index].areaName!,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    //Design Flow
                                    Row(
                                      children: [
                                        Text(
                                          'Design Flow : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          (convertm3hrToLps((modelData!
                                                              .flowSetPoint ??
                                                          0.0) *
                                                      (modelData!.noOfValves ??
                                                          0.0))
                                                  .toString() +
                                              " lps"),
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              // color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    //Outlet Pressure
                                    Row(
                                      children: [
                                        Text(
                                          'Outlet Pressure : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          convertBartoMeter(
                                                  modelData!.aI2 ?? 0.0) +
                                              ' m',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: (modelData!.aI2 ?? 0) != 0
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    //Door
                                    Row(
                                      children: [
                                        Text(
                                          'Door : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          (modelData!.dI1 == 1 ||
                                                  modelData!.dI2 == 1
                                              ? "OPEN"
                                              : "CLOSE"),
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: (modelData!.dI1 == 1 ||
                                                      modelData!.dI2 == 1
                                                  ? Colors.red
                                                  : Colors.green),
                                              // color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),

                                    //Control Mode
                                    Row(
                                      children: [
                                        Text(
                                          'Control Mode : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                            getControllerMode(
                                                    modelData!.rmsMode ?? 0)
                                                .toString(),
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: (Colors.black),
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    /*Row(
                                      children: [
                                        Text(
                                          'Calculated Volume : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                            ((modelData!.calculatedVolume) ??
                                                        0.0)
                                                    .toString() +
                                                " m³",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black))
                                      ],
                                    ),*/
                                    //Red Pressure
                                    Row(
                                      children: [
                                        Text(
                                          'Reducing Pressure : ',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                            (convertBartoMeter(modelData!
                                                            .reducingPressure) ??
                                                        0.0)
                                                    .toString() +
                                                " m",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: modelData!
                                                            .reducingPressure !=
                                                        0
                                                    ? Colors.green
                                                    : Colors.red))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 17,
                          ),

                          ///PFCMD diagram
                          Container(
                            width: size.width * 0.97,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //*Part 1 *//
                                Stack(
                                  children: [
                                    //*Inlet PT*//
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 90.0, left: 25),
                                      child: Container(
                                        width: 130,
                                        child: Text(
                                          "Inlet PT:" +
                                              convertBartoMeter(
                                                      modelData!.aI1 ?? 0.0)
                                                  .toString() +
                                              " m",
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: 10,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //*Pipe INlet *//
                                    Positioned(
                                      top: 42,
                                      left: 10,
                                      child: Container(
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
                                        height: size.height * 0.022,
                                        width: size.width * 0.39,
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                  width: size.width * 0.012,
                                  height: size.height * 0.029,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade500,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                Container(
                                  width: size.width * 0.015,
                                  height: size.height * 0.04,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade500,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                ),
                                //* PFCMD Color Container *//
                                Stack(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 90.0),
                                      child: Container(
                                        width: size.width * 0.14,
                                        child: Center(
                                          child: Text(
                                            getControllerMode(
                                                modelData!.rmsMode ?? 0),
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 10,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 47,
                                      child: Container(
                                        width: size.width * 0.14,
                                        height: size.height * 0.025,
                                        decoration: BoxDecoration(
                                          // color: Color.fromARGB(255, 235, 232, 20), //dcc600
                                          color: getPFCMDContainerColor(
                                              modelData!),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 90.0),
                                      child: Container(
                                        width: size.width * 0.14,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                getvalpos(modelData!),
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                convertm3hrToLps(modelData!
                                                            .calculatedFlow ??
                                                        0.0) +
                                                    " lps",
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //* *//
                                Container(
                                  width: size.width * 0.015,
                                  height: size.height * 0.04,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade500,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                ),
                                Container(
                                  width: size.width * 0.012,
                                  height: size.height * 0.029,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade500,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),

                                //*Part 3 *//
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30, bottom: 90.0),
                                      child: Container(
                                        // color: Colors.red,
                                        width: size.width * 0.25,
                                        child: Text(
                                          "Outlet PT:" +
                                              convertBartoMeter(
                                                  modelData!.aI2 ?? 0.0) +
                                              " m",
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: 10,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 41,
                                      child: Container(
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
                                        height: size.height * 0.022,
                                        width: size.width * 0.38,
                                      ),
                                    ),
                                    /*Padding(
                                      padding: const EdgeInsets.only(
                                          left: 60, top: 90.0),
                                      child: Container(
                                        // color: Colors.red,
                                        width: size.width * 0.2,
                                        child: Text(
                                          (modelData!.calculatedVolume ?? 0.0)
                                                  .toStringAsFixed(2) +
                                              " m³",
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: 12,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  */
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 17,
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
/*                                if (showButton == true)
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
                                if (showButton == true)
                                  InkWell(
                                    onTap: (() {
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
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             Schedule_Screen()));
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
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
*/
                                ///OMS Details
                                InkWell(
                                  onTap: () {
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return Container(
                                    //           child: AlertDialog(
                                    //               title: Center(
                                    //                   child: Text(
                                    //                 'OMS Details',
                                    //                 textScaleFactor: 1,
                                    //               )),
                                    //               content: Container(
                                    //                 height: 100,
                                    //                 child: Center(
                                    //                   child: Text(
                                    //                     "Page Under Development",
                                    //                     textScaleFactor: 1,
                                    //                   ),
                                    //                 ),
                                    //               )));
                                    //     });

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              width: double.infinity,
                                              child: AlertDialog(
                                                  scrollable: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 1),
                                                  title: Center(
                                                      child: Text(
                                                    'OMS Details',
                                                    textScaleFactor: 1,
                                                  )),
                                                  content: Container(
                                                    child: Column(children: [
                                                      Text(
                                                        "RMS No : " +
                                                            modelData!.rmsNo
                                                                .toString(),
                                                        textScaleFactor: 1,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.cyan,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10))),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 40,
                                                              width:
                                                                  size.width *
                                                                      0.16,
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          width:
                                                                              1),
                                                                  borderRadius:
                                                                      BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(10))),
                                                              child: Center(
                                                                  child: Text(
                                                                "OMS No",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width:
                                                                  size.width *
                                                                      0.16,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                        width:
                                                                            1),
                                                              ),
                                                              child: Center(
                                                                  child: Text(
                                                                "Flow\n(LPS)",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width:
                                                                  size.width *
                                                                      0.16,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                        width:
                                                                            1),
                                                              ),
                                                              child: Center(
                                                                  child: Text(
                                                                "Volume\n(m³)",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width:
                                                                  size.width *
                                                                      0.16,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                        width:
                                                                            1),
                                                              ),
                                                              child: Center(
                                                                  child: Text(
                                                                "Irrigation\nStatus",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width:
                                                                  size.width *
                                                                      0.16,
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          width:
                                                                              1),
                                                                  borderRadius:
                                                                      BorderRadius.only(
                                                                          topRight:
                                                                              Radius.circular(10))),
                                                              child: Center(
                                                                  child: Text(
                                                                "Pressure",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      setupAlertDialoadContainer()
                                                    ]),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Text(
                                      "OMS Details",
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

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
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
                                  child: modelData!.lastResponseTime1!.length !=
                                          null
                                      ? Text(
                                          getlongDate(modelData!
                                              .lastResponseTime1!
                                              .toString()),
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text("Never Connected",
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold)),
                                ),
                              ],
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

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 900.0, // Change as per your requirement
      child: FutureBuilder(
          future: getomsdetails(modelData!.rmsId!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = (snapshot.data as List<OmsMasterModel>);
              return Scrollbar(
                controller: _controller,
                interactive: true,
                thickness: 12,
                radius: Radius.circular(20),
                thumbVisibility: true,
                child: ListView.builder(
                  controller: _controller,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: size.width * 0.16,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                          ),
                          child: Center(
                              child: Text(
                            data[index].chakNo.toString(),
                            style: TextStyle(fontSize: 12),
                          )),
                        ),
                        Container(
                          height: 40,
                          width: size.width * 0.16,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                          ),
                          child: Center(
                              child: Text(
                            (getFloatValue(data[index].flowValve1) +
                                    getFloatValue(data[index].flowValve2) +
                                    getFloatValue(data[index].flowValve3) +
                                    getFloatValue(data[index].flowValve4) +
                                    getFloatValue(data[index].flowValve5) +
                                    getFloatValue(data[index].flowValve6))
                                .toStringAsFixed(2),
                            style: TextStyle(fontSize: 12),
                          )),
                        ),
                        Container(
                          height: 40,
                          width: size.width * 0.16,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                          ),
                          child: Center(
                              child: Text(
                            (getFloatValue(data[index].volValve1) +
                                        getFloatValue(data[index].volValve2) +
                                        getFloatValue(data[index].volValve3) +
                                        getFloatValue(data[index].volValve4) +
                                        getFloatValue(data[index].volValve5) +
                                        getFloatValue(data[index].volValve6))
                                    .toStringAsFixed(2) +
                                " m³",
                            style: TextStyle(fontSize: 12),
                          )),
                        ),
                        Container(
                          height: 40,
                          width: size.width * 0.16,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                          ),
                          child: Center(
                              child: Text(
                            data[index].isIrrigationStarted! ? 'Start' : 'Stop',
                            style: TextStyle(fontSize: 12),
                          )),
                        ),
                        Container(
                          height: 40,
                          width: size.width * 0.16,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                          ),
                          child: Center(
                              child: Text(
                            (convertBartoMeter(
                                            data[index].controllertype! == 'BOC'
                                                ? data[index].aI1
                                                : data[index].aI4) ??
                                        0.0)
                                    .toString() +
                                " m",
                            style: TextStyle(fontSize: 12),
                          )),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Text('No data Found'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<List<RMS_Overview_model>>? OmsListFuture;
  List<RMS_Overview_model>? OmsOverviewList = [];
  Future<List<RMSMastermodel>>? DisplayListFuture;
  Future GetRmsOverviewModel() async {
    try {
      setState(() {
        OmsListFuture = getRmsOverviewdata(RMSStatusCheck!, DamageStatusCheck!,
            area.toString(), distibutory.toString());
        OmsListFuture!.then((value) {
          setState(() {
            OmsOverviewList = value;
          });
        });
      });
      _DisplayList = [];

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
      String? conString = preferences.getString('conString');
      String? liststatus = cheklist.join(',');
      _search = modelData!.rmsNo!;
      var aid = modelData!.areaId!;
      var did = modelData!.distributaryId!;
      final res = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/Project/RMSDisplayList?Search=$_search&_aid=$aid&_did=$did&_RMSStatus=$RMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString'));
      var json = jsonDecode(res.body);
      List<RMSMastermodel> fetchedData = <RMSMastermodel>[];
      json.forEach((e) => fetchedData.add(new RMSMastermodel.fromJson(e)));
      if (fetchedData.length > 0) {
        setState(() {
          modelData = fetchedData
              .singleWhere((element) => element.rmsId! == modelData!.rmsId!);
          getRmsOverviewdata(RMSStatusCheck!, DamageStatusCheck!,
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

    await GetRmsOverviewModel();
  }

  getlongDate(String date) {
    try {
      final DateTime now = DateTime.parse(date);
      final DateFormat formatter = DateFormat('EEEE, d MMMM y H:mm:ss');
      final String formatted = formatter.format(now);
      // print(formatted); // something like 2013-04-20
      return formatted;
    } catch (e) {
      return 'Never Connected';
    }
  }

  getvalpos(RMSMastermodel model) {
    if (model.aI1 == null) {
      return '-';
    } else if (model.aI1!.toDouble() > 100) {
      return '100 %';
    } else if (model.aI1!.toDouble() < 0) {
      return '0 %';
    } else {
      return model.aI1!.toStringAsFixed(2) + ' %';
    }
  }

  getControllerMode(int data) {
    if (data == 1) {
      return 'OPEN/CLOSE';
    } else if (data == 2) {
      return 'Flow Control';
    } else if (data == 3) {
      return 'Postion';
    } else {
      return 'Not Set';
    }
  }

  /* getControllerMode(int data) {
    if (data == 1) {
      return 'OPEN/CLOSE';
    } else if (data == 2) {
      return 'Flow bypass';
    } else if (data == 3) {
      return 'Flow Control';
    } else if (data == 4) {
      return 'Differential pressure';
    } else if (data == 5) {
      return 'Pressure relief';
    } else if (data == 6) {
      return 'Postion';
    } else if (data == 7) {
      return 'Sprinkler';
    } else if (data == 8) {
      return 'Design flow control';
    } else if (data == 9) {
      return 'Design Flow';
    } else if (data == 10) {
      return 'Pressurize irrigation';
    } else if (data == 11) {
      return 'Auto position';
    } else {
      return 'Not Set';
    }
  }*/

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

  getBatpercentage(double data) {
    var batVoltage;
    var batper = 0.0;
    try {
      return (data < 0 ? 0.0 : data);
      // batVoltage = data;
      // batper = (batVoltage - 11) * 100 / (16.5 - 11);
      // if (batper < 0.0) {
      //   return 0.0;
      // } else if (batper > 100.0) {
      //   return 0.0;
      // } else {
      //   return batper;
      // }
    } catch (_, ex) {}

    // return batper > 0 ? 0.0 : batper;
    return batper;
  }

  getPFCMDContainerColor(RMSMastermodel model) {
    try {
      var pos = modelData!.aI1;
      var flow = modelData!.calculatedFlow;
      var vol = modelData!.calculatedVolume;
      if (pos != null && flow != null && vol != null) {
        if (pos < 2) {
          return ColorConstant.redA700;
        } else if (pos >= 2 && flow > 0) {
          return ColorConstant.green900;
        } else if (pos >= 2 && flow == 0) {
          return ColorConstant.yellowA400;
        } else {
          return ColorConstant.gray300;
        }
      } else {
        return ColorConstant.gray300;
      }
    } catch (_, ex) {
      return ColorConstant.gray300;
    }
  }

  getinetletPressure(RMSMastermodel model) {
    if (model.batteryType == 'BOCOMS') {
      return model.aI1;
      // InletPT = RP.AI1;
      // OutletPT = RP.AI2;
      // Flow = RP.FLOWValve1;
      // Volume = RP.VOLValve1;
      // Position = RP.POSValve1;
    } else if (model.batteryType == 'OMS') {
      // InletPT = RP.DATA.AI3;
      // OutletPT = RP.DATA.AI4;
      // Flow = RP.DATA.FCL;
      // Volume = RP.DATA.DVLC;
      // Position = RP.DATA.AI1;
    }
  }

  convertBartoMeter(dynamic data) {
    if (data == null) {
      return '0.0';
    } else {
      var converted = data * 10.2;

      return converted.toStringAsFixed(2);
    }
  }

  void _firstLoad() async {
    List<RMSMastermodel>? _DisplayList = <RMSMastermodel>[];
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
          'http://wmsservices.seprojects.in/api/Project/RMSDisplayList?Search=$_search&_aid=$area&_did=$distibutory&_RMSStatus=$RMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString'));

      print(
          'http://wmsservices.seprojects.in/api/Project/RMSDisplayList?Search=$_search&_aid=$area&_did=$distibutory&_RMSStatus=$RMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString');

      var json = jsonDecode(res.body);
      List<RMSMastermodel> fetchedData = <RMSMastermodel>[];
      json.forEach((e) => fetchedData.add(new RMSMastermodel.fromJson(e)));
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

  late ScrollController _controller;
  getomsdetails(int rmsid) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //int? userid = preferences.getInt('userid');
      String? conString = preferences.getString('conString');

      final res = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/RMS/GetOmsbyRmsId?RmsId=$rmsid&conString=$conString'));

      var json = jsonDecode(res.body);
      List<OmsMasterModel> fetchedData = <OmsMasterModel>[];
      json.forEach((e) => fetchedData.add(new OmsMasterModel.fromJson(e)));

      return fetchedData;
    } catch (err) {
      print('Something went wrong');
    }
  }

  getIrrigationStatus(int irristatus) {
    try {
      if (irristatus == 1) {
        return 'Start';
      } else if (irristatus == 0) {
        return 'Stop';
      } else {
        return 'Not Set';
      }
    } catch (_, ex) {
      return 'Not Set';
    }
  }

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Container(
      width: size.width,
      height: 100,
      child: Center(
        child: Column(
          children: [
            Text(
              "RMS No :: VX-ER32",
              textScaleFactor: 1,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: Text("_________"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: Text("Flow(LPS)"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: Text("Volume(m³)"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: Text("Irrigation\nStatus"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: Text("Pressure"),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        child: Text("OK"),
        onPressed: () {},
      ),
    ],
  );
}
