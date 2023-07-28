// ignore_for_file: non_constant_identifier_names, must_be_immutable
import 'dart:convert';
import 'package:WMS_Application/Model/Project/ActiveAlarmMasterModel_new.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/styles.dart';
import 'package:http/http.dart' as http;
import 'package:WMS_Application/Model/Project/OMS_Overview_model.dart';
import 'package:flutter/material.dart';
import 'package:WMS_Application/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveAlarm_dba extends StatefulWidget {
  String? ProjectName;

  ActiveAlarm_dba(String project) {
    ProjectName = project;
  }
  @override
  State<ActiveAlarm_dba> createState() => _ActiveAlarm_dbaState();
}

class _ActiveAlarm_dbaState extends State<ActiveAlarm_dba> {
  get status => null;

  // Initial Selected Value
  var area = 'All';
  var distibutory = 'ALL';

  String? _search = '';

  // AreaModel? selectedArea;
  ActiveAlarmMasterModel? selectedDiviceType;

  List<ActiveAlarmMasterModel>? PopupModelList;

  Future<List<ActiveAlarmMasterModel>>? futureDistributory;

  String devicetype = 'OMS';
  var items1 = ['OMS', 'AMS'];

  // List<ActiveAlarmMasterModel>? _OmsList;
  List<ActiveAlarmMasterModel>? _DisplayList = <ActiveAlarmMasterModel>[];

  @override
  void initState() {
    super.initState();
    // getDropDownAsync().whenComplete(() async => await GetOmsOverviewModel());
    setState(() {
      _DisplayList = [];
    });
    _firstLoad();
    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  Future<List<OMS_Overview_model>>? OmsListFuture;
  List<OMS_Overview_model>? OmsOverviewList = [];
  Future<List<ActiveAlarmMasterModel>>? DisplayListFuture;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: MyDrawerScreen(),
      appBar: AppBar(
          title: Text(
            widget.ProjectName!.toString().toUpperCase() + "- Active Alarm",
            textScaleFactor: 1,
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
                                      // _firstLoad();
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
                                      _DisplayList = <ActiveAlarmMasterModel>[];
                                    });
                                    _firstLoad();
                                    // new Future.delayed(new Duration(seconds: 1),
                                    //     () {
                                    //   Navigator.pop(context); //pop dialog
                                    // }
                                    // );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //dropDown Menu List
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 168, 211, 237),
                          borderRadius: BorderRadius.circular(5)),
                      width: size.width,
                      child: DropdownButton(
                        underline: Container(color: Colors.transparent),
                        isExpanded: true,
                        value: devicetype,
                        items: items1.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Center(
                              child: Text(
                                items,
                                textScaleFactor: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.black900,
                                  fontSize: getFontSize(
                                    11,
                                  ),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            devicetype = newValue!;
                          });
                          _firstLoad();
                          _DisplayList = [];
                        },
                      ),
                    ),
                  ),

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
                          //BoxDecoration(color: Color.fromARGB(255, 235, 232, 169)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  devicetype == "OMS" ? "CHAK NO." : "AMS NO.",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "DESCRIPTION",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getFontSize(
                                      13,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "ALARM TIME",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getFontSize(
                                      13,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
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
        controller: _controller,
        interactive: true,
        thickness: 12,
        thumbVisibility: true,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: _controller,
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
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _DisplayList!.length,
      itemBuilder: (context, index) {
        var item = _DisplayList![index];
        return Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //chak No.
                    Container(
                        height: 60,
                        width: 85,
                        child: Center(
                          child: Text(item.chakNo!.toString(),
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        )),

                    ///Alarm Count
                    Container(
                      width: 70,
                      child: Center(
                        child: Text(item.description!.toString(),
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),

                    ///damage Count
                    Container(
                      width: 80,
                      child: Center(
                        child: _DisplayList![index].startTime!.length >= 19
                            ? Text(
                                _DisplayList![index]
                                        .startTime!
                                        .substring(0, 10)
                                        .split('-')
                                        .reversed
                                        .join('-') +
                                    "\n" +
                                    _DisplayList![index]
                                        .startTime!
                                        .substring(11),
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              )
                            : Container(),
                      ),
                    ),
                  ],
                ),
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
  }

  int _page = 0;
  int _limit = 15;

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
          'http://wmsservices.seprojects.in/api/Project/OmsActiveAlarm?Search=$_search&_aid=All&_did=All&_DeviceType=$devicetype&pageIndex=$_page&pageSize=$_limit&conString=$conString'));

      print(
          'http://wmsservices.seprojects.in/api/Project/OmsActiveAlarm?Search=$_search&_aid=All&_did=All&_DeviceType=$devicetype&pageIndex=$_page&pageSize=$_limit&conString=$conString');

      var json = jsonDecode(res.body);
      List<ActiveAlarmMasterModel> fetchedData = <ActiveAlarmMasterModel>[];
      json.forEach(
          (e) => fetchedData.add(new ActiveAlarmMasterModel.fromJson(e)));
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
            'http://wmsservices.seprojects.in/api/Project/OmsActiveAlarm?Search=$_search&_aid=All&_did=All&_DeviceType=$devicetype&pageIndex=$_page&pageSize=$_limit&conString=$conString'));
        var json = jsonDecode(res.body);
        List<ActiveAlarmMasterModel> fetchedData = <ActiveAlarmMasterModel>[];
        json.forEach(
            (e) => fetchedData.add(new ActiveAlarmMasterModel.fromJson(e)));
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

  // getpop(context) {
  //   return showDialog(
  //     barrierDismissible: false,
  //     useSafeArea: false,
  //     context: context,
  //     builder: (ctx) => Container(
  //       child: Center(
  //         child: CircularProgressIndicator(),
  //       ),
  //     ),
  //   );
  // }

}
