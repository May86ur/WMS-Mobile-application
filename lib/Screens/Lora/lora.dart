// ignore_for_file: non_constant_identifier_names, unused_field

import 'package:WMS_Application/core/app_export.dart';
import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:WMS_Application/Model/Project/LoRaGateWayMasterModel.dart';
import 'package:http/http.dart' as http;

class LoraPage extends StatefulWidget {
  const LoraPage({Key? key}) : super(key: key);

  @override
  State<LoraPage> createState() => _LoraPageState();
}

class _LoraPageState extends State<LoraPage> {
  String? _search = '';
  List<LoRaGateWayMasterModel>? PopupModelList;
  List<LoRaGateWayMasterModel>? _DisplayList = <LoRaGateWayMasterModel>[];

  @override
  void initState() {
    super.initState();
    setState(() {
      _DisplayList = [];
    });
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Text(
            " LoRa Gateway",
            //"Kundalia_LBC-OMS",
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
          _DisplayList = [];
          _firstLoad();
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(image: backgroundImage),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///Search Bar
                  Stack(
                    children: [
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) async {
                                      setState(() {
                                        _search = value;
                                      });
                                    },
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.go,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        hintText: "Search"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

/*                  Stack(
                    children: [
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _search = value;
                                      });
                                      _DisplayList = [];
                                      _firstLoad();
                                    },
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.go,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        hintText: "Search"),
                                  ),
                                ),
                                IconButton(
                                  splashColor: Colors.blue,
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    setState(() {
                                      _page = 0;
                                      _hasNextPage = true;
                                      _isFirstLoadRunning = false;
                                      _isLoadMoreRunning = false;
                                      _DisplayList = <LoRaGateWayMasterModel>[];
                                    });
                                    _firstLoad();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
*/
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        ///Table Header
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
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
                                  ColorConstant.cyan302,
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ///GateWay No.
                              Container(
                                  // height: 70,
                                  width: 70,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('GateWay No.',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w900)),
                                    ],
                                  )),

                              ///GateWay Name.
                              Container(
                                  height: 80,
                                  width: 110,
                                  // color: Colors.black,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('GateWay Name.',
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w900)),
                                    ],
                                  )),

/*                              /// Battery Voltage
                              Container(
                                width: 60,
                                // height: 60,
                                child: Center(
                                  child: Text('Battery \nVoltage',
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w900)),
                                ),
                              ),
*/
                              /// Last Data Recived
                              Container(
                                width: 90,
                                child: Text('Last Data Recived',
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w900)),
                              ),

                              ///Dev Status
                              Container(
                                  height: 70,
                                  width: 90,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text('Dev Status',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w900)),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  getAlarmList(context),
                ]),
          ),
        ),
      ),
    ));
  }

  getAlarmList(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        //controller: _controller,
        interactive: true,
        thickness: 12,
        thumbVisibility: true,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          //controller: _controller,
          child: Container(
            margin: EdgeInsets.only(
                left: getHorizontalSize(
                  8.00,
                ),
                right: getHorizontalSize(
                  8.00,
                ),
                bottom: getVerticalSize(13.00)),
            decoration: BoxDecoration(
              color: ColorConstant.whiteA700,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
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
            width: size.width,
            child: _isFirstLoadRunning
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(children: [
                    getBody(),
                    // when the _loadMore function is running
                    if (_isLoadMoreRunning == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),

                    // When nothing else to load
                    if (_hasNextPage == false)
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                      ),
                  ]),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    return FutureBuilder(
      future: _firstLoad(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ///GateWay No.
                          Container(
                              height: 80,
                              width: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      snapshot.data![index].gatewayNo!
                                          .toString(),
                                      textScaleFactor: 1,
                                      // textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              )),

                          ///GateWay Name.
                          Container(
                              height: 70,
                              width: 110,
                              // color: Colors.blue,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      snapshot.data![index].gatewayName!
                                          .toString(),
                                      textScaleFactor: 1,
                                      // textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        /*color:
                                  _DisplayList![index].devStatus != 0
                                      ? Colors.green
                                      : Colors.red*/
                                      )),
                                ],
                              )),

                          /// Battery Voltage
/*                            Container(
                            width: 60,
                            // height: 60,
                            child: Center(
                              child: Text(
                                  snapshot.data![index].batteryLevel
                                          .toString() +
                                      " V",
                                  textScaleFactor: 1,
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
*/
                          /// Last Data Recived
                          Container(
                            width: 90,
                            child: Center(
                                child: snapshot.data![index].lastDataReceived !=
                                        null
                                    ? Text(
                                        getshortdate(snapshot
                                            .data![index].lastDataReceived
                                            .toString()),
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )
                                    : Text(
                                        "Never Connected",
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )),
                          ),

                          ///Dev Status
                          Container(
                              height: 70,
                              width: 90,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                          snapshot.data![index].devStatus != 0
                                              ? 'Connected'
                                              : 'Not-Connected',
                                          textScaleFactor: 1,
                                          // textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: snapshot.data![index]
                                                          .devStatus !=
                                                      0
                                                  ? Colors.green
                                                  : Colors.red)),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 3,
                      color: Colors.blueGrey,
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: Text("No data found !"),
            );
          }
        } else if (snapshot.hasError) {
          return Text(
            "Something Went Wrong: " + snapshot.error.toString(),
            textScaleFactor: 1,
          );
        } else {
          return Center(child: Container());
        }
      },
    );
  }

  getshortdate(String date) {
    try {
      final DateTime now = DateTime.parse(date);
      final DateFormat formatter = DateFormat('d-MMM-y H:m');
      final String formatted = formatter.format(now);
      return formatted;
    } catch (ex, _) {
      return '';
    } // print(formatted);
    // something like 2013-04-20
  }

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

//  late ScrollController _controller;

  // This function will be called when the app launches (see the initState function)

  Future _firstLoad() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      String? conString = preferences.getString('conString');
      dynamic json;
      final res = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/LoRa/GetLoRaGateWayList?conString=$conString'));
      print(
          'http://wmsservices.seprojects.in/api/LoRa/GetLoRaGateWayList?conString=$conString');
      json = jsonDecode(res.body);
      List<LoRaGateWayMasterModel> fetchedData = <LoRaGateWayMasterModel>[];
      json['data']
          .forEach((e) => fetchedData.add(LoRaGateWayMasterModel.fromJson(e)));
      _DisplayList = [];
      return _search!.isNotEmpty
          ? fetchedData
              .where((element) => element.gatewayName!
                  .toLowerCase()
                  .contains(_search!.toLowerCase()))
              .toList()
          : fetchedData;
    } catch (err) {
      throw Exception("Something went wrong while fetching data");
    }
  }

/*  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        String? conString = preferences.getString('conString');

        final res = await http.get(Uri.parse(
            'http://wmsservices.seprojects.in/api/LoRa/GetLoRaGateWayList?conString=$conString'));
        var json = jsonDecode(res.body);
        List<LoRaGateWayMasterModel> fetchedData = <LoRaGateWayMasterModel>[];
        json['data'].forEach(
            (e) => fetchedData.add(new LoRaGateWayMasterModel.fromJson(e)));
        if (fetchedData.length > 0) {
          setState(() {
            _DisplayList!.addAll(fetchedData);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
*/
}
