// ignore_for_file: unused_field, unused_local_variable, non_constant_identifier_names, camel_case_types, unused_catch_stack

import 'dart:async';
import 'dart:convert';
import 'package:WMS_Application/Model/SystemMonitoringModel.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/core/app_export.dart';
import 'package:WMS_Application/styles.dart';
import 'package:darq/darq.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SystemMonitoring_New extends StatefulWidget {
  @override
  State<SystemMonitoring_New> createState() => _SystemMonitoring_NewState();
}

String? _search = '';
String? selectedState = '';
String? selectedProject = '';
var loader;

// Initial Selected Value
var area = 'All';
var distibutory = 'ALL';

class _SystemMonitoring_NewState extends State<SystemMonitoring_New> {
  Future<List<SystemMonitoringModel>> getSMdata() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      int? userid = preferences.getInt('userid');
      final response = await http.get(Uri.parse(
          'http://wmsservices.seprojects.in/api/Project/SystemMonitoringData?userid=$userid'));

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        List<SystemMonitoringModel> SMList = <SystemMonitoringModel>[];
        json.forEach((e) => SMList.add(SystemMonitoringModel.fromJson(e)));
        var data = SMList;
        loader++;
        return data.toList();
      } else {
        throw Exception('Failed to Load API');
      }
    } catch (e) {
      throw Exception('Failed to load API');
    }
  }

  List<Widget> cards = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      StateList = new Set<String>();
      ProjectList = new Set<String>();
      _DistinctProjectList = new Set<String>();
      IsLoading = true;
      loader = 0;
      _search = '';
    });
    getSMList();
    Timer.periodic(Duration(seconds: 60), (Timer t) async {
      await getSMList();
    });
  }

  getState(BuildContext context, Set<String> values) {
    try {
      // Set<String> State = new Set<String>();
      return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 168, 211, 237),
            borderRadius: BorderRadius.circular(5)),
        child: DropdownButton(
          value: selectedState == null ||
                  (values.where((element) => element == selectedState))
                          .count() ==
                      0
              ? values.first
              : selectedState,
          underline: Container(color: Colors.transparent),
          isExpanded: true,
          items: values.map((String state) {
            return DropdownMenuItem<String>(
              value: state,
              child: Center(
                child: Text(
                  state,
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
            getpop(context);
            setState(() {
              selectedState = textvalue as String;
              selectedProject = 'ALL PROJECT';
            });
            SystemMonitorList = [];
            getSMList().whenComplete(
                () => new Future.delayed(new Duration(seconds: 2), () {
                      Navigator.pop(context); //pop dialog
                    }));
            // getpop(context);
            // getSMdata();
          },
        ),
      );
    } catch (_, ex) {
      print(ex);
      return Container();
    }
  }

  getProject(BuildContext context, Set<String> values) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 168, 211, 237),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButton(
        underline: Container(color: Colors.transparent),
        value: selectedProject == null ||
                (values.where((element) => element == selectedProject))
                        .count() ==
                    0
            ? values.first
            : selectedProject,
        isExpanded: true,
        items: values.map((String projectModel) {
          return DropdownMenuItem<String>(
            value: projectModel,
            child: Center(
              child: Text(
                projectModel,
                textScaleFactor: 1,
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        }).toList(),
        onChanged: (textvalue) async {
          getpop(context);
          setState(() {
            selectedProject = textvalue as String;
          });
          SystemMonitorList = [];
          getSMList().whenComplete(
              () => new Future.delayed(new Duration(seconds: 2), () {
                    Navigator.pop(context); //pop dialog
                  }));

          // futureSMList;
          // getSMdata();
        },
      ),
    );
  }

  getcolor(String date) {
    try {
      final serverTime = DateTime.parse(date);
      final currentTime = DateTime.now();
      final difference = currentTime.difference(serverTime).inMinutes;
      // print("Difference:" + difference.toString());
      if (difference <= 10) {
        return Colors.green;
      } else {
        return Colors.red[600];
      }
    } catch (_, ex) {
      return Colors.red[600];
    }
  }

  gethistorianstatus(String status) {
    try {
      if (status.contains('RUNNING')) {
        return Colors.green;
      } else {
        return Colors.red[600];
      }
    } catch (_, ex) {
      return Colors.red[600];
    }
  }

  Future getpop(context) async {
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

  Set<String>? StateList;
  Set<String>? ProjectList;
  Set<String>? _DistinctProjectList;
  List<SystemMonitoringModel>? SystemMonitorList;
  List<SystemMonitoringModel>? _OGSystemMonitorList;

  bool? IsLoading;

  Future<List<SystemMonitoringModel>>? futureSMList;
  Future<void> getSMList() async {
    var fList = getSMdata();

    setState(() {
      futureSMList = fList;

      try {
        futureSMList!.then((value) {
          StateList = new Set<String>();
          StateList!.add('ALL STATE');
          _OGSystemMonitorList = value;
          ProjectList = new Set<String>();
          _DistinctProjectList = new Set<String>();
          ProjectList!.add('ALL PROJECT');
          value
              .distinct((element) => element.state!)
              .forEach((element) => StateList!.add(element.state!));
          if (selectedState!.isNotEmpty && selectedState != 'ALL STATE')
            value
                .where((e) => e.state! == selectedState)
                .distinct((element) => element.projectName1!)
                .forEach((element) {
              ProjectList!.add(element.projectName1!);
              _DistinctProjectList!.add(element.projectName1!);
            });
          else
            value
                .distinct((element) => element.projectName1!)
                .forEach((element) {
              ProjectList!.add(element.projectName1!);
              _DistinctProjectList!.add(element.projectName1!);
            });

          if ((selectedState!.isNotEmpty && selectedState != 'ALL STATE') &&
              (selectedProject!.isNotEmpty && selectedProject != 'ALL PROJECT'))
            SystemMonitorList = _search!.isEmpty
                ? value
                    .where((e) =>
                        e.state == selectedState! &&
                        e.projectName1 == selectedProject!)
                    .toList()
                : value
                    .where((element) =>
                        (element.state == selectedState! &&
                            element.projectName1 == "ALL PROJECT") &&
                        (element.state!.toLowerCase().contains(_search!) ||
                            element.projectName1!
                                .toLowerCase()
                                .contains(_search!)))
                    .toList();
          else if (selectedState!.isNotEmpty && selectedState != 'ALL STATE')
            SystemMonitorList = _search!.isEmpty
                ? value.where((e) => e.state == selectedState!).toList()
                : value
                    .where((element) =>
                        (element.state == selectedState!) &&
                        (element.state!.toLowerCase().contains(_search!) ||
                            element.projectName1!
                                .toLowerCase()
                                .contains(_search!)))
                    .toList();
          else if (selectedProject!.isNotEmpty &&
              selectedProject != 'ALL PROJECT')
            SystemMonitorList = _search!.isEmpty
                ? value
                    .where((e) => e.projectName1 == selectedProject!)
                    .toList()
                : value
                    .where((element) =>
                        (element.projectName1 == selectedProject!) &&
                        (element.state!.toLowerCase().contains(_search!) ||
                            element.projectName1!
                                .toLowerCase()
                                .contains(_search!)))
                    .toList();
          else
            SystemMonitorList = _search!.isEmpty
                ? value
                : value
                    .where((element) =>
                        element.state!.toLowerCase().contains(_search!) ||
                        element.projectName1!.toLowerCase().contains(_search!))
                    .toList();
        }).whenComplete(() async {
          // print('Counter=' + (counter++).toString());
          IsLoading = false;

          await cardBuilder();
        }).onError((error, stackTrace) => loader == 0
            ? null /*showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Center(child: Text(error.toString())),
                  );
                })*/
            : null);
      } catch (_, ex) {}
    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  static int counter = 1;
  var newValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawerScreen(),
        appBar: AppBar(
          title: Text(
            "SYSTEM MONITORING",
            textScaleFactor: 1,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.lightBlue),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Container(
              decoration: BoxDecoration(image: backgroundImage),
              height: size.height,
              child: Column(children: [
/*                Stack(
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
                                    // if (value.isEmpty)
                                    //   // await futureSMList; //Function changed
                                    // await getSMList();
                                    // else
                                    setState(() {
                                      newValue = value;
                                    });
                                  },
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.go,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      hintText: "Search "),
                                ),
                              ),
                              IconButton(
                                splashColor: Colors.blue,
                                icon: Icon(Icons.search),
                                onPressed: () async {
                                  // getpop(context);
                                  // await futureSMList; //Function changed
                                  setState(() {
                                    _search = newValue;
                                  });
                                  SystemMonitorList = [];
                                  await getSMList();
                                  // await cardBuilder();
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
                //dropdown futureBuilder
                FutureBuilder(
                    future: futureSMList,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        try {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    height: 40,
                                    width: 180,
                                    child: getState(context, StateList!)),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                SizedBox(
                                    height: 40,
                                    width: 180,
                                    child: getProject(context, ProjectList!)),
                              ],
                            ),
                          );
                        } catch (_, ex) {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    }),

                //Main Body
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: cards,
                    ),
                  ),
                )
              ])),
        ));
  }

  Future<void> cardBuilder() async {
    int flag = 0;
    setState(() {
      cards = [];
    });

    if (selectedProject == 'ALL PROJECT' || selectedProject!.isEmpty) {
      ProjectList!.where((y) => y != 'ALL PROJECT').toSet().forEach((element) {
        setState(() {
          // print(element);
          var list = _OGSystemMonitorList!
              .where((e) => e.projectName1 == element)
              .toList();
          cards.add(getBody(
              ProjectList!.where((e) => e != 'ALL PROJECT').toSet(),
              flag,
              context,
              list));
          flag++;
        });
      });
    } else {
      ProjectList!
          .where((y) => y != 'ALL PROJECT' && y == selectedProject)
          .toSet()
          .forEach((element) {
        setState(() {
          print(element);
          for (var i = 0;
              i < ProjectList!.where((e) => e != 'ALL PROJECT').length;
              i++) {
            if (ProjectList!.where((e) => e != 'ALL PROJECT').elementAt(i) ==
                element) {
              flag = i;
              break;
            }
          }

          var list = _OGSystemMonitorList!
              .where((e) => e.projectName1 == element)
              .toList();
          cards.add(getBody(
              ProjectList!.where((e) => e != 'ALL PROJECT').toSet(),
              flag,
              context,
              list));
          flag++;
        });
      });
    }
    // if ((selectedState!.isNotEmpty && selectedState != 'ALL STATE') &&
    //     (selectedProject!.isNotEmpty && selectedProject != 'ALL PROJECT')) {
    //   ProjectList!.where((y) => y == _search).toSet().forEach((element) {
    //     setState(() {
    //       // print(element);
    //       var list = _OGSystemMonitorList!
    //           .where((e) => e.projectName1 == element)
    //           .toList();
    //       cards.add(getBody(
    //           ProjectList!.where((e) => e != 'ALL PROJECT').toSet(),
    //           flag,
    //           context,
    //           list));
    //       flag++;
    //     });
    //   });
    // } else if (selectedState!.isNotEmpty && selectedState != 'ALL STATE') {
    // } else if (selectedProject!.isNotEmpty &&
    //     selectedProject != 'ALL PROJECT') {
    // } else
    //   SystemMonitorList = _search!.isEmpty
    //       ? SystemMonitorList!
    //       : SystemMonitorList!
    //           .where((element) =>
    //               element.state!.toLowerCase().contains(_search!) ||
    //               element.projectName1!.toLowerCase().contains(_search!))
    //           .toList();
  }

  /*Widget getListViewBuilder(dynamic values) {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _DistinctProjectList!.length,
        itemBuilder: (BuildContext context, int index) {
          return getBody(
              _DistinctProjectList!,
              index,
              context,
              SystemMonitorList!
                  .where((element) =>
                      element.projectName1 ==
                      _DistinctProjectList!.elementAt(index))
                  .toList());
        });
  }
*/
  Widget getBody(Set<String> Monitoring, int index, BuildContext context,
      List<SystemMonitoringModel> list) {
    try {
      return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
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
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///Heading
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      // "Alirajpur",
                      Monitoring.elementAt(index).toUpperCase(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textScaleFactor: 1,
                    )),
                  ],
                ),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.cyan.shade300,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              ),

              ///Application Server
              Container(
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(width: 2))),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "APPLICATION SERVER   ",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: getcolor(
                                list.first.lastResponseTime!.toString(),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            height: 20,
                            width: 20,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 20,
                                child: Text(
                                  "Server Name:",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Container(
                                height: 20,
                                child: Text(
                                  "Server IP:",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Container(
                                height: 20,
                                child: Text(
                                  "CPU Usage:",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Container(
                                height: 20,
                                child: Text(
                                  "RAM Usage:",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Container(
                                height: 20,
                                child: Text(
                                  "DISC Usage:",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 150,
                                height: 20,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  list
                                      .singleWhere((e) =>
                                          e.description!
                                              .toLowerCase()
                                              .contains('server name') &&
                                          e.process!
                                              .toLowerCase()
                                              .contains('application server'))
                                      .value!,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: 20,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  list.first.hostIp!,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: 20,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  list
                                      .singleWhere((e) =>
                                          e.description!
                                              .toLowerCase()
                                              .contains('cpu usage') &&
                                          e.process!
                                              .toLowerCase()
                                              .contains('application server'))
                                      .value!,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: 20,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  list
                                      .singleWhere((e) =>
                                          e.description!
                                              .toLowerCase()
                                              .contains('used ram') &&
                                          e.process!
                                              .toLowerCase()
                                              .contains('application server'))
                                      .value!
                                      .replaceAll("GB", " GB"),
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 100,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  (list
                                              .singleWhere((e) =>
                                                  e.description!
                                                      .toLowerCase()
                                                      .contains(
                                                          'used storage') &&
                                                  e.process!
                                                      .toLowerCase()
                                                      .contains(
                                                          'application server'))
                                              .value!)
                                          .replaceAll("GB", " GB") +
                                      ' / ' +
                                      (list
                                              .singleWhere((e) =>
                                                  e.description!
                                                      .toLowerCase()
                                                      .contains(
                                                          'total storage') &&
                                                  e.process!
                                                      .toLowerCase()
                                                      .contains(
                                                          'application server'))
                                              .value!)
                                          .replaceAll("GB", " GB"),
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ///Historian Application
              Container(
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(width: 2))),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        // color: Color.fromARGB(255, 0, 255, 229),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "HISTORIAN APPLICATION",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // height: 60,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                // margin: EdgeInsets.only(top: 3),
                                alignment: Alignment.centerRight,
                                height: 20,
                                child: Text(
                                  "DISNET STATUS:",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              if (list
                                      .where((e) =>
                                          e.description!.toLowerCase().contains(
                                              "pump station status") &&
                                          e.process!.toLowerCase().contains(
                                              'historian application'))
                                      .length !=
                                  0)
                                Container(
                                  height: 20,
                                  child: Text(
                                    "PUMP STATION STATUS:",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  color: list
                                              .where((e) => e.process!
                                                  .toLowerCase()
                                                  .contains(
                                                      'historian application'))
                                              .length !=
                                          0
                                      ? gethistorianstatus(
                                          list
                                              .singleWhere((e) =>
                                                  e.description!
                                                      .toLowerCase()
                                                      .contains('status') &&
                                                  e.process!
                                                      .toLowerCase()
                                                      .contains(
                                                          'historian application'))
                                              .value!,
                                        )
                                      : Colors.red,
                                ),
                                // color: Colors.black,
                                height: 20,
                                width: 20,
                              ),
                              if (list
                                      .where((e) =>
                                          e.description!.toLowerCase().contains(
                                              "pump station status") &&
                                          e.process!.toLowerCase().contains(
                                              'historian application'))
                                      .length !=
                                  0)
                                Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    color: Colors.red,
                                    /*gradient: RadialGradient(colors: [
                                  list
                                              .where((e) => e.process!
                                                  .toLowerCase()
                                                  .contains(
                                                      'historian application'))
                                              .length !=
                                          0
                                      ? gethistorianstatus(
                                          list
                                              .singleWhere((e) =>
                                                  e.description!
                                                      .toLowerCase()
                                                      .contains('status') &&
                                                  e.process!
                                                      .toLowerCase()
                                                      .contains(
                                                          'historian application'))
                                              .value!,
                                        )
                                      : Colors.red,
                                  list
                                              .where((e) => e.process!
                                                  .toLowerCase()
                                                  .contains(
                                                      'historian application'))
                                              .length !=
                                          0
                                      ? gethistorianstatus(
                                          list
                                              .singleWhere((e) =>
                                                  e.description!
                                                      .toLowerCase()
                                                      .contains('status') &&
                                                  e.process!
                                                      .toLowerCase()
                                                      .contains(
                                                          'historian application'))
                                              .value!,
                                        )
                                      : Colors.red,
                                  Colors.white
                                ]),*/
                                  ),
                                  // color: Colors.black,
                                  height: 20,
                                  width: 20,
                                )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ///MQTT Broker
              Container(
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(width: 2))),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        // color: Color.fromARGB(255, 0, 255, 229),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "MQTT BROKER",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // height: 60,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (_OGSystemMonitorList!
                                      .where((e) =>
                                          e.description!
                                              .toLowerCase()
                                              .contains("lora") &&
                                          e.process!
                                              .toLowerCase()
                                              .contains('mqtt status'))
                                      .length !=
                                  0)
                                Container(
                                  // margin: EdgeInsets.only(top: 3),
                                  alignment: Alignment.centerRight,
                                  height: 20,
                                  child: Text(
                                    "LORA:",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              if (_OGSystemMonitorList!
                                      .where((e) =>
                                          e.description!
                                              .toLowerCase()
                                              .contains("gsm") &&
                                          e.process!
                                              .toLowerCase()
                                              .contains('mqtt status'))
                                      .length !=
                                  0)
                                Container(
                                  // margin: EdgeInsets.only(top: 3),
                                  alignment: Alignment.centerRight,
                                  height: 20,
                                  child: Text(
                                    "GSM:",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (_OGSystemMonitorList!
                                      .where((e) =>
                                          e.description!
                                              .toLowerCase()
                                              .contains('lora') &&
                                          e.process!
                                              .toLowerCase()
                                              .contains('mqtt status'))
                                      .length !=
                                  0)
                                Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    color: gethistorianstatus(
                                      _OGSystemMonitorList!
                                          .singleWhere((e) =>
                                              e.description!
                                                  .toLowerCase()
                                                  .contains('lora') &&
                                              e.process!
                                                  .toLowerCase()
                                                  .contains('mqtt status'))
                                          .value!,
                                    ),
                                  ),
                                  // color: Colors.black,
                                  height: 20,
                                  width: 20,
                                ),
                              if (_OGSystemMonitorList!
                                      .where((e) =>
                                          e.description!
                                              .toLowerCase()
                                              .contains('gsm') &&
                                          e.process!
                                              .toLowerCase()
                                              .contains('mqtt status'))
                                      .length !=
                                  0)
                                Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    color: gethistorianstatus(
                                      _OGSystemMonitorList!
                                          .singleWhere((e) =>
                                              e.description!
                                                  .toLowerCase()
                                                  .contains('gsm') &&
                                              e.process!
                                                  .toLowerCase()
                                                  .contains('mqtt status'))
                                          .value!,
                                    ),
                                  ),
                                  // color: Colors.black,
                                  height: 20,
                                  width: 20,
                                )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Container(
              //   decoration:
              //       BoxDecoration(border: Border(bottom: BorderSide(width: 2))),
              //   width: MediaQuery.of(context).size.width,
              //   child: Column(
              //     children: [
              //       Container(
              //         height: 40,
              //         width: MediaQuery.of(context).size.width,
              //         // color: Color.fromARGB(255, 0, 255, 229),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               "MQTT Broker",
              //               textScaleFactor: 1,
              //               style: TextStyle(
              //                   fontSize: 14, fontWeight: FontWeight.bold),
              //             ),
              //             Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     color: Colors.green,
              //                     /* getcolor(
              //                       list
              //                                   .where((e) => e.process!
              //                                       .toLowerCase()
              //                                       .contains('mqtt broker'))
              //                                   .length !=
              //                               0
              //                           ? list
              //                               .singleWhere((e) =>
              //                                   e.description!
              //                                       .toLowerCase()
              //                                       .contains('server name') &&
              //                                   e.process!
              //                                       .toLowerCase()
              //                                       .contains('mqtt broker'))
              //                               .lastResponseTime!
              //                           : "",
              //                       // list.first.lastResponseTime!.toString(),
              //                     ),*/
              //                     // gradient: RadialGradient(colors: [
              //                     //   getcolor(
              //                     //     list.first.lastResponseTime!.toString(),
              //                     //   ),
              //                     //   getcolor(
              //                     //     list.first.lastResponseTime!,
              //                     //   ),
              //                     //   Colors.white,
              //                     // ]),
              //                     borderRadius:
              //                         BorderRadius.all(Radius.circular(5)),
              //                   ),
              //                   // color: Colors.black,
              //                   height: 20,
              //                   width: 20,
              //                 ))
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              ///LNS Server
              if (list
                      .where((e) =>
                          e.process!.toLowerCase().contains('lns server'))
                      .length !=
                  0)
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        // color: Color.fromARGB(255, 0, 255, 229),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "LNS SERVER   ",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: getcolor(
                                  list
                                              .where((e) => e.process!
                                                  .toLowerCase()
                                                  .contains('lns server'))
                                              .length !=
                                          0
                                      ? list
                                          .singleWhere((e) =>
                                              e.description!
                                                  .toLowerCase()
                                                  .contains('server name') &&
                                              e.process!
                                                  .toLowerCase()
                                                  .contains('lns server'))
                                          .lastResponseTime!
                                      : "",
                                  // list.first.lastResponseTime!.toString(),
                                ),
                                // gradient: RadialGradient(colors: [
                                //   getcolor(
                                //     list.first.lastResponseTime!.toString(),
                                //   ),
                                //   getcolor(
                                //     list.first.lastResponseTime!,
                                //   ),
                                //   Colors.white,
                                // ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              // color: Colors.black,
                              height: 20,
                              width: 20,
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width * 0.3,
                            // color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  // color: Colors.blueAccent,
                                  height: 20,
                                  // alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Server Name:",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  // color: Colors.blueAccent,
                                  height: 20,
                                  // alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Server IP:",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  // color: Colors.blueAccent,
                                  height: 20,
                                  // alignment: Alignment.centerLeft,
                                  child: Text(
                                    "CPU Usage:",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  // color: Colors.blueAccent,
                                  height: 20,
                                  // alignment: Alignment.centerLeft,
                                  child: Text(
                                    "RAM Usage:",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  // color: Colors.blueAccent,
                                  height: 20,
                                  // alignment: Alignment.centerLeft,
                                  child: Text(
                                    "DISC Usage:",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width * 0.3,
                            // color: Colors.yellow,
                            // color: Color.fromARGB(255, 151, 208, 255),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  // color: Colors.blueAccent,
                                  height: 20,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    list
                                                .where((e) => e.process!
                                                    .toLowerCase()
                                                    .contains('lns server'))
                                                .length !=
                                            0
                                        ? list
                                            .singleWhere((e) =>
                                                e.description!
                                                    .toLowerCase()
                                                    .contains('server name') &&
                                                e.process!
                                                    .toLowerCase()
                                                    .contains('lns server'))
                                            .value!
                                        : "",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  // color: Colors.blueAccent,
                                  height: 20,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    list
                                                .where((e) => e.process!
                                                    .toLowerCase()
                                                    .contains('lns server'))
                                                .length !=
                                            0
                                        ? list
                                            .singleWhere((e) =>
                                                e.description!
                                                    .toLowerCase()
                                                    .contains(
                                                        'system ip address') &&
                                                e.process!
                                                    .toLowerCase()
                                                    .contains('lns server'))
                                            .value!
                                        : " ",
                                    // list.first.hostIp!,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  // color: Colors.blueAccent,
                                  height: 20,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    list
                                                .where((e) => e.process!
                                                    .toLowerCase()
                                                    .contains('lns server'))
                                                .length !=
                                            0
                                        ? list
                                            .singleWhere((e) =>
                                                e.description!
                                                    .toLowerCase()
                                                    .contains('cpu usage') &&
                                                e.process!
                                                    .toLowerCase()
                                                    .contains('lns server'))
                                            .value!
                                        : " ",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  // color: Colors.blueAccent,
                                  height: 20,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    list
                                                .where((e) => e.process!
                                                    .toLowerCase()
                                                    .contains('lns server'))
                                                .length !=
                                            0
                                        ? list
                                            .singleWhere((e) =>
                                                e.description!
                                                    .toLowerCase()
                                                    .contains('used ram') &&
                                                e.process!
                                                    .toLowerCase()
                                                    .contains('lns server'))
                                            .value!
                                            .replaceAll("GB", " GB")
                                        : " ",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  // color: Colors.blueAccent,
                                  height: 20,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    list
                                                .where((e) => e.process!
                                                    .toLowerCase()
                                                    .contains('lns server'))
                                                .length !=
                                            0
                                        ? (list
                                                    .singleWhere((e) =>
                                                        e.description!
                                                            .toLowerCase()
                                                            .contains(
                                                                'used storage') &&
                                                        e.process!
                                                            .toLowerCase()
                                                            .contains(
                                                                'lns server'))
                                                    .value!)
                                                .replaceAll("GB", " GB") +
                                            ' / ' +
                                            (list
                                                    .singleWhere((e) =>
                                                        e.description!
                                                            .toLowerCase()
                                                            .contains('total storage') &&
                                                        e.process!.toLowerCase().contains('lns server'))
                                                    .value!)
                                                .replaceAll("GB", " GB")
                                        : " ",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      'Last Updated Time: ' +
                          DateFormat('E, d MMM yyyy HH:mm:ss').format(
                              DateTime.parse(list.first.lastResponseTime!)),
                      textScaleFactor: 1,
                    )),
                  ],
                ),
                height: 20,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
              ),
            ],
          ),
        ),
      );
    } catch (_, ex) {
      return Container(
          child: Center(
        child: Container(
            // height: 50,
            // width: size.width,
            ),
      ));
    }
  }
}
