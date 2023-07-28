import 'package:WMS_Application/Model/Project/PumpstationDropDownModel.dart';
import 'package:WMS_Application/Model/Project/PumpstationMasterModel.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:WMS_Application/Operations/StateselectionOperation.dart';
import 'package:WMS_Application/core/app_export.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Delevery_chember_Screen extends StatefulWidget {
  String? ProjectName;

  Delevery_chember_Screen(String project) {
    ProjectName = project;
  }
  @override
  State<Delevery_chember_Screen> createState() =>
      _Delevery_chember_ScreenState();
}

class _Delevery_chember_ScreenState extends State<Delevery_chember_Screen> {
  @override
  void initState() {
    super.initState();
    OnStart();

    // getpumpid().then((value) => setState(() {
    //       PumpDropDownList = value;
    //       selectPumpStationId = value.first;
    //       pumpstation = value.first.pumpStationId;
    //     }));
  }

  OnStart() async {
    var _preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences = _preferences;
    });
  }

  late SharedPreferences preferences;
  // List<PumpStationDropDownModel>? PumpDropDownList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: MyDrawerScreen(),
          appBar: AppBar(
              title: Text(
                widget.ProjectName!.toUpperCase() +
                    ' - ' +
                    getSubProject(widget.ProjectName),
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
                          future: getDC(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              try {
                                var psData = snapshot.data
                                    as List<PumpStationMasterModel>;

                                return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: psData
                                        .where((e) => e.tagName!.contains('DC'))
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var list = psData
                                          .where(
                                              (e) => e.tagName!.contains('DC'))
                                          .toList();
                                      var info = list[index];
                                      double BPT = ((double.parse(
                                                      info.data ?? 0.0) *
                                                  1.01972) >
                                              0
                                          ? (double.parse(info.data ?? 0.0) *
                                              1.01972)
                                          : 0.0);
                                      var TankHeight = (info.tankHeight ?? 1.0);
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
                                                          color: (psData[index]
                                                                      .devStatus !=
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
                                                        (info.description ?? 0)
                                                            .toString(),
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),

                                                    ///Level Detail
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
                                                              'Level 1 :',
                                                              textScaleFactor:
                                                                  1,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            if (widget
                                                                .ProjectName!
                                                                .contains(
                                                                    'Bistan'))
                                                              (info.description!
                                                                          .contains(
                                                                              '1')) ==
                                                                      true
                                                                  ? Text(
                                                                      (double.parse(info.data ?? 0.0) * 1.01972).toStringAsFixed(
                                                                              2) +
                                                                          ' ' +
                                                                          (info.unit ?? "m")
                                                                              .toString(),
                                                                      textScaleFactor:
                                                                          1,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )
                                                                  : Container(
                                                                      height:
                                                                          25,
                                                                      width:
                                                                          200,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Container(
                                                                              child: Center(child: Text('HH')),
                                                                              height: 25,
                                                                              width: 25,
                                                                              // color: getTankHeight((psData.singleWhere((element) => element.tagName!.contains('P2_SURGE_LVL_HH')).data))
                                                                              color: veryHigh(psData.singleWhere((e) => e.tagName!.contains('P2_SURGE_LVL_EXTRA_HIGH')).data)
                                                                              // veryHigh(psData.singleWhere((e) => e.tagName!.contains('P2_SURGE_LVL_HH')).data),
                                                                              ),
                                                                          Container(
                                                                            child:
                                                                                Center(
                                                                              child: Text('H'),
                                                                            ),
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                25,
                                                                            color: //Colors.grey
                                                                                high(psData.singleWhere((e) => e.tagName!.contains('P2_SURGE_LVL_HIGH')).data),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                25,
                                                                            child:
                                                                                Center(
                                                                              child: Text('M'),
                                                                            ),
                                                                            color:
                                                                                medium(psData.singleWhere((e) => e.tagName!.contains('P2_SURGE_LVL_MID')).data),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                25,
                                                                            child:
                                                                                Center(child: Text('L')),
                                                                            color: //Colors.grey
                                                                                low(psData.singleWhere((e) => e.tagName!.contains('P2_SURGE_LVL_LOW')).data),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                25,
                                                                            width:
                                                                                25,
                                                                            child:
                                                                                Center(
                                                                              child: Text('LL'),
                                                                            ),
                                                                            color: //Colors.grey
                                                                                veryLow(psData.singleWhere((e) => e.tagName!.contains('P2_SURGE_LVL_EXTRA_LOW')).data),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                            if (widget
                                                                    .ProjectName!
                                                                    .contains(
                                                                        'Bistan') ==
                                                                false)
                                                              Text(
                                                                (double.parse(info.data ??
                                                                                0.0) *
                                                                            1.01972)
                                                                        .toStringAsFixed(
                                                                            2) +
                                                                    ' ' +
                                                                    (info.unit ??
                                                                            "m")
                                                                        .toString(),
                                                                textScaleFactor:
                                                                    1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )
                                                          ],
                                                        ),

                                                        ///PS1_DC1A_LT_VAL
                                                      ),
                                                    ),

                                                    if (psData
                                                            .where((e) =>
                                                                e.tagName!.contains(
                                                                    "PS_BPT_LVL_COMN") &&
                                                                widget.ProjectName! !=
                                                                    'Bistan')
                                                            .length !=
                                                        0)
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Level 2:',
                                                                textScaleFactor:
                                                                    1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                (double.parse(psData.singleWhere((e) => e.tagName!.contains('PS_BPT_LVL_COMN')).data ??
                                                                                0) *
                                                                            1.01972)
                                                                        .toStringAsFixed(
                                                                            2) +
                                                                    ' ' +
                                                                    (info.unit ??
                                                                            "m")
                                                                        .toString(),
                                                                textScaleFactor:
                                                                    1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),

                                                          ///PS1_DC1A_LT_VAL
                                                        ),
                                                      ),

                                                    ///Last Response Time
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "LAST RESPONSE TIME: ",
                                                              textScaleFactor:
                                                                  1,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            psData[index]
                                                                        .deviceTimeStamp !=
                                                                    null
                                                                ? Text(
                                                                    getlongDate(psData[
                                                                            index]
                                                                        .deviceTimeStamp!
                                                                        .toString()),
                                                                    textScaleFactor:
                                                                        1,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                : Text(
                                                                    "Never Connected",
                                                                    textScaleFactor:
                                                                        1,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

/*                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "LAST RESPONSE TIME: ",
                                                              textScaleFactor:
                                                                  1,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              psData[index]
                                                                      .deviceTimeStamp
                                                                      .toString()
                                                                      .substring(
                                                                          0, 10)
                                                                      .split(
                                                                          '-')
                                                                      .reversed
                                                                      .join(
                                                                          '-') +
                                                                  ' ' +
                                                                  psData[index]
                                                                      .deviceTimeStamp
                                                                      .toString()
                                                                      .substring(
                                                                          11),
                                                              textScaleFactor:
                                                                  1,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
*/
                                                    ///Image Tank
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            15,
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                  children: [
                                                                    Stack(
                                                                      children: [
                                                                        Image.asset(
                                                                            'assets/images/Tank.png'),
                                                                        Positioned(
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage(getWaterLevel(getPercentage(BPT, TankHeight))
                                                                                  // getWaterLevel((BPT / (TankHeight == 0 ? 1 : TankHeight)) * 100),
                                                                                  ),
                                                                              height: 55,
                                                                              width: 42,
                                                                            ),
                                                                            left:
                                                                                24),
                                                                        Positioned(
                                                                            child:
                                                                                Container(
                                                                              child: Center(
                                                                                child: Text(
                                                                                  getPercentage(BPT, TankHeight).toStringAsFixed(2) + '%',
                                                                                  //((BPT / (TankHeight == 0 ? 1 : TankHeight)) * 100).toStringAsFixed(1) + '%',
                                                                                  textScaleFactor: 1,
                                                                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                              decoration: BoxDecoration(color: Colors.transparent),
                                                                              height: 30,
                                                                              width: 37,
                                                                            ),
                                                                            top:
                                                                                16,
                                                                            left:
                                                                                27)
                                                                      ],
                                                                    )
                                                                  ],
                                                                ))
                                                          ],
                                                        )
                                                      ],
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
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 80),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(211, 255, 255, 255),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                            height: 100,
                                            width: 100,
                                            image: AssetImage(
                                                'assets/images/storm.png')),
                                        Text(
                                          'OPPS!',
                                          softWrap: true,
                                          style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 24,
                                              fontFamily: "RaleWay",
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 10, right: 10),
                                          child: Text(
                                            'it seems Something went wrong with the Connection please try after sometime',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "RaleWay",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
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

  getlongDate(String date) {
    final DateTime now = DateTime.parse(date);
    final DateFormat formatter = DateFormat('EEEE, d MMMM y H:m:s');
    final String formatted = formatter.format(now);
    // print(formatted); // something like 2013-04-20
    return formatted;
  }

/*  getDcData(BuildContext context, List<DeliveryChamberModel> values) {
    return Expanded(
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                shadowColor: Color.fromARGB(255, 44, 8, 143),
                margin: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: (values[index].isConnected != 0
                                    ? Colors.lightBlue
                                    : Colors.red),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12))),
                            child: Text(
                              values[index].amsNo!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, right: 15),
                                    child: Row(
                                      children: [
                                        Stack(children: [
                                          Image(
                                            image: AssetImage(
                                              getBattreydata_new(values[index]
                                                  .batteryLevel!
                                                  .toInt()),
                                            ),
                                            width: 30,
                                            height: 30,
                                          ),
                                          Positioned(
                                              top: 10,
                                              left: 6,
                                              child: Text(
                                                values[index]
                                                        .batteryLevel!
                                                        .toStringAsFixed(0) +
                                                    "%",
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ))
                                        ]),
                                        Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/navigation2.png"),
                                              width: 25,
                                              height: 25,
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            'LEVEL:',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          values[index]
                                                  .pressure!
                                                  .toStringAsFixed(2) +
                                              " m",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 15, top: 20),
                                        child: Text(
                                          'LAST UPDATE TIME :',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, top: 20),
                                        child: Text(
                                          values[index].lastResponseTime!,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          right: 15, bottom: 10),
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Image.asset(
                                                  'assets/images/Tank.png'),
                                              Positioned(
                                                  child: Container(
                                                    child: Center(
                                                      child: Text(
                                                        ((values[index].pressure! /
                                                                        4.7) *
                                                                    100)
                                                                .toStringAsFixed(
                                                                    2) +
                                                            '%',
                                                        style: TextStyle(
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white),
                                                    height: 44,
                                                    width: 37,
                                                  ),
                                                  top: 5,
                                                  left: 27),
                                              Positioned(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue),
                                                    height: 5,
                                                    width: 36.5,
                                                  ),
                                                  top: 45,
                                                  left: 27)
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
                ));
          }),
    );
  }
*/

  String getBattreydata_new(int LevelStatus) {
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
  }

  getPercentage(double? _BPT, double? _TankHeight) {
    try {
      String? conString;
      conString = preferences.getString('conString');

      if (conString!.contains('dba')) {
        var Percentage = (_BPT! / (_TankHeight! == 0 ? 1 : _TankHeight)) * 100;
        return Percentage < 0 || Percentage > 100 ? 0.0 : Percentage;
      } else {
        return _TankHeight! < 0 ? 0.0 : _TankHeight;
      }
    } catch (ex, _) {
      return 0.0;
    }
  }

  String getWaterLevel(double LevelStatus) {
    try {
      if (LevelStatus == 100) {
        return "assets/images/Level100.png";
      } else if (LevelStatus <= 99 && LevelStatus >= 90) {
        return "assets/images/Level90.png";
      } else if (LevelStatus < 90 && LevelStatus >= 75) {
        return "assets/images/Level75.png";
      } else if (LevelStatus < 75 && LevelStatus >= 50) {
        return "assets/images/Level50.png";
      } else if (LevelStatus < 50 && LevelStatus >= 20) {
        return "assets/images/Level20.png";
      } else if (LevelStatus < 20 && LevelStatus >= 10) {
        return "assets/images/Level10.png";
      } else if (LevelStatus < 10 && LevelStatus > 0) {
        return "assets/images/Level5.png";
      } else {
        return "assets/images/Level0.png";
      }
    } catch (_, ex) {
      return "assets/images/Level0.png";
    }
  }

  String getPsStatus(String OnStatus) {
    if (int.parse(OnStatus) == 1) {
      return "assets/images/GreenCircle.png";
    } else {
      return "assets/images/RedCircle.png";
    }
  }

  PumpStationDropDownModel? selectPumpStationId;
  int? pumpstation = 0;

  String getSubProject(projectName) {
    if (widget.ProjectName! == 'Garoth' || widget.ProjectName! == 'Mohanpura') {
      return 'BPT';
    } else if (widget.ProjectName! == 'Bistan') {
      return 'ST';
    } else {
      return 'DC';
    }
  }

  veryHigh(String? data) {
    if (data! == '1') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  high(String? data) {
    if (data! == '1') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  medium(String? data) {
    if (data! == '1') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  low(String? data) {
    if (data! == '1') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  veryLow(String? data) {
    if (data! == '1') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
