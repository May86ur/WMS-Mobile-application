import 'dart:convert';
import 'package:WMS_Application/Model/AreaModel.dart';
import 'package:WMS_Application/Model/DistibutoryModel.dart';
import 'package:WMS_Application/Model/Project/AmsMasterModelSql.dart';
import 'package:WMS_Application/Model/Project/AMSOverviewModel.dart';

import 'package:WMS_Application/Operations/StateselectionOperation.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';

import 'package:WMS_Application/styles.dart';
import 'package:http/http.dart' as http;

import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/app_export.dart';

String? amsStatus_check = 'All', DamageStatus_check = 'All', ListStatus = 'All';
AreaModel? modelArea;
DistibutroryModel? modelDistributary;

class AMSTrendScreenSql extends StatefulWidget {
  AMSTrendScreenSql(
      {Key? key,
      AreaModel? area_,
      DistibutroryModel? dist_,
      String? AmsStatus_Check_,
      String? DamageStatus_check_,
      String? ListStatus_})
      : super(key: key) {
    modelArea = area_;
    modelDistributary = dist_;
    amsStatus_check = AmsStatus_Check_;
    DamageStatus_check = DamageStatus_check_;
    ListStatus = ListStatus_;
  }

  @override
  State<AMSTrendScreenSql> createState() => _AMSTrendScreenSqlState();
}

class _AMSTrendScreenSqlState extends State<AMSTrendScreenSql> {
  final myController = TextEditingController();

  List<AmsMasterModelSql>? _DisplayList = <AmsMasterModelSql>[];

  List<DesignPressure>? _Design = [];

  List<ActualPressure>? _Actual = [];

  var cheklist = ['All'];
  String? _search = '';
  var area = 'All';
  var distibutory = 'ALL';

  AreaModel? selectedArea;
  DistibutroryModel? selectedDistributory;

  List<Ams_Overview_Model>? PopupModelList;

/*  List<DesignPressure> getDesignPress({List<AmsMasterModelSql>? list}) {
    final List<DesignPressure> chartData = [];
    list!.reverse().forEach((element) {
      chartData.add(new DesignPressure(element.amsId!, element.amsNo.toString(),
          element.designPressure ?? 0.0));
    });

    return chartData;
  }

  List<ActualPressure> getActuallPress({List<AmsMasterModelSql>? list}) {
    var maxPressure = 100;
    final List<ActualPressure> chartData2 = [];
    list!.reverse().forEach((element) {
      chartData2.add(new ActualPressure(
          element.amsId!,
          element.amsNo.toString(),
          element.designPressure != null
              ? element.designPressure * maxPressure / 100
              : 0.0));
    });

    return chartData2;
  }*/

  getDesignPress_new(List<AmsMasterModelSql>? list) {
    final List<DesignPressure> chartData = [];
    list!.reverse().forEach((element) {
      chartData.add(new DesignPressure(element.amsId!, element.amsNo.toString(),
          element.designPressure1 ?? 0.0));
    });
    setState(() {
      _Design = chartData;
    });
  }

  getActuallPress_new(List<AmsMasterModelSql>? list) {
    var maxPressure = 100;
    final List<ActualPressure> chartData2 = [];
    list!.reverse().forEach((element) {
      chartData2.add(new ActualPressure(
          element.amsId!,
          element.amsNo.toString(),
          element.actualPressure != null
              ? element.actualPressure ?? 0 * maxPressure / 100
              : 0.0));
    });
    setState(() {
      _Actual = chartData2;
    });
  }

  int _page = 0;
  int _limit = 5;

  Future<List<AmsMasterModelSql>> getAMSMasterData(
      String search_, String area_, String distri_, int page_) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //int? userid = preferences.getInt('userid');
    String? conString = preferences.getString('conString');
    //String? project = preferences.getString('project');
    String? liststatus = cheklist.join(',');
    final res = await http.get(Uri.parse(
        'http://wmsservices.seprojects.in/api/AMS/AMSDisplayList?Search=$search_&_aid=$area_&_did=$distri_&_AMSStatus=$amsStatus_check&_DamageStatus=$DamageStatus_check&_ListStatus=$liststatus&pageIndex=$page_&pageSize=$_limit&conString=$conString'));

    print(
        'http://wmsservices.seprojects.in/api/AMS/AMSDisplayList?Search=$search_&_aid=$area_&_did=$distri_&_AMSStatus=$amsStatus_check&_DamageStatus=$DamageStatus_check&_ListStatus=$liststatus&pageIndex=$page_&pageSize=$_limit&conString=$conString');

    var json = jsonDecode(res.body);
    List<AmsMasterModelSql> fetchedData = <AmsMasterModelSql>[];
    json.forEach((e) => fetchedData.add(new AmsMasterModelSql.fromJson(e)));
    getActuallPress_new(fetchedData);
    getDesignPress_new(fetchedData);
    setState(() {
      _DisplayList = fetchedData;
    });

    return fetchedData;
  }

  late TooltipBehavior _tooltipBehavior;
  bool isAlwaysShowToolTip = true;
  @override
  void initState() {
    super.initState();

    _tooltipBehavior = TooltipBehavior(
        animationDuration: 1,
        duration: 1, // color: Colors.blue,
        elevation: 5,
        opacity: 0.0,
        enable: true,
        builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
            int seriesIndex) {
          int amsId = data.AmsId!;

          return getPopupWidget(
              _DisplayList!.singleWhere((element) => element.amsId == amsId));
        });

    setState(() {
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
      _Design = [];
      _DisplayList = [];
      _Actual = [];

      //_Design = getDesignPress();
    });

    getDropDownAsync().whenComplete(() {
      GetOmsOverviewModel();
    });
  }

  getPopupWidget(AmsMasterModelSql model, {bool? AxisTapped = false}) {
    return Container(
      height: 230,
      width: size.width * 0.70,
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(),
                  Center(
                      child: Text(
                    "AMS Details",
                    textScaleFactor: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
                  _getCloseButton(context, IsAxisTapped: AxisTapped),
                ],
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "AMS No : ",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      // '0',

                      model.amsNo.toString(), textScaleFactor: 1,

                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),

                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Solar Voltage : ",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      // '0',
                      (model.solarVoltage ?? 0.0).toString() + " V",
                      textScaleFactor: 1,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Battery Voltage : ",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      (model.batteryLevel ?? 0.0).toString() + " V",
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: ((model.batteryLevel ?? 0.0) < 17
                              ? Colors.red
                              : Colors.green),
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Door : ",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      (model.dI1 == 1 || model.dI2 == 1 ? "OPEN" : "CLOSE"),
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 10,
                          color: (model.dI1 == 1 || model.dI2 == 1
                              ? Colors.red
                              : Colors.green),
                          // color: Colors.green,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Communication Status : ",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      model.isconnected == 1 ? "ONLINE" : "OFFLINE",
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: (model.isconnected == 1
                              ? Colors.green
                              : Colors.red),
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Last Response Time : ",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                    model.lastResponseTime1 != null
                        ? Expanded(
                            child: Text(
                              getlongDate(model.lastResponseTime1.toString()),
                              softWrap: true,
                              style: TextStyle(fontSize: 10),
                            ),
                          )
                        : Text(" Never Connected",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ]),
          ),
        )
      ]),
    );
  }

  getlongDate(String date) {
    final DateTime now = DateTime.parse(date);
    final DateFormat formatter = DateFormat('EEEE, d MMMM y H:m:s');
    final String formatted = formatter.format(now);
    print(formatted); // something like 2013-04-20
    return formatted;
  }

  @override
  void dispose() {
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
              _DisplayList = <AmsMasterModelSql>[];

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
          var distriFuture = getAMSDistibutoryid(
              areaId: data.areaid == 0 ? 'All' : data.areaid.toString());
          if (modelDistributary == null)
            await distriFuture.then((value) => setState(() {
                  selectedDistributory = value.first;
                  distibutory = "All";
                }));

          setState(() {
            _page = 0;
            _DisplayList = <AmsMasterModelSql>[];

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
      futureDistributory = getAMSDistibutoryid();
    });
  }

  Future<List<AmsMasterModelSql>>? futureAMSTrendData;
  Future<void> getAMSFutureData() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    setState(() {
      futureAMSTrendData = getAMSMasterData(_search!, area, distibutory, _page);
      ;
    });
    await Future.delayed(Duration(seconds: 2))
        .whenComplete(() => Navigator.pop(context));
  }

  Future<List<Ams_Overview_Model>>? OmsListFuture;
  List<Ams_Overview_Model>? OmsOverviewList = [];
  Future<List<AmsMasterModelSql>>? DisplayListFuture;

  Future<void> GetOmsOverviewModel() async {
    try {
      if (selectedArea != null)
        setState(() {
          area = selectedArea!.areaid == 0
              ? 'All'
              : selectedArea!.areaid.toString();
        });

      if (selectedDistributory != null)
        setState(() {
          distibutory = selectedDistributory!.id == 0
              ? 'All'
              : selectedDistributory!.id.toString();
        });
      getAMSFutureData();
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
            title: const Text(
              "AMS TREND VIEW",
              textScaleFactor: 1,
            ),
            leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
            )),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
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
                  //Search bar
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
                                      _DisplayList = <AmsMasterModelSql>[];
                                      _Design = [];
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
                  //Area & Distibutoty
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ),
                  //Graph Page
                  FutureBuilder(
                      future: futureAMSTrendData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              height: size.height * 0.7,
                              child: SfCartesianChart(
                                selectionType: SelectionType.series,
                                tooltipBehavior: _tooltipBehavior,
                                onAxisLabelTapped: (args) {
                                  print('====================================');
                                  print(args.text);
                                  print(_DisplayList!
                                      .singleWhere((element) =>
                                          element.amsNo == args.text)
                                      .amsId);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Center(
                                            child: getPopupWidget(
                                                _DisplayList!.singleWhere(
                                                    (element) =>
                                                        element.amsNo ==
                                                        args.text),
                                                AxisTapped: true));
                                      });
                                  //                     return getPopupWidget(
                                  // _DisplayList!.singleWhere((element) => element.amsId == args.text));
                                  // print(_DisplayList!
                                  //     .singleWhere((element) =>
                                  //         element.amsNo == selectionArgs.text)
                                  //     .amsId);

                                  /*AMSDetails(
                                      context,
                                      _DisplayList!.singleWhere((element) =>
                                          element.amsNo == selectionArgs.text));*/
                                },
                                legend: Legend(
                                    overflowMode: LegendItemOverflowMode.wrap,
                                    isResponsive: true,
                                    isVisible: true,
                                    title: LegendTitle(text: "Description")),
                                enableAxisAnimation: true,
                                primaryXAxis: CategoryAxis(
                                    axisLabelFormatter:
                                        (AxisLabelRenderDetails args) {
                                      print(args.value);
                                      String text = args.text;
                                      TextStyle textStyle = TextStyle(
                                          color: getColor(_DisplayList!
                                              .elementAt(int.parse(
                                                  args.value.toString()))));

                                      return ChartAxisLabel(text, textStyle);
                                    },
                                    labelAlignment: LabelAlignment.center,
                                    labelPlacement:
                                        LabelPlacement.betweenTicks),
                                primaryYAxis: CategoryAxis(
                                    interval: 10,
                                    maximum: 150,
                                    title: AxisTitle(text: "Pressure(Meter)")),
                                series: <ChartSeries>[
                                  BarSeries<DesignPressure, String>(
                                    enableTooltip: true,
                                    legendIconType: LegendIconType.circle,
                                    name: "Design Pressure",
                                    color: Color.fromARGB(255, 100, 27, 21),
                                    dataSource: _Design!,
                                    xValueMapper:
                                        (DesignPressure designPress, _) =>
                                            designPress.amsNo,
                                    yValueMapper:
                                        (DesignPressure designPress, _) =>
                                            designPress.designPress,
                                    //dataLabelMapper: (ChartData data, _) => data.x,
                                    dataLabelMapper:
                                        (DesignPressure designPress, _) =>
                                            designPress.designPress
                                                .toStringAsFixed(2),
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),

                                    // width: 01,
                                    // spacing: 0.7
                                  ),
                                  BarSeries<ActualPressure, String>(
                                    enableTooltip: true,
                                    legendIconType: LegendIconType.circle,
                                    name: "Actual Pressure",
                                    color: Colors.yellow,
                                    dataSource: _Actual!,
                                    //onPointLongPress: ,
                                    xValueMapper:
                                        (ActualPressure actuallPressure, _) =>
                                            actuallPressure.continent,
                                    yValueMapper:
                                        (ActualPressure actuallPressure, _) =>
                                            actuallPressure.actualPress,

                                    dataLabelMapper:
                                        (ActualPressure actuallPressure, _) =>
                                            actuallPressure.actualPress
                                                .toStringAsFixed(2),
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true),

                                    // width: 01,
                                    // spacing: 0.7
                                  ),
                                ],
                              ),
                            ),
                          );
                        else if (snapshot.hasError)
                          return Center(
                              child: Text(
                            "No Data Found",
                            textScaleFactor: 1,
                          ));
                        else
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                      }),
                  //Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      width: size.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: (_page != 0)
                                  ? ElevatedButton(
                                      child: Text(
                                        "Previous",
                                        textScaleFactor: 1,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _page--;
                                        });
                                        getAMSFutureData();
                                      },
                                    )
                                  : Container(),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    child: Text(
                                      "Next",
                                      textScaleFactor: 1,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _page++;
                                      });
                                      getAMSFutureData();
                                    },
                                  )),
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
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

/*  AMSDetails(BuildContext context, AmsMasterModelSql? model) {
    return showDialog(
        barrierDismissible: false,
        useSafeArea: false,
        context: context,
        builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.85,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(),
                                  Center(
                                      child: Text(
                                    "AMS Details",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  _getCloseButton(context),
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Ams no:",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                // '0',

                                model!.amsNo.toString(),

                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),

                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Solar Voltage(V):",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                // '0',
                                (model.solarVoltage ?? 0.0).toString() + " V",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Battery Voltage(V):",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                (model.batteryLevel ?? 0.0).toString() + " V",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Door:",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                (model.dI1 == 1 || model.dI2 == 1
                                    ? "OPEN"
                                    : "CLOSE"),
                                style: TextStyle(
                                    fontSize: 10,
                                    color: (model.dI1 == 1 || model.dI2 == 1
                                        ? Colors.red
                                        : Colors.green),
                                    // color: Colors.green,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Communication Status:",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                model.oNLINE.toString(),
                                style: TextStyle(
                                    color: (model.oNLINE == 'ON'
                                        ? Colors.green
                                        : Colors.red),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                //(model!.lastResponseTime).toString()
                                "Last Response Time:",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                (model.lastResponseTime).toString(),
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          );
        });
  }
*/
  getColor(AmsMasterModelSql model) {
    try {
      if (model.isconnected == 0) {
        return Colors.red;
      } else {
        return Colors.green;
      }
    } catch (_, ex) {
      return Colors.red;
    }
  }

  _getCloseButton(context, {bool? IsAxisTapped = false}) {
    return Container(
      alignment: FractionalOffset.topRight,
      child: GestureDetector(
        child: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onTap: () {
          if (IsAxisTapped!)
            Navigator.pop(context);
          else {
            setState(() {
              isAlwaysShowToolTip = false;

              //isAlwaysShowToolTip = true;
            });
            _tooltipBehavior.hide();
          }
          // setState(() {
          //   isAlwaysShowToolTip = false;
          // });
        },
      ),
    );
  }
}

class DesignPressure {
  DesignPressure(this.AmsId, this.amsNo, this.designPress);
  final int AmsId;
  final String amsNo;
  final double designPress;
}

class ActualPressure {
  ActualPressure(this.AmsId, this.continent, this.actualPress);
  final int AmsId;
  final String continent;
  final double actualPress;
}
