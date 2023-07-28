// ignore_for_file: prefer_const_constructors, unused_catch_stack, non_constant_identifier_names, camel_case_types

import 'dart:convert';

import 'package:WMS_Application/Model/AreaModel.dart';
import 'package:WMS_Application/Model/DistibutoryModel.dart';
import 'package:WMS_Application/Model/Project/OMS_Overview_model.dart';
import 'package:WMS_Application/Model/Project/OmsSqlMasterModel.dart';
import 'package:WMS_Application/Operations/StateselectionOperation.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/styles.dart';
import 'package:http/http.dart' as http;
import 'package:WMS_Application/core/utils/color_constant.dart';
import 'package:WMS_Application/core/utils/math_utils.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../widgets/New folder/core/utils/math_utils.dart';
String? omsStatus_check = 'All', DamageStatus_check = 'All', ListStatus = 'All';
AreaModel? modelArea;
DistibutroryModel? modelDistributary;
String? projectName;

class Graphical_Screen_Sql extends StatefulWidget {
  Graphical_Screen_Sql(
      {Key? key,
      AreaModel? area_,
      DistibutroryModel? dist_,
      String? omsStatus_check_,
      String? DamageStatus_check_,
      String? ListStatus_,
      String? ProjectName})
      : super(key: key) {
    modelArea = area_;
    modelDistributary = dist_;
    omsStatus_check = omsStatus_check_;
    DamageStatus_check = DamageStatus_check_;
    ListStatus = ListStatus_;
    projectName = ProjectName;
  }

  @override
  State<Graphical_Screen_Sql> createState() => _Graphical_Screen_SqlState();
}

class _Graphical_Screen_SqlState extends State<Graphical_Screen_Sql> {
  final myController = TextEditingController();

  List<OmsSqlMasterModel>? _DisplayList = <OmsSqlMasterModel>[];

  var cheklist = ['All'];
  String? _search = '';
  var area = 'All';
  var distibutory = 'ALL';

  AreaModel? selectedArea;
  DistibutroryModel? selectedDistributory;

  int _page = 0;
  int _limit = 5;
  int length = 6;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  late ScrollController _controller;

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      String? conString = preferences.getString('conString');

      final res = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/Project/OMSDisplayList?Search=$_search&_aid=$area&_did=$distibutory&_OMSStatus=$omsStatus_check&_DamageStatus=$DamageStatus_check&_ListStatus=$ListStatus&pageIndex=$_page&pageSize=$_limit&conString=$conString'));

      print(
          'http://wmsservices.seprojects.in/api/Project/OMSDisplayList?Search=$_search&_aid=$area&_did=$distibutory&_OMSStatus=$omsStatus_check&_DamageStatus=$DamageStatus_check&_ListStatus=$ListStatus&pageIndex=$_page&pageSize=$_limit&conString=$conString');

      var json = jsonDecode(res.body);
      List<OmsSqlMasterModel> fetchedData = <OmsSqlMasterModel>[];
      json.forEach((e) => fetchedData.add(new OmsSqlMasterModel.fromJson(e)));
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

  void _loadMore() async {
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
            'http://wmsservices.seprojects.in/api/Project/OMSDisplayList?Search=$_search&_aid=$area&_did=$distibutory&_OMSStatus=$omsStatus_check&_DamageStatus=$DamageStatus_check&_ListStatus=$ListStatus&pageIndex=$_page&pageSize=$_limit&conString=$conString'));
        var json = jsonDecode(res.body);
        List<OmsSqlMasterModel> fetchedData = <OmsSqlMasterModel>[];
        json.forEach((e) => fetchedData.add(new OmsSqlMasterModel.fromJson(e)));
        if (fetchedData.length > 0) {
          setState(() {
            _DisplayList!.addAll(fetchedData);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
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

  @override
  void initState() {
    super.initState();

    setState(() {
      //   selectedArea = modelArea!;
      //   area = selectedArea!.areaid == 0 ? 'All' : selectedArea!.areaid.toString();
      //   selectedDistributory = modelDistributary!;
      //   distibutory = selectedDistributory!.id == 0 ? 'All' : selectedDistributory!.id.toString();
      if (modelDistributary != null) {
        selectedDistributory = modelDistributary!;
        modelDistributary = null;
        distibutory = selectedDistributory!.id == 0
            ? 'All'
            : selectedDistributory!.id.toString();
      }
      if (modelArea != null) {
        selectedArea = modelArea!;
        modelArea = null;
        area =
            selectedArea!.areaid == 0 ? 'All' : selectedArea!.areaid.toString();
      }

      _DisplayList = [];
    });

    getDropDownAsync().whenComplete(() => GetOmsOverviewModel());

    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  getDist(BuildContext context, List<DistibutroryModel> values) {
    try {
      return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 168, 211, 237),
            borderRadius: BorderRadius.circular(5)),
        child: DropdownButton(
          value: selectedDistributory == null ||
                  (values
                          .where((element) => element == selectedDistributory)
                          .count() ==
                      0)
              ? values.first
              : selectedDistributory,
          underline: Container(color: Colors.transparent),
          isExpanded: true,
          items: values.map((DistibutroryModel distibutroryModel) {
            return DropdownMenuItem<DistibutroryModel>(
              value: distibutroryModel,
              child: Center(
                child: Text(
                  distibutroryModel.description!,
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
          onChanged: (textvalue) async {
            setState(() {
              _page = 0;
              _hasNextPage = true;
              _isFirstLoadRunning = false;
              _isLoadMoreRunning = false;
              _DisplayList = <OmsSqlMasterModel>[];

              selectedDistributory = textvalue as DistibutroryModel;
              distibutory = selectedDistributory!.id == 0
                  ? "All"
                  : selectedDistributory!.id.toString();
            });
            await GetOmsOverviewModel();
          },
        ),
      );
    } catch (_, ex) {
      return Container();
    }
  }

  getArea(BuildContext context, List<AreaModel> values) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 168, 211, 237),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButton(
        underline: Container(color: Colors.transparent),
        value: selectedArea == null ||
                (values.where((element) => element == selectedArea)).count() ==
                    0
            ? values.first
            : selectedArea,
        isExpanded: true,
        items: values.map((AreaModel areaModel) {
          return DropdownMenuItem<AreaModel>(
            value: areaModel,
            child: Center(
              child: Text(
                areaModel.areaName ?? '',
                textScaleFactor: 1,
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }).toList(),
        onChanged: (textvalue) async {
          //onAreaChange(textvalue);
          var data = textvalue as AreaModel;
          var distriFuture = getDistibutoryid(
              areaId: data.areaid == 0 ? 'All' : data.areaid.toString());
          if (modelDistributary == null)
            await distriFuture.then((value) => setState(() {
                  selectedDistributory = value.first;
                  distibutory = "All";
                }));

          setState(() {
            _page = 0;
            _hasNextPage = true;
            _isFirstLoadRunning = false;
            _isLoadMoreRunning = false;
            _DisplayList = <OmsSqlMasterModel>[];

            selectedArea = data;
            futureDistributory = distriFuture;

            area = selectedArea!.areaid == 0
                ? "All"
                : selectedArea!.areaid.toString();
          });
          await GetOmsOverviewModel();
          // setState(() {
          //   try {
          //     selectedState = textvalue as AreaModel;
          //   } catch (_, ex) {
          //     print(ex);
          //   }
          // });
        },
      ),
    );
  }

  Future<List<DistibutroryModel>>? futureDistributory;
  Future<List<AreaModel>>? futureArea;
  Future getDropDownAsync() async {
    setState(() {
      futureArea = getAreaid();
      futureDistributory = getDistibutoryid();
    });
  }

  Future<List<OMS_Overview_model>>? OmsListFuture;
  List<OMS_Overview_model>? OmsOverviewList = [];
  Future<List<OmsSqlMasterModel>>? DisplayListFuture;

  Future<void> GetOmsOverviewModel() async {
    try {
      if (selectedArea != null)
        area =
            selectedArea!.areaid == 0 ? 'All' : selectedArea!.areaid.toString();
      if (selectedDistributory != null)
        distibutory = selectedDistributory!.id == 0
            ? 'All'
            : selectedDistributory!.id.toString();

      _firstLoad();
      _DisplayList = [];
    } catch (_, ex) {}
  }

  getlongDate(String date) {
    try {
      final DateTime now = DateTime.parse(date);
      final DateFormat formatter = DateFormat('EEEE, d MMMM y H:m:s');
      final String formatted = formatter.format(now);
      print(formatted); // something like 2013-04-20
      return formatted;
    } catch (ex, _) {
      return 'Never Connected';
    }
  }

  double height = 400;
  double width = 200;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawerScreen(),
        appBar: AppBar(
            title: Text(
              "Graphical OMS Details".toUpperCase(), textScaleFactor: 1,
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
            await GetOmsOverviewModel();
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Container(
              decoration: BoxDecoration(image: backgroundImage),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
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
                                    onChanged: (value) async {
                                      if (value.isEmpty)
                                        await GetOmsOverviewModel();
                                      else
                                        setState(() {
                                          _search = value;
                                        });
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
                                  onPressed: () async {
                                    setState(() {
                                      _page = 0;
                                      _hasNextPage = true;
                                      _isFirstLoadRunning = false;
                                      _isLoadMoreRunning = false;
                                      // _DisplayList = <OmsSqlMasterModel>[];
                                    });
                                    await GetOmsOverviewModel();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //dropDown Menu List
                    ],
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// This Future Builder is Used for Area DropDown list
                      FutureBuilder(
                        future: futureArea,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                                height: 40,
                                width: 200,
                                child: getArea(context, snapshot.data!));
                          } else if (snapshot.hasError) {
                            return Text(
                              "Something Went Wrong: " +
                                  snapshot.error.toString(),
                              textScaleFactor: 1,
                            );
                          } else {
                            return Center(child: Container());
                          }
                        },
                      ),

                      ///This Future Builder is Used for Distibutory DropDown List
                      FutureBuilder(
                        future: futureDistributory,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                                height: 40,
                                width: 180,
                                child: getDist(context, snapshot.data!));
                          } else if (snapshot.hasError) {
                            return Text(
                              "Something Went Wrong: " +
                                  snapshot.error.toString(),
                              textScaleFactor: 1,
                            );
                          } else {
                            return Center(child: Container());
                          }
                        },
                      ),
                    ],
                  )),
                  getOmsList(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getOmsList(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        // physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: _controller,
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
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                  ),
              ]),
      ),
    );
  }

  Widget getBody() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _DisplayList!.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              child: Card(
                margin: EdgeInsets.all(10),
                color: Color.fromARGB(255, 255, 255, 255),
                shadowColor: Colors.blueGrey,
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: getVerticalSize(
                        2.00,
                      ),
                      left: getHorizontalSize(6.0)),
                  child: Container(
                    width: size.width,
                    // alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                          child: Text(
                            "CHAK NO:" + _DisplayList![index].chakNo!,
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: (_DisplayList![index].isConnected != 0
                                  ? Colors.green
                                  : Colors.red),
                              fontSize: getFontSize(
                                15,
                              ),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        //*PFCMD Diagram
                        Container(
                          height: 200,
                          child: SingleChildScrollView(
                            // scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                                      (convertBartoMeter(
                                                                  _DisplayList![
                                                                          index]
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
                                                      ((_DisplayList![index]
                                                                          .flowRate ??
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
                                                width: 50,
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
                                                                    (_DisplayList![index]
                                                                            .valvePosition ??
                                                                        0),
                                                                    (_DisplayList![index]
                                                                            .flowRate ??
                                                                        0))),
                                                      ),
                                                    ),
                                                    Text(
                                                      projectName!
                                                              .toLowerCase()
                                                              .contains(
                                                                  'cluster')
                                                          ? getOmsMode_Odisha(
                                                              _DisplayList![
                                                                          index]
                                                                      .oMODE ??
                                                                  0)
                                                          : getOmsMode(
                                                              _DisplayList![
                                                                          index]
                                                                      .oMODE ??
                                                                  0),
                                                      // getOmsMode(
                                                      //     _DisplayList![index]
                                                      //             .oMODE ??
                                                      //         0),
                                                      softWrap: true,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 45,
                                                      left: 10,
                                                      child: Text(
                                                        (_DisplayList![index]
                                                                        .valvePosition ??
                                                                    0.0)
                                                                .toStringAsFixed(
                                                                    2) +
                                                            " %",
                                                        softWrap: true,
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          // fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height: 30,
                                          // )
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
                                              (_DisplayList![index]
                                                              .outLetPressure ??
                                                          0.0)
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
                                            width: 48,
                                            height: 15,
                                          ),
                                          SizedBox(
                                            height: 16,
                                            child: Text(
                                              (_DisplayList![index]
                                                              .calculatedVolume ??
                                                          0.0)
                                                      .toStringAsFixed(2) +
                                                  " m³",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    ///Valves
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ///valve 1 and 5
                                            Column(children: [
                                              if (_DisplayList![index]
                                                      .v1IsAvailable !=
                                                  0)
                                                Column(
                                                  children: [
                                                    Text(
                                                      "V1",
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
                                                                  _DisplayList![
                                                                              index]
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
                                                  ],
                                                ),
                                              if (_DisplayList![index]
                                                      .v5IsAvailable !=
                                                  0)
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
                                                                  _DisplayList![
                                                                              index]
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
                                              if (_DisplayList![index]
                                                      .v5IsAvailable !=
                                                  1)
                                                SizedBox(height: 92)
                                            ]),

                                            ///valve 2 and 6
                                            Column(children: [
                                              if (_DisplayList![index]
                                                      .v2IsAvailable !=
                                                  0)
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
                                                                  _DisplayList![
                                                                              index]
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
                                              if (_DisplayList![index]
                                                      .v6IsAvailable !=
                                                  0)
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
                                                                  _DisplayList![
                                                                              index]
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
                                              if (_DisplayList![index]
                                                      .v6IsAvailable !=
                                                  1)
                                                SizedBox(height: 92)
                                            ]),

                                            ///valve 3 and 7
                                            Column(children: [
                                              if (_DisplayList![index]
                                                      .v3IsAvailable !=
                                                  0)
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
                                                                  _DisplayList![
                                                                              index]
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
                                              if (_DisplayList![index]
                                                      .v7IsAvailable !=
                                                  0)
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
                                                                  _DisplayList![
                                                                              index]
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
                                              if (_DisplayList![index]
                                                      .v7IsAvailable !=
                                                  1)
                                                SizedBox(height: 92)
                                            ]),

                                            ///valve 4 and 8
                                            Column(children: [
                                              if (_DisplayList![index]
                                                      .v4IsAvailable !=
                                                  0)
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
                                                                  _DisplayList![
                                                                              index]
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
                                              if (_DisplayList![index]
                                                      .v8IsAvailable !=
                                                  0)
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
                                                                  _DisplayList![
                                                                              index]
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
                                              if (_DisplayList![index]
                                                      .v8IsAvailable !=
                                                  1)
                                                SizedBox(
                                                  height: 92,
                                                )
                                            ]),

                                            ///valve 6
                                            /*                                          if (_DisplayList![index]
                                                    .v6IsAvailable !=
                                                0)
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
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                          Color.fromARGB(26,
                                                              199, 199, 199),
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
                                                        image: AssetImage(
                                                            getValvecolor(
                                                                _DisplayList![
                                                                            index]
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
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                          Color.fromARGB(26,
                                                              199, 199, 199),
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
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
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                          Color.fromARGB(26,
                                                              199, 199, 199),
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                        ])),
                                                    width: 30,
                                                    height: 15,
                                                  ),
                                                ],
                                              ),
*/
                                            ///valve 7
                                            /*                                          if (_DisplayList![index]
                                                    .v7IsAvailable !=
                                                0)
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
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                          Color.fromARGB(26,
                                                              199, 199, 199),
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
                                                        image: AssetImage(
                                                            getValvecolor(
                                                                _DisplayList![
                                                                            index]
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
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                          Color.fromARGB(26,
                                                              199, 199, 199),
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
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
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                          Color.fromARGB(26,
                                                              199, 199, 199),
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                        ])),
                                                    width: 30,
                                                    height: 15,
                                                  ),
                                                ],
                                              ),
*/
                                            ///valve 8
                                            /*if (_DisplayList![index]
                                                    .v8IsAvailable !=
                                                0)
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
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                          Color.fromARGB(26,
                                                              199, 199, 199),
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
                                                        image: AssetImage(
                                                            getValvecolor(
                                                                _DisplayList![
                                                                            index]
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
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                          Color.fromARGB(26,
                                                              199, 199, 199),
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
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
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                          Color.fromARGB(26,
                                                              199, 199, 199),
                                                          Colors.grey.shade500,
                                                          Colors.grey.shade500,
                                                        ])),
                                                    width: 30,
                                                    height: 15,
                                                  ),
                                                ],
                                              ),
                                          */
                                          ],
                                        ),
                                        SizedBox(
                                          height: 80,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              getRomsMode(_DisplayList![index]
                                                      .romsMode ??
                                                  0),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: Material(
                          color: Colors.black45,
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PFCMD_Details(_DisplayList![index], index),
                                ]),
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        );
      },
    );
  }

  PFCMD_Details(OmsSqlMasterModel? model, int index) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.87,
        // margin: EdgeInsets.only(
        //   left: getHorizontalSize(
        //     9.00,
        //   ),
        //   top: getVerticalSize(
        //     6.00,
        //   ),
        //   right: getHorizontalSize(
        //     9.00,
        //   ),
        //   bottom: getVerticalSize(
        //     8.00,
        //   ),
        // ),
        decoration: BoxDecoration(
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
          color: ColorConstant.whiteA700,
        ),
        child: Column(
          children: [
            /// Heading
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(),
                    Center(
                        child: Text(
                      "PFCMD Details",
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                    _getCloseButton(context),
                  ],
                )),

            ///Data
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width * 0.4,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //chak no
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  'CHAK NO : ',
                                  softWrap: true,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  model!.chakNo.toString(),
                                  softWrap: true,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                          //distributory
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    'DISTRIBUTORY : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  )),
                              Expanded(
                                child: Text(
                                  model.distributaryName.toString(),
                                  textScaleFactor: 1,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyan),
                                ),
                              )
                            ],
                          ),
                          //solar voltage
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    'SOLAR VOLTAGE : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Text(
                                  model.solarVoltage.toString() + " V",
                                  softWrap: true,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    // color: getSolarColor(
                                    //     model.solarVoltage ?? 0.0)
                                  ),
                                ),
                              )
                            ],
                          ),
                          //design pressure
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    'DESIGN PRESSURE : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      (model.designPressure ?? 0.0)
                                              .toStringAsFixed(2) +
                                          " m",
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          //inlet
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    'DESIGN FLOW RATE : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      // getdesignflowrate() +
                                      getdesignflowrate(model) + " LPS",
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          //volume
                          /*Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    'VOLUME : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      // getvolume(model, index).toString() +
                                          " m³",
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          //position set point
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    'POSITION SET POINT : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      // getpossetpoint(model, index).toString() +
                                          " %",
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),*/
                          //sustaing press
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    'SUSTAINING PRESS : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      (model.sustainingPressure ?? 0.0)
                                              .toStringAsFixed(2) +
                                          " m",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: model.sustainingPressure != 0
                                              ? Colors.green
                                              : Colors.red),
                                    )),
                              ),
                            ],
                          ),
                          //schedule
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    'SCHEDULE : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      ((model.scheduleStatus == 1
                                                  ? 'PRESENT'
                                                  : 'ABSENT'))
                                              .toString() +
                                          " ",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: model.scheduleStatus != 0
                                              ? Colors.green
                                              : Colors.red),
                                    )),
                              ),
                            ],
                          ),
                          //irrigation status
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    'IRRIGATION STATUS : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      (model.sIRR == 1 ? 'STOPPED' : 'STARTED')
                                              .toString() +
                                          " ",
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //pfcmd no
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'DOOR : ',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    (model.door1 == true || model.door2 == true
                                        ? "OPEN"
                                        : "CLOSE"),
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: (model.door1 == true ||
                                                model.door2 == true
                                            ? Colors.red
                                            : Colors.green),
                                        // color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                    // model.dOOR.toString(), //* TODO
                                    // softWrap: true,
                                    // textScaleFactor: 1,
                                    // style: TextStyle(
                                    //     fontSize: 10,
                                    //     fontWeight: FontWeight.bold,
                                    //     color: Colors.red),
                                  ),
                                ),
                              )
                            ],
                          ),
                          // area
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'AREA : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  )),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    model.areaName.toString(),
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                              )
                            ],
                          ),
                          //battery voltage
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'BATTERY  VOLTAGE : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    (model.batteryLevel ?? 0.0).toString() +
                                        " V",
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            ((model.batteryLevel ?? 0.0)) < 17
                                                ? Colors.green
                                                : Colors.red),
                                  ),
                                ),
                              )
                            ],
                          ),
                          // flow set point
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'FLOW SET POINT : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      getdesignflowrate(model).toString() +
                                          " LPS",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: model.setFlow != 0
                                              ? Colors.green
                                              : Colors.red),
                                    )),
                              ),
                            ],
                          ),
                          //outlet
                          /*Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'OUTLET PT : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      // (convertBartoMeter(model.aI3) ?? 0.0) +
                                          " m",
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: 
                                          //model.aI3 != 0
                                          //     ? Colors.green
                                          //     : 
                                              Colors.red,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),*/
                          // actual flow
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'ACTUAL FLOW RATE : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      (((model.flowRate) ?? 0.0) / 3.6)
                                              .toStringAsFixed(2) +
                                          " LPS",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: model.flowRate != 0
                                              ? Colors.green
                                              : Colors.red),
                                    )),
                              ),
                            ],
                          ),
                          // position
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    ' VALVE POSITION : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      (model.valvePosition ?? 0.0)
                                              .toStringAsFixed(2) +
                                          " %",
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          //reducing press
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'REDUCING PRESS : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      ((model.reducingPressure) ?? 0.0)
                                              .toStringAsFixed(2) +
                                          " m",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: model.inLetPressure != 0
                                              ? Colors.green
                                              : Colors.red),
                                    )),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 23,
                          )
                        ]),
                  ),
                ],
              ),
            ),
            //last response time
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        'LAST RESPONSE TIME :',
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        getlongDate(model.lastResponseTime ?? 0.0.toString()),
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //   getlongDate(String date) {
  //   final DateTime now = DateTime.parse(date);
  //   final DateFormat formatter = DateFormat('EEEE, d MMMM y H:m:s');
  //   final String formatted = formatter.format(now);
  //   // print(formatted); // something like 2013-04-20
  //   return formatted;
  // }

  getpfcmdcolor(var valpos, var flow) {
    if (valpos < 2) {
      return Colors.red;
    } else if (valpos > 2 && flow == 0) {
      return Colors.yellow;
    } else if (valpos > 2 && flow > 0) {
      return Colors.green;
    }
  }

  getdesignflowrate(OmsSqlMasterModel model) {
    var chakarea;
    chakarea = model.chakArea;
    var flowrate;
    flowrate = model.flowratePerHa;

    var designflowratehr = chakarea * flowrate;

    return designflowratehr.toStringAsFixed(2);
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
      return 'ON/OFF';
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

  convertBartoMeter(dynamic data) {
    if (data == null) {
      return '0.0';
    } else {
      var converted = data * 10.2;
      return converted.toStringAsFixed(2);
    }
  }

  _getCloseButton(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: FractionalOffset.topRight,
          child: GestureDetector(
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
