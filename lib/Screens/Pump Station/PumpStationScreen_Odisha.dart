// ignore_for_file: must_be_immutable, non_constant_identifier_names, camel_case_types, unused_catch_stack

import 'dart:async';

import 'package:WMS_Application/Model/Project/PumpstationDropDownModel.dart';
import 'package:WMS_Application/Model/Project/PumpstationMasterModel.dart';
import 'package:WMS_Application/Operations/StateselectionOperation.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:WMS_Application/core/app_export.dart';
import 'package:intl/intl.dart';

class PumpStation_Screen extends StatefulWidget {
  String? ProjectName;
  var Psid;
  PumpStation_Screen(String project, {var psid = 'All'}) {
    ProjectName = project;
    Psid = psid;
  }
  @override
  State<PumpStation_Screen> createState() => _PumpStation_ScreenState();
}

class _PumpStation_ScreenState extends State<PumpStation_Screen> {
  Future<List<PumpStationDropDownModel>> ConvertPsDetails() async {
    return getpumpid(areaId: widget.Psid);
  }

  PumpStationDropDownModel? selectPumpStationId;
  int? pumpstation = 0;
  int pumpno = 0;

  @override
  void initState() {
    super.initState();
    ConvertPsDetails().then((value) => setState(() {
          PumpDropDownList = value;
          selectPumpStationId = value.first;
          pumpstation = value.first.pumpStationId;
          pumpno = PumpDropDownList!.length;
        }));
  }

  List<PumpStationDropDownModel>? PumpDropDownList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: MyDrawerScreen(),
          appBar: AppBar(
              title: Text(
                widget.ProjectName!.toUpperCase() + "- PUMP STATION",
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
          body: Container(
              decoration: BoxDecoration(image: backgroundImage),
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  // if (pumpno < 1)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: size.width,
                      child: PumpDropDownList != null
                          ? getpumpidDropdown(context, PumpDropDownList!)
                          : Center(child: CircularProgressIndicator()),
                    ),
                  ),

                  if (pumpstation != 0)
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Center(
                          child: Container(
                            child: FutureBuilder(
                              future: getPumpData(pumpstation!),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                try {
                                  if (snapshot.hasData) {
                                    try {
                                      var psData = snapshot.data
                                          as List<PumpStationMasterModel>;
                                      if (selectPumpStationId!.psPumpPT !=
                                          null) {
                                        try {
                                          // print(selectPumpStationId!.psPumpPT);
                                          return Container(
                                            width: size.width * 0.95,
                                            margin: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                            ),
                                            child: Column(
                                              children: [
                                                ///Heading
                                                Container(
                                                  height: 40,
                                                  width: size.width * 0.95,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: (psData.first
                                                                      .devStatus ??
                                                                  0) !=
                                                              0
                                                          ? Colors.green
                                                          : Colors.red,
                                                      // gradient: LinearGradient(
                                                      //     begin: Alignment
                                                      //         .topRight,
                                                      //     end: Alignment
                                                      //         .bottomLeft,
                                                      //     colors: ((psData.first
                                                      //                     .devStatus ??
                                                      //                 0) !=
                                                      //             0
                                                      //         ? <Color>[
                                                      //             Colors
                                                      //                 .lightGreen,
                                                      //             Colors.green
                                                      //           ]
                                                      //         : <Color>[
                                                      //             Colors.red,
                                                      //             Colors
                                                      //                 .redAccent
                                                      //           ])),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(12),
                                                              topRight: Radius
                                                                  .circular(
                                                                      12))),
                                                  child: Text(
                                                    selectPumpStationId!.psName!
                                                        .split("KundaliaLBC")
                                                        .join(''),
                                                    textScaleFactor: 1,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.white),
                                                  ),
                                                ),

                                                ///table data
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ///Sump Level
                                                      if (psData
                                                              .where((e) => e
                                                                  .tagName!
                                                                  .contains(
                                                                      'SUMP_LEVEL'))
                                                              .length !=
                                                          0)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  child: Center(
                                                                    child: Text(
                                                                      'INTAKE SUMP:',
                                                                      textScaleFactor:
                                                                          1,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                                for (int i = 1;
                                                                    i <=
                                                                        (psData
                                                                            .where((e) =>
                                                                                e.tagName!.contains('SUMP_LEVEL'))
                                                                            .length);
                                                                    i++)
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          30,
                                                                      width: 45,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              border: Border.all()),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          FittedBox(
                                                                            child: Text("Level" + "\n" + getSumpLevel(psData, i) + " m",
                                                                                textScaleFactor: 1,
                                                                                style: TextStyle(fontSize: 10)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                              ]),
                                                        ),

                                                      ///Pump
                                                      if (psData
                                                              .where((e) => e
                                                                  .tagName!
                                                                  .contains(
                                                                      "PMP1_RUN_WEB"))
                                                              .length !=
                                                          0)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                child: Center(
                                                                  child: Text(
                                                                    "Pump :",
                                                                    textScaleFactor:
                                                                        1,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            10),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      Container(
                                                                child: GridView
                                                                    .builder(
                                                                        physics:
                                                                            NeverScrollableScrollPhysics(),
                                                                        // padding:
                                                                        //     EdgeInsets
                                                                        //         .zero,
                                                                        shrinkWrap:
                                                                            true,
                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                            mainAxisExtent:
                                                                                45.0,
                                                                            mainAxisSpacing:
                                                                                0.0,
                                                                            crossAxisSpacing:
                                                                                0.0,
                                                                            crossAxisCount:
                                                                                5),
                                                                        itemCount:
                                                                            selectPumpStationId!.psPumpPT ??
                                                                                0
                                                                        /*(psData
                                                                            .where((e) => e.tagName!.contains(
                                                                                "RUN_WEB"))
                                                                            .length)*/
                                                                        ,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          var i =
                                                                              index + 1;
                                                                          return Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              Image(
                                                                                image: AssetImage(selectPumpStationId!.psName!.contains('Booster') ? getPumpStatusHorizantal(psData, i) : getPumpStatusVertical(psData, i)),
                                                                                width: 30,
                                                                                height: 30,
                                                                              ),
                                                                              FittedBox(
                                                                                child: Text(
                                                                                  "P$i",
                                                                                  textScaleFactor: 1,
                                                                                  style: TextStyle(fontSize: 10),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                              )),
                                                            ],
                                                          ),
                                                        ),

                                                      ///PS
                                                      if (psData
                                                              .where((e) => e
                                                                  .tagName!
                                                                  .contains(
                                                                      "_PMP1_PS_VAL"))
                                                              .length !=
                                                          0)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                child: Center(
                                                                  child: Text(
                                                                    "PS :",
                                                                    textScaleFactor:
                                                                        1,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            10),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      Container(
                                                                child: GridView
                                                                    .builder(
                                                                        physics:
                                                                            NeverScrollableScrollPhysics(),
                                                                        // padding:
                                                                        //     EdgeInsets
                                                                        //         .zero,
                                                                        shrinkWrap:
                                                                            true,
                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                            mainAxisExtent:
                                                                                45.0,
                                                                            mainAxisSpacing:
                                                                                0.0,
                                                                            crossAxisSpacing:
                                                                                0.0,
                                                                            crossAxisCount:
                                                                                5),
                                                                        itemCount:
                                                                            selectPumpStationId!.psPumpPS ??
                                                                                0
                                                                        /*(psData
                                                                            .where((e) => e.tagName!.contains(
                                                                                "_PS_VAL"))
                                                                            .length)
                                                                            */
                                                                        ,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          var i =
                                                                              index + 1;
                                                                          return Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              getPSStatus_New(psData, i),
                                                                              FittedBox(
                                                                                child: Text(
                                                                                  "P$i",
                                                                                  textScaleFactor: 1,
                                                                                  style: TextStyle(fontSize: 10),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                              )),
                                                            ],
                                                          ),
                                                        ),

                                                      ///PT
                                                      if (psData
                                                              .where((e) => e
                                                                  .tagName!
                                                                  .contains(
                                                                      "_PMP1_PT_VAL"))
                                                              .length !=
                                                          0)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                child: Center(
                                                                  child: Text(
                                                                    "PT :",
                                                                    textScaleFactor:
                                                                        1,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            10),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      Container(
                                                                child: GridView
                                                                    .builder(
                                                                        physics:
                                                                            NeverScrollableScrollPhysics(),
                                                                        // padding:
                                                                        //     EdgeInsets
                                                                        //         .zero,
                                                                        shrinkWrap:
                                                                            true,
                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                            mainAxisExtent:
                                                                                45.0,
                                                                            mainAxisSpacing:
                                                                                0.0,
                                                                            crossAxisSpacing:
                                                                                0.0,
                                                                            crossAxisCount:
                                                                                5),
                                                                        itemCount:
                                                                            (selectPumpStationId!.psPumpPTVAL ??
                                                                                0),
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          var i =
                                                                              index + 1;
                                                                          return Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                // width: 0,
                                                                                decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(5.0),
                                                                                  child: FittedBox(
                                                                                    child: Text("PT" + i.toString() + "\n" + getPTValve(psData, i) + " bar", textScaleFactor: 1, style: TextStyle(fontSize: 10)),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                              )),
                                                            ],
                                                          ),
                                                        ),

                                                      ///FT(Flow)
                                                      if (psData
                                                              .where((e) => e
                                                                  .tagName!
                                                                  .contains(
                                                                      "_PMP1_FT_VAL"))
                                                              .length !=
                                                          0)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                child: Center(
                                                                  child: Text(
                                                                    "FT :\n(Flow)",
                                                                    textScaleFactor:
                                                                        1,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            10),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child: GridView.builder(
                                                                      physics: NeverScrollableScrollPhysics(),
                                                                      // padding:
                                                                      //     EdgeInsets
                                                                      //         .zero,
                                                                      shrinkWrap: true,
                                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent: 45.0, mainAxisSpacing: 0.0, crossAxisSpacing: 0.0, crossAxisCount: 5),
                                                                      itemCount: (selectPumpStationId!.psPumpFTVAL ?? 0) /*(psData.where((e) => e.tagName!.contains("FT_VAL")).length)*/,
                                                                      itemBuilder: (context, index) {
                                                                        var i =
                                                                            index +
                                                                                1;
                                                                        return Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(5.0),
                                                                                child: FittedBox(
                                                                                  child: Text("Flow " + i.toString() + "\n" + getFTValve(psData, i) + " m³/hr", textScaleFactor: 1, style: TextStyle(fontSize: 10)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      })),
                                                            ],
                                                          ),
                                                        ),

                                                      ///FT(Volume)
                                                      if (psData
                                                              .where((e) => e
                                                                  .tagName!
                                                                  .contains(
                                                                      "_PMP1_FT_VOL"))
                                                              .length !=
                                                          0)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                child: Center(
                                                                  child: Text(
                                                                    "FT :\n(Volume)",
                                                                    textScaleFactor:
                                                                        1,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            10),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child: GridView.builder(
                                                                      physics: NeverScrollableScrollPhysics(),
                                                                      // padding:
                                                                      //     EdgeInsets
                                                                      //         .zero,
                                                                      shrinkWrap: true,
                                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent: 45.0, mainAxisSpacing: 0.0, crossAxisSpacing: 0.0, crossAxisCount: 5),
                                                                      itemCount: (selectPumpStationId!.psPumpFTVOL ?? 0) /*(psData.where((e) => e.tagName!.contains("FT_VOL")).length)*/,
                                                                      itemBuilder: (context, index) {
                                                                        var i =
                                                                            index +
                                                                                1;
                                                                        return Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(5.0),
                                                                                child: FittedBox(
                                                                                  child: Text("Volume " + i.toString() + "\n" + getFTflow(psData, i) + " m³", textScaleFactor: 1, style: TextStyle(fontSize: 10)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      })),
                                                            ],
                                                          ),
                                                        ),

                                                      ///HOPD
                                                      if (psData
                                                              .where((e) => e
                                                                  .tagName!
                                                                  .contains(
                                                                      "HOPD"))
                                                              .length !=
                                                          0)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                child: Center(
                                                                  child: Text(
                                                                    "HOPD :",
                                                                    textScaleFactor:
                                                                        1,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            10),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      Container(
                                                                child: GridView
                                                                    .builder(
                                                                        physics:
                                                                            NeverScrollableScrollPhysics(),
                                                                        // padding:
                                                                        //     EdgeInsets
                                                                        //         .zero,
                                                                        shrinkWrap:
                                                                            true,
                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount:
                                                                                5),
                                                                        itemCount:
                                                                            (selectPumpStationId!.psPumpPT ??
                                                                                0),
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          var i =
                                                                              index + 1;
                                                                          return Column(
                                                                            children: [
                                                                              Image(
                                                                                image: AssetImage(getHODPStatus(psData, i)),
                                                                                width: 30,
                                                                                height: 30,
                                                                              ),
                                                                              FittedBox(
                                                                                child: Text(
                                                                                  "HOPD$i",
                                                                                  textScaleFactor: 1,
                                                                                  style: TextStyle(fontSize: 10),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                              ))
                                                            ],
                                                          ),
                                                        ),

                                                      ///VALVE
                                                      if (psData
                                                              .where((e) => e
                                                                  .tagName!
                                                                  .contains(
                                                                      "MBFV"))
                                                              .length !=
                                                          0)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 50,
                                                                child: Center(
                                                                  child: Text(
                                                                    "Valve :",
                                                                    textScaleFactor:
                                                                        1,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            10),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      Container(
                                                                child: GridView
                                                                    .builder(
                                                                        physics:
                                                                            NeverScrollableScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount:
                                                                                5),
                                                                        itemCount:
                                                                            (selectPumpStationId!.psPumpMBFV ??
                                                                                0),
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          var i =
                                                                              index + 1;
                                                                          return Column(
                                                                            children: [
                                                                              Image(
                                                                                image: AssetImage(getValveStatus(psData, i)),
                                                                                width: 30,
                                                                                height: 30,
                                                                              ),
                                                                              FittedBox(
                                                                                child: Text(
                                                                                  "V$i",
                                                                                  textScaleFactor: 1,
                                                                                  style: TextStyle(
                                                                                    fontSize: 11,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              FittedBox(
                                                                                child: Text(
                                                                                  getValvePos(psData, i) + '% Open',
                                                                                  style: TextStyle(fontSize: 8),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                              ))
                                                            ],
                                                          ),
                                                        ),
                                                    ]),

                                                ///Header Line Pt
                                                Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL1_PT_HH'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Header Line PT 1: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        getHeaderlinePt(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL1_PT_HH')).data ??
                                                                                '0.0') +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL1_PT_HH')).unit ?? 'bar').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL2_PT_HH'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Header Line PT 2: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        getHeaderlinePt(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL2_PT_HH')).data ??
                                                                                '0.0') +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL2_PT_HH')).unit ?? 'bar').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                            ]),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL3_PT_HH'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Header Line PT 3: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        getHeaderlinePt(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL3_PT_HH')).data ??
                                                                                '0.0') +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL3_PT_HH')).unit ?? 'bar').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL4_PT_HH'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Header Line PT 4: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        getHeaderlinePt(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL4_PT_HH')).data ??
                                                                                '0.0') +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL4_PT_HH')).unit ?? 'bar').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                            ]),
                                                      ],
                                                    )),

                                                ///Header Inlet Pt
                                                Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL_IN_VAL'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Inlet Pressure 1: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        ((double.parse(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL_IN_VAL')).data ?? '0.0') < 0 ? 0 : (double.parse(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL_IN_VAL')).data ?? '0.0')) * 1.01972).toStringAsFixed(2) +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL_IN_VAL')).unit ?? 'bar').toString()),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL2_IN_VAL'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Header Line PT 2: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        (double.parse(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL2_IN_VAL')).data ?? '0.0') * 0.01).toStringAsFixed(2) +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL2_IN_VAL')).unit ?? 'bar').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                            ]),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL3_IN_VAL'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Header Line PT 3: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        (double.parse(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL3_IN_VAL')).data ?? '0.0') * 0.01).toStringAsFixed(2) +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL3_IN_VAL')).unit ?? 'bar').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL4_IN_VAL'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Header Line PT 4: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        (double.parse(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL4_IN_VAL')).data ?? '0.0') * 1.01972).toStringAsFixed(2) +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL4_IN_VAL')).unit ?? 'bar').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                            ]),
                                                      ],
                                                    )),

                                                ///Header Line Ft
                                                Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL1_FT_VAL'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Header Line FT 1: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        getHeaderlinePt(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL1_FT_VAL')).data) +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL1_FT_VAL')).unit ?? 'm³­/hr').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL2_FT_VAL'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Header Line FT 2: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        getHeaderlinePt(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL2_FT_VAL')).data) +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL2_FT_VAL')).unit ?? 'm³­/hr').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                            ]),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL3_FT_VAL'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Header Line FT 3: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        getHeaderlinePt(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL3_FT_VAL')).data) +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL3_FT_VAL')).unit ?? 'm³­/hr').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL4_FT_VAL'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Header Line FT 4: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        getHeaderlinePt(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL4_FT_VAL')).data) +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL4_FT_VAL')).unit ?? 'm³­/hr').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                            ]),
                                                      ],
                                                    )),

                                                ///Todays Volume
                                                Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL1_FT_VOL'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Today's Volume 1: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        getHeaderlineFt(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL1_FT_VOL')).data) +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL1_FT_VOL')).unit ?? 'm³').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL2_FT_VOL'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Today's Volume 2: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        getHeaderlineFt(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL2_FT_VOL')).data) +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL2_FT_VOL')).unit ?? 'm³').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                            ]),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL3_FT_VOL'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Today's Volume 3: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        getHeaderlineFt(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL3_FT_VOL')).data) +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL3_FT_VOL')).unit ?? 'm³').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              if (psData
                                                                      .where((e) => e
                                                                          .tagName!
                                                                          .contains(
                                                                              'MAIN_HL4_FT_VOL'))
                                                                      .length >
                                                                  0)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Today's Volume 4: ",
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                        getHeaderlineFt(psData.singleWhere((e) => e.tagName!.contains('MAIN_HL4_FT_VOL')).data) +
                                                                            ' ' +
                                                                            (psData.singleWhere((e) => e.tagName!.contains('MAIN_HL4_FT_VOL')).unit ?? 'm³').toString(),
                                                                        textScaleFactor:
                                                                            1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                            ]),
                                                      ],
                                                    )),

                                                ///Last Response Time
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "LAST RESPONSE TIME: ",
                                                          textScaleFactor: 1,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        psData.first.deviceTimeStamp !=
                                                                null
                                                            ? Text(
                                                                getlongDate(psData
                                                                    .first
                                                                    .deviceTimeStamp!
                                                                    .toString()),
                                                                textScaleFactor:
                                                                    1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : Text(
                                                                "Never Connected",
                                                                textScaleFactor:
                                                                    1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        } catch (_, ex) {
                                          print(ex);
                                          return Center(
                                            child: Text(
                                              "No Data Found",
                                              textScaleFactor: 1,
                                            ),
                                          );
                                        }
                                      } else
                                        return Center(
                                          child: Text(
                                            'No Data Found',
                                            textScaleFactor: 1,
                                          ),
                                        );
                                    } catch (_, Ex) {
                                      return Center(
                                        child: Text(
                                          "No Data Found",
                                          textScaleFactor: 1,
                                        ),
                                      );
                                    }
                                  } else if (snapshot.hasError) {
                                    return (Text(
                                      "No Data Found",
                                      textScaleFactor: 1,
                                    ));
                                  } else {
                                    return Center(
                                        child: Container(
                                      child: CircularProgressIndicator(),
                                    ));
                                  }
                                } catch (_, ex) {
                                  return Center(
                                    child: Container(
                                        child: CircularProgressIndicator()),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ))),
    );
  }

  getlongDate(String date) {
    final DateTime now = DateTime.parse(date);
    final DateFormat formatter = DateFormat('EEEE, d MMMM y H:m:s');
    final String formatted = formatter.format(now);
    // print(formatted); // something like 2013-04-20
    return formatted;
  }

  getpumpidDropdown(
      BuildContext context, List<PumpStationDropDownModel> values) {
    try {
      if (selectPumpStationId == null) selectPumpStationId = values.first;
      try {
        return Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 168, 211, 237),
              borderRadius: BorderRadius.circular(5)),
          child: DropdownButton(
            value: (values
                        .where((e) =>
                            e.pumpStationId ==
                            selectPumpStationId!.pumpStationId)
                        .length ==
                    0)
                ? values.first
                : selectPumpStationId!,
            underline: Container(color: Colors.transparent),
            isExpanded: true,
            items: values.map((PumpStationDropDownModel psid) {
              return DropdownMenuItem<PumpStationDropDownModel>(
                value: psid,
                child: Center(
                  child: Text(
                    psid.psName!.split("KundaliaLBC").join(' '),
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
            onChanged: (textvalue) {
              setState(() {
                selectPumpStationId = textvalue as PumpStationDropDownModel;
                pumpstation = selectPumpStationId!.pumpStationId;
                //print("PumpStation Id:" + pumpstation.toString());
              });
            },
          ),
        );
      } catch (_, ex) {
        return Center(
          child: Text(
            "Something Went Wrong",
            textScaleFactor: 1,
          ),
        );
      }
    } catch (_, ex) {
      return Container(
        child: Text(
          ex.toString(),
          textScaleFactor: 1,
        ),
      );
    }
  }

  String getPumpStatusVertical(
      List<PumpStationMasterModel> model, int pmpIndex) {
    try {
      String OnStatus = (model
                      .where((i) => i.tagName!
                          .contains('PMP' + pmpIndex.toString() + '_RUN_WEB'))
                      .length ==
                  0
              ? '0'
              : model
                  .singleWhere((i) => i.tagName!
                      .contains('PMP' + pmpIndex.toString() + '_RUN_WEB'))
                  .data)
          .toString();
      String OfStatus = (model
                      .where((i) => i.tagName!
                          .contains('PMP' + pmpIndex.toString() + '_OFFB'))
                      .length ==
                  0
              ? '0'
              : model
                  .singleWhere((i) => i.tagName!
                      .contains('PMP' + pmpIndex.toString() + '_OFFB'))
                  .data)
          .toString();
      String FaultyStatus = (model
                      .where((i) => i.tagName!
                          .contains('PMP' + pmpIndex.toString() + '_TRP'))
                      .length ==
                  0
              ? '0'
              : model
                  .singleWhere((i) =>
                      i.tagName!.contains('PMP' + pmpIndex.toString() + '_TRP'))
                  .data)
          .toString();

      if (OnStatus.contains('1')) {
        return "assets/images/img_24da046982774.png";
      } else if (FaultyStatus.contains('1')) {
        return "assets/images/img_2c08540d9c5f4.png";
      } else if (OfStatus.contains('1')) {
        return "assets/images/img_86ccc11cb4344.png";
      } else {
        return "assets/images/img_86ccc11cb4344.png";
      }
    } catch (_, ex) {
      return "assets/images/img_86ccc11cb4344.png";
    }
  }

  //getPumpStatusHorizantal
  String getPumpStatusHorizantal(
      List<PumpStationMasterModel> model, int pmpIndex) {
    try {
      String OnStatus = (model
                      .where((i) => i.tagName!
                          .contains('PMP' + pmpIndex.toString() + '_RUN_WEB'))
                      .length ==
                  0
              ? '0'
              : model
                  .singleWhere((i) => i.tagName!
                      .contains('PMP' + pmpIndex.toString() + '_RUN_WEB'))
                  .data)
          .toString();
      String FaultyStatus = (model
                      .where((i) => i.tagName!
                          .contains('PMP' + pmpIndex.toString() + '_TRP'))
                      .length ==
                  0
              ? '0'
              : model
                  .singleWhere((i) =>
                      i.tagName!.contains('PMP' + pmpIndex.toString() + '_TRP'))
                  .data)
          .toString();

      if (OnStatus.contains('1')) {
        return "assets/images/HSC_Green.png";
      } else if (FaultyStatus.contains('1')) {
        return "assets/images/HSC_Yellow.png";
      } else {
        return "assets/images/HSC_Red.png";
      }
    } catch (_, ex) {
      return "assets/images/img_86ccc11cb4344.png";
    }
  }

  getPSStatus_New(List<PumpStationMasterModel> model, int pmpIndex) {
    try {
      String OnStatus = (model
                      .where((i) => i.tagName!
                          .contains('PMP' + pmpIndex.toString() + '_PS_VAL'))
                      .length ==
                  0
              ? '0'
              : model
                  .singleWhere((i) => i.tagName!
                      .contains('PMP' + pmpIndex.toString() + '_PS_VAL'))
                  .data)
          .toString();

      if (OnStatus.contains('0')) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey),
              color: Colors.green,
              borderRadius: BorderRadius.circular(50)),
          height: 25,
          width: 25,
        );
      } else {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey),
              color: Colors.red.shade900,
              borderRadius: BorderRadius.circular(50)),
          height: 25,
          width: 25,
        );
      }
    } catch (_, ex) {
      return "assets/images/img_86ccc11cb4344.png";
    }
  }

  String getHeaderlinePt(var val) {
    try {
      if (val == null)
        return '0.0';
      else if (double.parse(val) < 0)
        return '0.0';
      else
        return double.parse(val).toStringAsFixed(2);
    } catch (_, ex) {
      return '0.0';
    }
  }

  String getHeaderlineFt(var val) {
    try {
      if (val == null)
        return '0.0';
      else if (double.parse(val) <= 0)
        return '0.0';
      else
        return double.parse(val).toStringAsFixed(2);
    } catch (_, ex) {
      return '0.0';
    }
  }

  String getSumpLevel(List<PumpStationMasterModel> model, int pmpIndex) {
    double val = 0.0;
    try {
      val = (double.parse(model
              .singleWhere((i) => i.tagName!
                  .contains('SUMP_LEVEL' + pmpIndex.toString() + '_VAL'))
              .data ??
          '0'));
    } catch (_, ex) {}

    return val.toStringAsFixed(2);
  }

  String getHODPStatus(List<PumpStationMasterModel> model, int pmpIndex) {
    try {
      String OnStatus = (model
                  .singleWhere((i) => i.tagName!
                      .contains('HOPD' + pmpIndex.toString() + '_FLLY_OPN'))
                  .data ??
              '0')
          .toString();

      String CloseStatus = (model
                  .singleWhere((i) => i.tagName!
                      .contains('HOPD' + pmpIndex.toString() + '_FLLY_CLS'))
                  .data ??
              '0')
          .toString();

      if (int.parse(OnStatus) == 1) {
        return "assets/images/MOV_Green.png";
      } else if (int.parse(CloseStatus) == 1) {
        return "assets/images/MOV_Red.png";
      } else {
        return "assets/images/MOV_Red.png";
      }
    } catch (_, ex) {
      return "assets/images/MOV_Red.png";
    }
  }

  String getValvePos(List<PumpStationMasterModel> model, int pmpIndex) {
    double val;
    try {
      val = (double.parse(model
                  .singleWhere((i) => i.tagName!.contains('MBFV' +
                      pmpIndex.toString() +
                      '_POS_VAL')) //MBFV1_POS_VAL
                  .data ??
              '0.0') *
          1.01972);
    } catch (_, ex) {
      val = 0.0;
    }
    val = val < 0 ? 0.0 : val;
    return val.toStringAsFixed(2);
  }

  String getValveStatus(List<PumpStationMasterModel> model, int pmpIndex) {
    String OnStatus;
    String FaultyStatus;
    String OffStatus;
    try {
      OnStatus = (model
                  .singleWhere((i) => i.tagName!
                      .contains('MBFV' + pmpIndex.toString() + '_LS_OPNFB'))
                  .data ??
              '0')
          .toString();

      FaultyStatus = (model
                  .singleWhere((i) => i.tagName!
                      .contains('MBFV' + pmpIndex.toString() + '_TRP'))
                  .data ??
              '0')
          .toString();

      OffStatus = (model
                  .singleWhere((i) => i.tagName!
                      .contains('MBFV' + pmpIndex.toString() + '_LS_CLSFB'))
                  .data ??
              '0')
          .toString();

      if (int.parse(OnStatus) == 1 ||
          double.parse(getValvePos(model, pmpIndex)) >= 5) {
        return "assets/images/greenValve_new.png";
      } else if (double.parse(getValvePos(model, pmpIndex)) > 1) {
        return "assets/images/blueValve.png";
      } else if (int.parse(FaultyStatus) == 1) {
        return "assets/images/yellowValve.png";
      } else if (int.parse(OffStatus) == 1) {
        return "assets/images/valve5_new.png";
      } else {
        return 'assets/images/greyValve.png';
      }
    } catch (_, ex) {
      return "assets/images/greyValve.png";
    }
  }

  String getPTValve(List<PumpStationMasterModel> model, int pmpIndex) {
    double val = 0.0;
    try {
      val = (double.parse(model
                  .singleWhere((i) => i.tagName!
                      .contains('PMP' + pmpIndex.toString() + '_PT_VAL'))
                  .data ??
              '0') *
          1.01972);
    } catch (_, ex) {}
    val = val < 0 ? 0.0 : val;
    return val.toStringAsFixed(2);
  }

  String getFTValve(List<PumpStationMasterModel> model, int pmpIndex) {
    double val = 0.0;
    try {
      val = (double.parse(model
              .singleWhere((i) => i.tagName!.contains(
                  'PMP' + pmpIndex.toString() + '_FT_VAL')) //PMP1_FT_VAL
              .data ??
          '0'));
    } catch (_, ex) {}
    val = val < 0 ? 0.0 : val;
    return val.toStringAsFixed(1);
  }

  String getFTflow(List<PumpStationMasterModel> model, int pmpIndex) {
    double val = 0.0;
    try {
      val = (double.parse(model
              .singleWhere((i) =>
                  i.tagName!.contains('PMP' + pmpIndex.toString() + '_FT_VOL'))
              .data ??
          '0'));
    } catch (_, ex) {}
    val = val < 0 ? 0.0 : val;
    return val.toStringAsFixed(1);
  }
}
