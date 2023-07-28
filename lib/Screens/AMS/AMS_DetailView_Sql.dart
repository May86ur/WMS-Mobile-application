// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:WMS_Application/Model/Project/AmsMasterModelSql.dart';
import 'package:WMS_Application/Operations/StateselectionOperation.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:WMS_Application/core/app_export.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

AmsMasterModelSql? modelData;
var _search = '';
// var initdistributory = (modelData!.distributaryId ?? 'ALL').toString();
// var initarea = (modelData!.areaId ?? 'All').toString();

var cheklist = ['All'];
int _page = 0;
int _limit = 20;
String? AMSStatusCheck = 'ALL';
String? DamageStatusCheck = 'ALL';
// Initial Selected Value
var area = 'All';
var distibutory = 'ALL';

// There is next page or not
bool _hasNextPage = true;

// Used to display loading indicators when _firstLoad function is running
var _isFirstLoadRunning = false;

class AmsDetailViewSql extends StatefulWidget {
  String? ProjectName;

// String? ProjectName;

  AmsDetailViewSql(AmsMasterModelSql? _modelData, String project) {
    modelData = _modelData ?? null;
    ProjectName = project;
  }
  @override
  State<AmsDetailViewSql> createState() => _AmsDetailViewSqlState();
}

class _AmsDetailViewSqlState extends State<AmsDetailViewSql> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawerScreen(),
        // backgroundColor: ColorConstant.whiteA700,
        appBar: AppBar(
            title: Text(
              widget.ProjectName!
                      .toString()
                      .replaceAll("_", " ")
                      .toUpperCase() +
                  " - AMS",
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
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                left: getHorizontalSize(
                  9.00,
                ),
                top: getVerticalSize(
                  11.00,
                ),
                right: getHorizontalSize(
                  9.00,
                ),
                bottom: getVerticalSize(
                  20.00,
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
                  //*Chak no
                  Container(
                    alignment: Alignment.center,
                    height: getVerticalSize(
                      37.00,
                    ),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: (modelData!.isconnected != 0
                          ? ColorConstant.green900
                          : ColorConstant.redA700),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          modelData!.amsNo.toString(),
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
                            padding: EdgeInsets.only(bottom: 1, left: 5),
                            alignment: Alignment.center,
                            onPressed: () async {
                              await _reload();
                              getpop(context);
                              new Future.delayed(new Duration(seconds: 1), () {
                                Navigator.pop(context); //pop dialog
                              });
                            },
                            icon: Icon(
                              Icons.refresh,
                            ))
                      ],
                    ),
                  ),

                  //*Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ///Door
/*                      Column(children: [
                        Padding(
                            padding: EdgeInsets.only(top: 10, right: 10),
                            child: Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: (modelData!.dI1 == 1 ||
                                            modelData!.dI2 == 1
                                        ? Colors.red
                                        : Colors.green)),
                                height: 40,
                                width: 40,
                              ),
                              Positioned(
                                top: 6,
                                left: 5,
                                child: Image(
                                    image: (modelData!.dI1 == 1 ||
                                            modelData!.dI2 == 1
                                        ? AssetImage(
                                            "assets/images/door_open.png")
                                        : AssetImage(
                                            "assets/images/door_closed.png")),
                                    height: 30,
                                    width: 30),
                              )
                            ]))
                      ]),
*/
/*                      ///signal
                      Padding(
                        padding: EdgeInsets.only(top: 10, right: 10),
                        child: Image(
                            image: AssetImage(getGSMlevel(
                                modelData!.isconnected!.toString())),
                            height: 30,
                            width: 25),
                      ),
*/
                      ///Battery
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10, right: 10),
                            child: Stack(children: [
                              Image(
                                image: AssetImage(
                                  getBattreydata_new(
                                      // modelData!.batteryPercentage!.toDouble()
                                      getBatpercentage(
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
                                    getBatpercentage(
                                                modelData!.batteryLevel != null
                                                    ? modelData!.batteryLevel!
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
                            padding: EdgeInsets.only(
                              top: 10,
                            ),
                            child: Image(
                              image: AssetImage(getSolarLevel(
                                  (modelData!.solarVoltage ?? 0.0).toInt())),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            openMap(modelData!.amsCoordinate.toString());
                          },
                          child: Image(
                            height: 25,
                            width: 25,
                            image: AssetImage('assets/images/navigation2.png'),
                          ),
                        ),
                      )
                    ],
                  ),

                  //*Data.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 14),
                        width: 190,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //*Distributory
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
                                  (modelData!.description ?? '-').toString(),
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            //*Solar Voltage
                            Row(
                              children: [
                                Text(
                                  'Solar Voltage : ',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  (modelData!.solarVoltage ?? 0.0)
                                          .toStringAsFixed(2) +
                                      ' V',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: getSolarColor(
                                          modelData!.solarVoltage ?? 0.0),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            //*Design Press
                            Row(children: [
                              Text(
                                'Design Press : ',
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                (modelData!.designPressure1 ?? 0.0)
                                        .toStringAsFixed(2) +
                                    ' m',
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                            ]),

                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                      //*Door
                      Container(
                        width: 190,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //*Sub Area
                            Row(
                              children: [
                                Text(
                                  'Sub Area : ',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  (modelData!.subArea ?? '-').toString(),
                                  textScaleFactor: 1,
                                  // values[index].areaName!,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
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
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  (modelData!.dI1 == true ||
                                          modelData!.dI2 == true
                                      ? "OPEN"
                                      : "CLOSE"),
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: (modelData!.dI1 == true ||
                                              modelData!.dI2 == true
                                          ? Colors.red
                                          : Colors.green),
                                      // color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),

                            //*Battery Voltage
                            Row(
                              children: [
                                Text(
                                  'Battery Voltage : ',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                    (modelData!.batteryLevel ?? 0.0)
                                            .toString() +
                                        ' V',
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color:
                                            ((modelData!.batteryLevel ?? 0.0) <
                                                    17
                                                ? Colors.red
                                                : Colors.green),
                                        fontWeight: FontWeight.bold))
                              ],
                            ),

                            //*Actual Pressure
                            Row(
                              children: [
                                Text(
                                  'Actual Pressure : ',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  (modelData!.actualPressure ?? 0)
                                          .toStringAsFixed(2) +
                                      ' m',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  //*AMS Diagram
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            height: 8,
                            width: 60,
                          ),
                        ),
                        Container(
                          width: 45,
                          height: 20,
                          color: Colors.black,
                        ),
                        Container(
                          color: Colors.black,
                          // decoration: BoxDecoration(
                          // color: Colors.black,
                          // borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(6))),
                          height: 8,
                          width: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              width: 45,
                              height: 48,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Center(
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    height: 13,
                                    width: 13,
                                    decoration: BoxDecoration(
                                      gradient: RadialGradient(
                                          radius: 5,
                                          colors: modelData!.isconnected == 1
                                              ? [
                                                  ColorConstant.lightGreenA700,
                                                  ColorConstant.green900,
                                                  ColorConstant.whiteA700
                                                ]
                                              : [
                                                  ColorConstant.redA700,
                                                  ColorConstant.redA701,
                                                  ColorConstant.whiteA700
                                                ]

                                          //                   ( ColorConstant.green900
                                          // : ColorConstant.redA700),

                                          /*Colors.green,
                                            Colors.green,
                                            Colors.white
                                            */
                                          ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 10),
                                child: Text(
                                  ((modelData!.actualPressure) != null
                                              ? (modelData!.actualPressure ??
                                                      0) *
                                                  100 /
                                                  100
                                              : 0.0)
                                          .toStringAsFixed(2) +
                                      ' m',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 15,
                          height: 8,
                          color: Colors.black,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(6),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(6))),
                          width: 25,
                          height: 6,
                        ),
                        Container(
                          width: 15,
                          height: 8,
                          color: Colors.black,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(6),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(6))),
                          width: 25,
                          height: 6,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Colors.grey.shade500,
                            Colors.grey.shade500,
                            Color.fromARGB(26, 199, 199, 199),
                            Colors.grey.shade500,
                            Colors.grey.shade500,
                          ])),
                          width: 18,
                          height: 20,
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
                          width: MediaQuery.of(context).size.width * 0.88,
                          height: 20,
                        ),
                      ],
                    ),
                  ),

                  //*buttons
                  /*        Padding(
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(
                        14.00,
                      ),
                      top: getVerticalSize(
                        19.00,
                      ),
                      right: getHorizontalSize(
                        11.00,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //Refresh
                        InkWell(
                          onTap: () async {
                            await _reload();

                        
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

                        //Interogate
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
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
                     ],
                    ),
                  ),
*/

                  SizedBox(
                    height: 20,
                  ),
                  //*Last Response Time
                  Container(
                    margin: EdgeInsets.only(
                      left: getHorizontalSize(
                        14.00,
                      ),
                      top: getVerticalSize(
                        11.00,
                      ),
                      right: getHorizontalSize(
                        11.00,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "LAST RESPONSE TIME : ",
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: ColorConstant.black900,
                            fontSize: getFontSize(
                              9,
                            ),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        modelData!.lastResponseTime1 != null
                            ? Text(
                                getlongDate(
                                    modelData!.lastResponseTime1.toString()),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "Never Connected",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                      ],
                    ),
                  ),

                  //* Last Routen  check
                  Container(
                    margin: EdgeInsets.only(
                      left: getHorizontalSize(
                        11.00,
                      ),
                      top: getVerticalSize(
                        5.00,
                      ),
                      right: getHorizontalSize(
                        11.00,
                      ),
                      bottom: getVerticalSize(
                        9.00,
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'LAST ROUTINE CHECK DONE ON : ',
                            style: TextStyle(
                              color: ColorConstant.black900,
                              fontSize: getFontSize(
                                9,
                              ),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: 'NA',
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
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  Future _reload() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //int? userid = preferences.getInt('userid');
      String? conString = preferences.getString('conString');
      //String? project = preferences.getString('project');
      String? liststatus = cheklist.join(',');
      _search = modelData!.amsNo!;
      var aid = modelData!.areaId!.toString();
      var did = modelData!.distributroyId!.toString();
      final res = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/AMS/AMSDisplayList?Search=$_search&_aid=$aid&_did=$did&_AMSStatus=$AMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString'));
      print(
          'http://wmsservices.seprojects.in/api/AMS/AMSDisplayList?Search=$_search&_aid=$aid&_did=$did&_AMSStatus=$AMSStatusCheck&_DamageStatus=$DamageStatusCheck&_ListStatus=$liststatus&pageIndex=$_page&pageSize=$_limit&conString=$conString');

      var json = jsonDecode(res.body);
      List<AmsMasterModelSql> fetchedData = <AmsMasterModelSql>[];
      json.forEach((e) => fetchedData.add(new AmsMasterModelSql.fromJson(e)));
      if (fetchedData.length > 0) {
        setState(() {
          modelData = fetchedData
              .singleWhere((element) => element.amsId! == modelData!.amsId!);
          getAmsOverviewdata(AMSStatusCheck!, DamageStatusCheck!,
              area.toString(), distibutory.toString());
          //_DisplayList!.addAll(fetchedData);getAmsOverviewdata(
          // String amsStatus, String damageStatus, String aid, String did)
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
    print(formatted); // something like 2013-04-20
    return formatted;
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

  String getGSMlevel(String LevelStatus) {
    {
      if (LevelStatus == "ON") {
        return "assets/images/ExcellentSignal.png";
      } else {
        return "assets/images/BadSignal.png";
      }
    }
  }

  getBatpercentage(double BatLevel) {
    var batper;
    try {
      if (BatLevel == 0) {
        return 0.0;
      } else {
        batper = ((BatLevel - 11.1) * 100) / (16.8 - 11.1);
        // var BatLvl = ((replaceNull(v.BatteryLevel, '-') - 11.1) * 100 / (16.8 - 11.1))
        if (batper <= 0.0)
          batper = 0.0;
        else if (batper >= 100.00) batper = 100.00;
        return batper;
      }
    } catch (_, ex) {
      return 0.0;
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
      } else if (LevelStatus > 100) {
        return "assets/images/battery100.png";
      } else {
        return "assets/images/battery10.png";
      }
    } catch (_, ex) {
      return "assets/images/battery10.png";
    }
  }
}
