// ignore_for_file: prefer_const_constructors, unused_catch_stack, unnecessary_null_comparison, unused_local_variable, camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:WMS_Application/Model/AreaModel.dart';
import 'package:WMS_Application/Model/DistibutoryModel.dart';
import 'package:WMS_Application/Model/Project/RMSMastermodel.dart';
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

String? rmsStatus_check = 'All', DamageStatus_check = 'All', ListStatus = 'All';
AreaModel? modelArea;
DistibutroryModel? modelDistributary;

class RMS_Graphical_Screen extends StatefulWidget {
  RMS_Graphical_Screen(
      {Key? key,
      AreaModel? area_,
      DistibutroryModel? dist_,
      String? RmsStatus_check,
      String? DamageStatus_check_,
      String? ListStatus_})
      : super(key: key) {
    modelArea = area_;
    modelDistributary = dist_;
    rmsStatus_check = RmsStatus_check;
    DamageStatus_check = DamageStatus_check_;
    ListStatus = ListStatus_;
  }

  @override
  State<RMS_Graphical_Screen> createState() => _RMS_Graphical_ScreenState();
}

class _RMS_Graphical_ScreenState extends State<RMS_Graphical_Screen> {
  final myController = TextEditingController();

  List<RMSMastermodel>? _DisplayList = <RMSMastermodel>[];

  var cheklist = ['All'];
  String? _search = '';
  var area = 'All';
  var distibutory = 'ALL';

  AreaModel? selectedArea;
  DistibutroryModel? selectedDistributory;

  List<RMSMastermodel>? PopupModelList;

  int _page = 0;
  int _limit = 5;

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
          'http://wmsservices.seprojects.in/api/Project/RMSDisplayList?Search=$_search&_aid=$area&_did=$distibutory&_RMSStatus=$rmsStatus_check&_DamageStatus=$DamageStatus_check&_ListStatus=$ListStatus&pageIndex=$_page&pageSize=$_limit&conString=$conString'));

      print(
          'http://wmsservices.seprojects.in/api/Project/RMSDisplayList?Search=$_search&_aid=$area&_did=$distibutory&_RMSStatus=$rmsStatus_check&_DamageStatus=$DamageStatus_check&_ListStatus=$ListStatus&pageIndex=$_page&pageSize=$_limit&conString=$conString');

      var json = jsonDecode(res.body);
      List<RMSMastermodel> fetchedData = <RMSMastermodel>[];
      json.forEach((e) => fetchedData.add(new RMSMastermodel.fromJson(e)));
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
            'http://wmsservices.seprojects.in/api/Project/RMSDisplayList?Search=$_search&_aid=$area&_did=$distibutory&_RMSStatus=$rmsStatus_check&_DamageStatus=$DamageStatus_check&_ListStatus=$ListStatus&pageIndex=$_page&pageSize=$_limit&conString=$conString'));
        var json = jsonDecode(res.body);
        List<RMSMastermodel> fetchedData = <RMSMastermodel>[];
        json.forEach((e) => fetchedData.add(new RMSMastermodel.fromJson(e)));
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
              _DisplayList = <RMSMastermodel>[];

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
                areaModel.areaName!,
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
            _DisplayList = <RMSMastermodel>[];

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
  List<DistibutroryModel>? DistriList;
  Future getDropDownAsync() async {
    setState(() {
      futureArea = getAreaid();
      futureDistributory = getDistibutoryid();
    });
  }

  Future<List<RMSMastermodel>>? OmsListFuture;
  List<RMSMastermodel>? OmsOverviewList = [];
  Future<List<RMSMastermodel>>? DisplayListFuture;

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
    } catch (_, ex) {}
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
              "Graphical RMS Details".toUpperCase(),
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
                                      _DisplayList = <RMSMastermodel>[];
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
        physics: const AlwaysScrollableScrollPhysics(),
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
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                            child: Text(
                              "RMS NO:" + _DisplayList![index].rmsNo.toString(),
                              textScaleFactor: 1,
                              style: TextStyle(
                                // color: (_DisplayList![index].oNLINE == "ON"
                                //     ? Colors.green
                                //     : Colors.red),
                                fontSize: getFontSize(
                                  15,
                                ),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
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
                                                      _DisplayList![index]
                                                              .aI3 ??
                                                          0.0)
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
                                                _DisplayList![index].rmsMode ??
                                                    0),
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
                                              _DisplayList![index]),
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
                                                getvalpos(_DisplayList![index]),
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                convertm3hrToLps(_DisplayList![
                                                                index]
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
                                                  _DisplayList![index].aI4 ??
                                                      0.0) +
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
                                            (_DisplayList![index].calculatedVolume ?? 0.0)
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
                                    RMS_Details(_DisplayList![index], index),
                                  ]),
                            ),
                          ),
                        );
                      });
                }),
          ],
        );
      },
    );
  }

  RMS_Details(RMSMastermodel model, int index) {
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
                      _DisplayList![index].rmsNo.toString(),
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
                                  'AREA NAME : ',
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
                                  (model.distributaryName ?? '-').toString(),
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
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
                                    'VALVE SIZE : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  )),
                              Expanded(
                                child: Text(
                                  (model.valveSize ?? 0.0).toString() + ' mm',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
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
                                    'INLET PRESSURE : ',
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Expanded(
                                child: Text(
                                  convertBartoMeter(model.aI3 ?? 0.0) + " m",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: (model.aI3 ?? 0.00) != 0.00
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
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
                                    'VALVE POSITION : ',
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
                                    (getvalpos(model) ?? 0.0).toString(),
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //inlet
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
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
                                    convertBartoMeter(model.ouletPipe ?? 0.0)
                                            .toString() +
                                        " m",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                    (convertBartoMeter(
                                                    model.sustainingPressure) ??
                                                0.0)
                                            .toString() +
                                        " m",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: model.sustainingPressure != 0
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ),
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
                                  'NETWORK : ',
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
                                    (model.areaName ?? '-').toString(),
                                    textScaleFactor: 1,
                                    // values[index].areaName!,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
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
                                    'DESIGN FLOW : ',
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
                                      (convertm3hrToLps(
                                                  (model.flowSetPoint ?? 0.0) *
                                                      (model.noOfValves ?? 0.0))
                                              .toString() +
                                          " lps"),
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 11,
                                          // color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          ),
                          //battery voltage
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'OUTLET PRESSURE : ',
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
                                      convertBartoMeter(model.aI4 ?? 0.0) +
                                          ' m',
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: (model.ouletPipe ?? 0) != 0
                                              ? Colors.green
                                              : Colors.red,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          ),
                          // flow set point
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'DOOR : ',
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
                                      (model.dI1 == 1 || model.dI2 == 1
                                          ? "OPEN"
                                          : "CLOSE"),
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color:
                                              (model.dI1 == 1 || model.dI2 == 1
                                                  ? Colors.red
                                                  : Colors.green),
                                          // color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'CONTROL MODE : ',
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
                                      getControllerMode(model.rmsMode ?? 0)
                                          .toString(),
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        // color: model.flowRate != 0
                                        //     ? Colors.green
                                        //     : Colors.red
                                      ),
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
                                    ' REDUCING PRESSURE : ',
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
                                      (convertBartoMeter(
                                                      model.reducingPressure) ??
                                                  0.0)
                                              .toString() +
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
                    child: model.lastResponseTime1!.length >= 19
                        ? Text(
                            model.lastResponseTime1!
                                    .substring(0, 10)
                                    .split('-')
                                    .reversed
                                    .join('-') +
                                " " +
                                model.lastResponseTime1!.substring(11),
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "Never Connected",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

/*
  getoperationmode(int data) {
    if (data == 0) {
      return 'Auto';
    } else if (data == 1) {
      return 'Manual';
    } else if (data == 2) {
      return 'Testing';
    } else {
      return 'Not Set';
    }
  }
*/
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
  // getControllerMode(int data) {
  //   if (data == 1) {
  //     return 'OPEN/CLOSE';
  //   } else if (data == 2) {
  //     return 'Flow bypass';
  //   } else if (data == 3) {
  //     return 'Flow Control';
  //   } else if (data == 4) {
  //     return 'Differential pressure';
  //   } else if (data == 5) {
  //     return 'Pressure relief';
  //   } else if (data == 6) {
  //     return 'Postion';
  //   } else if (data == 7) {
  //     return 'Sprinkler';
  //   } else if (data == 8) {
  //     return 'Design flow control';
  //   } else if (data == 9) {
  //     return 'Design Flow';
  //   } else if (data == 10) {
  //     return 'Pressurize irrigation';
  //   } else if (data == 11) {
  //     return 'Auto position';
  //   } else {
  //     return 'Not Set';
  //   }
  // }

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

/*  String getGSMlevel(String LevelStatus) {
    {
      if (LevelStatus == "ON") {
        return "assets/images/ExcellentSignal.png";
      } else {
        return "assets/images/BadSignal.png";
      }
    }
  }
*/

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
      try {
        return (data < 0 ? 0 : data);
        // try {
        //   batVoltage = BatLevel;
        //   batper = (batVoltage - 11) * 100 / (16.5 - 11);
        //   if (batper < 0.0) {
        //     return 0.0;
        //   } else if (batper > 100.0) {
        //     return 0.0;
        //   } else {
        //     return batper;
        //   }
      } catch (_, ex) {}
    } catch (_, ex) {}

    // return batper > 0 ? 0.0 : batper;
    return batper;
  }

  getPFCMDContainerColor(RMSMastermodel model) {
    try {
      var pos = model.aI1;
      var flow = model.calculatedFlow;
      var vol = model.calculatedVolume;
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

  convertBartoMeter(dynamic data) {
    if (data == null) {
      return '0.0';
    } else {
      var converted = data * 10.2;

      return converted.toStringAsFixed(2);
    }
  }

/*
  getPFCMDContainerColor(RMSMastermodel model, int index) {
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

  getPTVALVEx(RMSMastermodel model, int x) {
    dynamic value = 0.0;
    switch (x) {
      case 1:
        value = model.pT2Valve1;
        break;
      case 2:
        value = model.pT2Valve2;
        break;
      case 3:
        value = model.pT2Valve3;
        break;
      case 4:
        value = model.pT2Valve4;
        break;
      case 5:
        value = model.pT2Valve5;
        break;
      case 6:
        value = model.pT2Valve6;
        break;
    }
    return value == null ? 0.0 : value;
  }

  getFlowVALVEx(RMSMastermodel model, int x) {
    dynamic value = 0.0;
    switch (x) {
      case 1:
        value = model.flowValve1;
        break;
      case 2:
        value = model.flowValve2;
        break;
      case 3:
        value = model.flowValve3;
        break;
      case 4:
        value = model.flowValve4;
        break;
      case 5:
        value = model.flowValve5;
        break;
      case 6:
        value = model.flowValve6;
        break;
    }
    return value == null ? 0.0 : value;
  }

  PFCMD_Details(RMSMastermodel model, int index) {
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
                                  model.chakNo.toString(),
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
                                      color: getSolarColor(
                                          model.solarVoltage ?? 0.0)),
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
                                      model.availableResidualHead
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
                                    'INLET PT : ',
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
                                      (convertBartoMeter(model.aI4) ?? '0.0') +
                                          " m",
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: model.aI4 != 0
                                              ? Colors.green
                                              : Colors.red,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          //volume
                          Row(
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
                                      getvolume(model, index).toString() +
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
                                      getpossetpoint(model, index).toString() +
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
                                      getsuspress(model, index).toString() +
                                          " m",
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
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
                                      model.schedule!,
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
                                  'PFCMD NO : ',
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
                                    index.toString(),
                                    softWrap: true,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
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
                                      getflowsetpoint(model, index).toString() +
                                          ' LPS',
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          //outlet
                          Row(
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
                                      (convertBartoMeter(model.aI3) ?? 0.0) +
                                          " m",
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: model.aI3 != 0
                                              ? Colors.green
                                              : Colors.red,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          // actual flow
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'ACTUAL FLOW(LPS) : ',
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
                                      getactualflow(model, index).toString(),
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
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
                                    ' POSITION : ',
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
                                      getpos(model, index).toString() + " %",
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
                                      getredpress(model, index).toString() +
                                          " m",
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          //irrigation status
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
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
                                      getirriagtionstatus(model, index),
                                      softWrap: true,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
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
                    child: model.lastResponseTime1!.length >= 19
                        ? Text(
                            model.lastResponseTime1!
                                    .substring(0, 10)
                                    .split('-')
                                    .reversed
                                    .join('-') +
                                " " +
                                model.lastResponseTime1!.substring(11),
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "Never Connected",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  convertBartoMeter(dynamic data) {
    if (data == null) {
      return '0.0';
    } else {
      var converted = data * 10.2;
      return converted.toStringAsFixed(2);
    }
  }

  getinletpress(RMSMastermodel model, int x) {
    double value = 0.0;
    switch (x) {
      case 1:
        if (convertBartoMeter(model.aI2) > 100) {
          value = convertBartoMeter(model.aI2);
        } else if (double.parse(model.aI2) == 0 &&
            double.parse(model.pT2Valve1) > 0) {
          value = convertBartoMeter(model.aI2);
        } else if ((double.parse(model.aI2) - double.parse(model.pT2Valve1)) >
            20) {
          value = convertBartoMeter(model.aI2);
        } else {
          value = convertBartoMeter(model.aI2);
        }
    }
    return value;
  }

  getvolume(RMSMastermodel model, int x) {
    dynamic value = 0.0;
    switch (x) {
      case 1:
        value = model.volValve1;
        break;
      case 2:
        value = model.volValve2;
        break;
      case 3:
        value = model.volValve3;
        break;
      case 4:
        value = model.volValve4;
        break;
      case 5:
        value = model.volValve5;
        break;
      case 6:
        value = model.volValve6;
        break;
    }
    return value == null ? 0.0 : value;
  }

  getpossetpoint(RMSMastermodel model, int x) {
    dynamic value = 0.0;
    switch (x) {
      case 1:
        value = model.posSetPt1;
        break;
      case 2:
        value = model.posSetPt2;
        break;
      case 3:
        value = model.posSetPt3;
        break;
      case 4:
        value = model.posSetPt4;
        break;
      case 5:
        value = model.posSetPt5;
        break;
      case 6:
        value = model.posSetPt6;
        break;
    }
    return value == null ? 0.0 : value;
  }

  getsuspress(RMSMastermodel model, int x) {
    dynamic value = 0.0;
    switch (x) {
      case 1:
        value = model.sustPress1;
        break;
      case 2:
        value = model.sustPress2;
        break;
      case 3:
        value = model.sustPress3;
        break;
      case 4:
        value = model.sustPress4;
        break;
      case 5:
        value = model.sustPress5;
        break;
      case 6:
        value = model.sustPress6;
        break;
    }
    return value == null ? 0.0 : value;
  }

  getredpress(RMSMastermodel model, int x) {
    dynamic value = 0.0;
    switch (x) {
      case 1:
        value = model.redPress1;
        break;
      case 2:
        value = model.redPress2;
        break;
      case 3:
        value = model.redPress3;
        break;
      case 4:
        value = model.redPress4;
        break;
      case 5:
        value = model.redPress5;
        break;
      case 6:
        value = model.redPress6;
        break;
    }
    return value == null ? 0.0 : value;
  }

  getflowsetpoint(RMSMastermodel model, int x) {
    dynamic value = 0.0;
    switch (x) {
      case 1:
        value = model.flowSetPt1;
        break;
      case 2:
        value = model.flowSetPt2;
        break;
      case 3:
        value = model.flowSetPt3;
        break;
      case 4:
        value = model.flowSetPt4;
        break;
      case 5:
        value = model.flowSetPt5;
        break;
      case 6:
        value = model.flowSetPt6;
        break;
    }
    return value == null ? 0.0 : value;
  }

  getactualflow(RMSMastermodel model, int x) {
    dynamic value = 0.0;
    switch (x) {
      case 1:
        value = model.flowValve1;
        break;
      case 2:
        value = model.flowValve2;
        break;
      case 3:
        value = model.flowValve3;
        break;
      case 4:
        value = model.flowValve4;
        break;
      case 5:
        value = model.flowValve5;
        break;
      case 6:
        value = model.flowValve6;
        break;
    }
    return value == null ? 0.0 : value;
  }

  getpos(RMSMastermodel model, int x) {
    dynamic value = 0.0;
    switch (x) {
      case 1:
        value = model.posValve1;
        break;
      case 2:
        value = model.posValve2;
        break;
      case 3:
        value = model.posValve3;
        break;
      case 4:
        value = model.posValve4;
        break;
      case 5:
        value = model.posValve5;
        break;
      case 6:
        value = model.posValve6;
        break;
    }
    return value == null ? 0.0 : value;
  }

  getirriagtionstatus(RMSMastermodel model, int x) {
    dynamic value = "";
    switch (x) {
      case 1:
        value = model.sIRR1 == 0 ? "Yes" : "No";
        break;
      case 2:
        value = model.sIRR2 == 0 ? "Yes" : "No";
        break;
      case 3:
        value = model.sIRR3 == 0 ? "Yes" : "No";
        break;
      case 4:
        value = model.sIRR4 == 0 ? "Yes" : "No";
        break;
      case 5:
        value = model.sIRR5 == 0 ? "Yes" : "No";
        break;
      case 6:
        value = model.sIRR6 == 0 ? "Yes" : "No";
        break;
    }
    return value == null ? 'No' : value;
  }

  getmodevalve(RMSMastermodel model, int mode) {
    switch (mode) {
      case 1:
        if (model.modeValve1 == 1) {
          return 'O';
        } else if (model.modeValve1 == 2) {
          return 'F';
        } else if (model.modeValve1 == 3) {
          return 'P';
        } else
          return 'N';
      case 2:
        if (model.modeValve2 == 1) {
          return 'O';
        } else if (model.modeValve2 == 2) {
          return 'F';
        } else if (model.modeValve2 == 3) {
          return 'P';
        } else
          return 'N';
      case 3:
        if (model.modeValve3 == 1) {
          return 'O';
        } else if (model.modeValve3 == 2) {
          return 'F';
        } else if (model.modeValve3 == 3) {
          return 'P';
        } else
          return 'N';
      case 4:
        if (model.modeValve4 == 1) {
          return 'O';
        } else if (model.modeValve4 == 2) {
          return 'F';
        } else if (model.modeValve4 == 3) {
          return 'P';
        } else
          return 'N';

      case 5:
        if (model.modeValve5 == 1) {
          return 'O';
        } else if (model.modeValve5 == 2) {
          return 'F';
        } else if (model.modeValve5 == 3) {
          return 'P';
        } else
          return 'N';
      case 6:
        if (model.modeValve6 == 1) {
          return 'O';
        } else if (model.modeValve6 == 2) {
          return 'F';
        } else if (model.modeValve6 == 3) {
          return 'P';
        } else
          return 'N';
    }
  }

  getsmodevalve(RMSMastermodel model, int mode) {
    switch (mode) {
      case 1:
        if (model.smodeValve1 == 1) {
          return 'A';
        } else if (model.smodeValve1 == 2) {
          return 'M';
        } else if (model.smodeValve1 == 3) {
          return 'T';
        } else
          return 'N';
      case 2:
        if (model.smodeValve2 == 1) {
          return 'A';
        } else if (model.smodeValve2 == 2) {
          return 'M';
        } else if (model.smodeValve2 == 3) {
          return 'T';
        } else
          return 'N';
      case 3:
        if (model.smodeValve3 == 1) {
          return 'A';
        } else if (model.smodeValve3 == 2) {
          return 'M';
        } else if (model.smodeValve3 == 3) {
          return 'T';
        } else
          return 'N';
      case 4:
        if (model.smodeValve4 == 1) {
          return 'A';
        } else if (model.smodeValve4 == 2) {
          return 'M';
        } else if (model.smodeValve4 == 3) {
          return 'T';
        } else
          return 'N';

      case 5:
        if (model.smodeValve5 == 1) {
          return 'A';
        } else if (model.smodeValve5 == 2) {
          return 'M';
        } else if (model.smodeValve5 == 3) {
          return 'T';
        } else
          return 'N';
      case 6:
        if (model.smodeValve6 == 1) {
          return 'A';
        } else if (model.smodeValve6 == 2) {
          return 'M';
        } else if (model.smodeValve6 == 3) {
          return 'T';
        } else
          return 'N';
    }
  }

/*  getmodevalve(RMSMastermodel model, int mode) {
    switch (mode) {
      case 1:
        if (model.modeValve1 == 1) {
          return 'O';
        } else if (model.modeValve1 == 2) {
          return 'F';
        } else
          return 'O';
      case 2:
        if (model.modeValve2 == 1) {
          return 'O';
        } else if (model.modeValve2 == 2) {
          return 'F';
        } else
          return 'O';
        break;
      case 3:
        if (model.modeValve3 == 1) {
          return 'O';
        } else if (model.modeValve3 == 2) {
          return 'F';
        } else
          return 'O';
        break;
      case 4:
        if (model.modeValve4 == 1) {
          return 'O';
        } else if (model.modeValve4 == 2) {
          return 'F';
        } else
          return 'O';

        break;
      case 5:
        if (model.modeValve5 == 1) {
          return 'O';
        } else if (model.modeValve5 == 2) {
          return 'F';
        } else
          return 'O';
        break;
      case 6:
        if (model.modeValve6 == 1) {
          return 'O';
        } else if (model.modeValve6 == 2) {
          return 'F';
        } else
          return 'O';
        break;
    }
  }

  getsmodevalve(RMSMastermodel model, int mode) {
    switch (mode) {
      case 1:
        if (model.smodeValve1 == 1) {
          return 'A';
        } else if (model.smodeValve1 == 2) {
          return 'M';
        } else
          return 'A';
        break;
      case 2:
        if (model.smodeValve2 == 1) {
          return 'A';
        } else if (model.smodeValve2 == 2) {
          return 'M';
        } else
          return 'A';
        break;
      case 3:
        if (model.smodeValve3 == 1) {
          return 'A';
        } else if (model.smodeValve3 == 2) {
          return 'M';
        } else
          return 'A';
        break;
      case 4:
        if (model.smodeValve4 == 1) {
          return 'A';
        } else if (model.smodeValve4 == 2) {
          return 'M';
        } else
          return 'A';

        break;
      case 5:
        if (model.smodeValve5 == 1) {
          return 'A';
        } else if (model.smodeValve5 == 2) {
          return 'M';
        } else
          return 'A';
        break;
      case 6:
        if (model.smodeValve6 == 1) {
          return 'A';
        } else if (model.smodeValve6 == 2) {
          return 'M';
        } else
          return 'A';
        break;
    }
  }
*/
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
*/
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
