import 'package:WMS_Application/Model/Project/CanalGateMasterModel.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:WMS_Application/Operations/StateselectionOperation.dart';
import 'package:WMS_Application/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Canal_Gate_Intake_Screen extends StatefulWidget {
  String? ProjectName;

  Canal_Gate_Intake_Screen(String project) {
    ProjectName = project;
  }
  @override
  State<Canal_Gate_Intake_Screen> createState() =>
      _Canal_Gate_Intake_ScreenState();
}

class _Canal_Gate_Intake_ScreenState extends State<Canal_Gate_Intake_Screen> {
  @override
  void initState() {
    super.initState();
    OnStart();
  }

  OnStart() async {
    var _preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences = _preferences;
    });
  }

  late SharedPreferences preferences;
  List<CanalGateMasterModel>? PumpDropDownList;

  double getDamlevel(var data) {
    try {
      if (data <= 0.0) {
        return 0;
      } else {
        return data + 300;
      }
    } catch (_, ex) {
      return 0.0;
    }
  }

  getGateColor(var data) {
    try {
      if (data > 0) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } catch (_, ex) {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: MyDrawerScreen(),
          appBar: AppBar(
              title: Text(
                widget.ProjectName!.toUpperCase() + "- CANAL GATE INTAKE",
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
                  Expanded(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: FutureBuilder(
                          future: getGCI(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              try {
                                var psData =
                                    snapshot.data as CanalGateMasterModel;

                                return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          shadowColor:
                                              Color.fromARGB(255, 44, 8, 143),
                                          margin: EdgeInsets.all(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12))),
                                            child: Column(children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12))),
                                                child: Column(
                                                  children: [
                                                    ///Heading
                                                    Container(
                                                      height: 40,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              (psData.commStatus !=
                                                                      0
                                                                  ? Colors.green
                                                                  : Colors.red),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          12),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12))),
                                                      child: Text(
                                                        (psData.deviceName ??
                                                                '0')
                                                            .toString(),
                                                        textScaleFactor: 1,
                                                        // "DC-" +
                                                        //     index.toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),

                                                    ///Dam Level Detail
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Dam Level :',
                                                              textScaleFactor:
                                                                  1,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              getDamlevel(double.parse(psData
                                                                          .pressure
                                                                          .toString()))
                                                                      .toString() +
                                                                  ' m',
                                                              textScaleFactor:
                                                                  1,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),

                                                        ///PS1_DC1A_LT_VAL
                                                      ),
                                                    ),

                                                    ///Reservoirs Detail
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Balancing Reservoir Level :',
                                                              textScaleFactor:
                                                                  1,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              psData.pressure
                                                                      .toString() +
                                                                  ' m',
                                                              textScaleFactor:
                                                                  1,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),

                                                        ///PS1_DC1A_LT_VAL
                                                      ),
                                                    ),

                                                    ///Dam Level Detail
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Gate Opening Status :',
                                                              textScaleFactor:
                                                                  1,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    ///Gate Information
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                              height: 45,
                                                              width: 75,
                                                              decoration: BoxDecoration(
                                                                  color: getGateColor(
                                                                      double.parse(psData
                                                                          .gAT1POSVAL
                                                                          .toString())),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5))),
                                                              // color: Colors.red,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Gate- 1',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        softWrap:
                                                                            true,
                                                                      ),
                                                                      Text(
                                                                        psData.gAT1POSVAL.toString() +
                                                                            ' mm',
                                                                        softWrap:
                                                                            true,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ]),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 45,
                                                              width: 75,
                                                              decoration: BoxDecoration(
                                                                  color: getGateColor(
                                                                      double.parse(psData
                                                                          .gAT2POSVAL
                                                                          .toString())),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5))),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Gate- 2',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        softWrap:
                                                                            true,
                                                                      ),
                                                                      Text(
                                                                        psData.gAT2POSVAL.toString() +
                                                                            ' mm',
                                                                        softWrap:
                                                                            true,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ]),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 45,
                                                              width: 75,
                                                              decoration: BoxDecoration(
                                                                  color: getGateColor(
                                                                      double.parse(psData
                                                                          .gAT3POSVAL
                                                                          .toString())),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5))),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Gate- 3',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        softWrap:
                                                                            true,
                                                                      ),
                                                                      Text(
                                                                        psData.gAT3POSVAL.toString() +
                                                                            ' mm',
                                                                        softWrap:
                                                                            true,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ]),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 45,
                                                              width: 75,
                                                              decoration: BoxDecoration(
                                                                  color: getGateColor(
                                                                      double.parse(psData
                                                                          .gAT4POSVAL
                                                                          .toString())),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5))),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Gate- 4',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                        softWrap:
                                                                            true,
                                                                      ),
                                                                      Text(
                                                                        psData.gAT4POSVAL.toString() +
                                                                            ' mm',
                                                                        softWrap:
                                                                            true,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ]),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ));
                                    });
                              } catch (_, ex) {
                                return Text(
                                  "Something Went Wrong: " + ex.toString(),
                                  textScaleFactor: 1,
                                );
                              }
                            } else if (snapshot.hasError) {
                              return Text(
                                "Something Went Wrong: " +
                                    snapshot.error.toString(),
                                textScaleFactor: 1,
                                style: TextStyle(color: Colors.red),
                              );
                            } else {
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        )),
                  )
                ],
              ))),
    );
  }
}
