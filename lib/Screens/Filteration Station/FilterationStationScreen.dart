// ignore_for_file: must_be_immutable, non_constant_identifier_names, camel_case_types, unused_catch_stack, avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use

import 'dart:async';
import 'package:water_management_system/Model/FilterationDropdownModel.dart';
import 'package:water_management_system/Model/Project/FilterationMasterModel.dart';
import 'package:water_management_system/Operations/StateselectionOperation.dart';
import 'package:water_management_system/Screens/Login/MyDrawerScreen.dart';
import 'package:water_management_system/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterationStationScreen extends StatefulWidget {
  String? ProjectName;
  var Psid;
  FilterationStationScreen(String project, {super.key, var psid = 'All'}) {
    ProjectName = project;
    Psid = psid;
  }
  @override
  State<FilterationStationScreen> createState() =>
      _FilterationStationScreenState();
}

class _FilterationStationScreenState extends State<FilterationStationScreen> {
  Future<List<FiltrationDropDownModel>> getFiterDropdown() async {
    return getFiltername();
  }

  FiltrationDropDownModel? selectFilterId;
  int? pumpstation = 0;
  int pumpno = 0;

  @override
  void initState() {
    super.initState();
    getFiterDropdown().then((value) => setState(() {
          FilterDropDownList = value;
          selectFilterId = value.first;
          pumpstation = value.first.filterStationId;
          pumpno = FilterDropDownList!.length;
        }));
  }

  List<FiltrationDropDownModel>? FilterDropDownList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: const MyDrawerScreen(),
          appBar: AppBar(
              title: Text(
                "${widget.ProjectName!.toUpperCase()} - FILTRATION",
                textScaleFactor: 1,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(color: Colors.lightBlue),
              ),
              leading: BackButton(
                onPressed: () => Navigator.of(context).pop(),
              )),
          body: Container(
              decoration: BoxDecoration(image: backgroundImage),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: FilterDropDownList != null
                          ? getpumpidDropdown(context, FilterDropDownList!)
                          : const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  if (pumpstation != 0)
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Center(
                          child: Container(
                            child: FutureBuilder(
                              future: getfiltration(pumpstation!),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                try {
                                  if (snapshot.hasData) {
                                    try {
                                      var psData = snapshot.data
                                          as List<FilterationMasterModel>;
                                      if (selectFilterId!.fsPumpDPS != null) {
                                        try {
                                          // print(selectPumpStationId!.psPumpPT);
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.95,
                                            margin: const EdgeInsets.all(10.0),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                            ),
                                            child: Column(
                                              children: [
                                                ///Heading
                                                Container(
                                                  height: 40,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.95,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: (psData.first
                                                                      .devStatus ??
                                                                  0) !=
                                                              0
                                                          ? Colors.green
                                                          : Colors.red,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(12),
                                                              topRight: Radius
                                                                  .circular(
                                                                      12))),
                                                  child: Text(
                                                    '${selectFilterId!.fsName}',
                                                    textScaleFactor: 1,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),

                                                ///table data
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ///PS
                                                      if (psData
                                                          .where((e) => e
                                                              .tagName!
                                                              .contains(
                                                                  "FLT_1_DPS"))
                                                          .isNotEmpty)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 50,
                                                                child: Center(
                                                                  child: Text(
                                                                    "DPS :",
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
                                                                            const NeverScrollableScrollPhysics(),
                                                                        // padding:
                                                                        //     EdgeInsets
                                                                        //         .zero,
                                                                        shrinkWrap:
                                                                            true,
                                                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                            mainAxisExtent:
                                                                                45.0,
                                                                            mainAxisSpacing:
                                                                                0.0,
                                                                            crossAxisSpacing:
                                                                                0.0,
                                                                            crossAxisCount:
                                                                                5),
                                                                        itemCount: selectFilterId!
                                                                                .fsPumpDPS ?? //ps_pumpPS
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
                                                                              getLine1DPS(psData, i),
                                                                              FittedBox(
                                                                                child: Text(
                                                                                  "DPS $i",
                                                                                  textScaleFactor: 1,
                                                                                  style: const TextStyle(fontSize: 10),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                              )),
                                                            ],
                                                          ),
                                                        ),
                                                      if (psData
                                                          .where((e) => e
                                                              .tagName!
                                                              .contains(
                                                                  "FLT_1_INLET_OPN_LS")) //PS1_HD1_FLT_1_INLET_OPN_LS
                                                          .isNotEmpty)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 50,
                                                                child: Center(
                                                                  child: Text(
                                                                    " Filter Inlet Valve :",
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
                                                                            const NeverScrollableScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount:
                                                                                5),
                                                                        itemCount:
                                                                            (selectFilterId!.fsPumpDPS ??
                                                                                0),
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          var i =
                                                                              index + 1;
                                                                          return Column(
                                                                            children: [
                                                                              Image(
                                                                                image: AssetImage(getLine1ValveStatus(psData, i)),
                                                                                width: 30,
                                                                                height: 30,
                                                                              ),
                                                                              FittedBox(
                                                                                child: Text(
                                                                                  "V$i",
                                                                                  textScaleFactor: 1,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 11,
                                                                                  ),
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

                                                ///Last Response Time
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        const Text(
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
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : const Text(
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
                                          return const Center(
                                            child: Text(
                                              "No Data Found",
                                              textScaleFactor: 1,
                                            ),
                                          );
                                        }
                                      } else {
                                        return const Center(
                                          child: Text(
                                            'No Data Found',
                                            textScaleFactor: 1,
                                          ),
                                        );
                                      }
                                    } catch (_, Ex) {
                                      return const Center(
                                        child: Text(
                                          "No Data Found",
                                          textScaleFactor: 1,
                                        ),
                                      );
                                    }
                                  } else if (snapshot.hasError) {
                                    return (const Text(
                                      "No Data Found",
                                      textScaleFactor: 1,
                                    ));
                                  } else {
                                    return Center(
                                        child: Container(
                                      child: const CircularProgressIndicator(),
                                    ));
                                  }
                                } catch (_, ex) {
                                  return Center(
                                    child: Container(
                                        child:
                                            const CircularProgressIndicator()),
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
      BuildContext context, List<FiltrationDropDownModel> values) {
    try {
      selectFilterId ??= values.first;
      try {
        return Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 168, 211, 237),
              borderRadius: BorderRadius.circular(5)),
          child: DropdownButton(
            value: (values
                    .where((e) =>
                        e.filterStationId == selectFilterId!.filterStationId)
                    .isEmpty)
                ? values.first
                : selectFilterId!,
            underline: Container(color: Colors.transparent),
            isExpanded: true,
            items: values.map((FiltrationDropDownModel psid) {
              return DropdownMenuItem<FiltrationDropDownModel>(
                value: psid,
                child: Center(
                  child: Text(
                    psid.fsName!,
                    textScaleFactor: 1,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
            onChanged: (textvalue) {
              setState(() {
                selectFilterId = textvalue as FiltrationDropDownModel;
                pumpstation = selectFilterId!.filterStationId;
                //print("PumpStation Id:" + pumpstation.toString());
              });
            },
          ),
        );
      } catch (_, ex) {
        return const Center(
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

  String getLine1PumpStatus(List<FilterationMasterModel> model, int pmpIndex) {
    try {
      String OnStatus = (model
                  .where(
                      (i) => i.tagName!.contains('HD1_FLT_${pmpIndex}_MTR_ON'))
                  .isEmpty
              ? '0'
              : model
                  .singleWhere(
                      (i) => i.tagName!.contains('HD1_FLT_${pmpIndex}_MTR_ON'))
                  .data)
          .toString();
      String OfStatus = (model
                  .where((i) => i.tagName!.contains('HD1_FLT_${pmpIndex}_OFFB'))
                  .isEmpty
              ? '0'
              : model
                  .singleWhere(
                      (i) => i.tagName!.contains('HD1_FLT_${pmpIndex}_OFFB'))
                  .data)
          .toString();
      String FaultyStatus = (model
                  .where(
                      (i) => i.tagName!.contains('HD1_FLT_${pmpIndex}_MTR_TRP'))
                  .isEmpty
              ? '0'
              : model
                  .singleWhere(
                      (i) => i.tagName!.contains('HD1_FLT_${pmpIndex}_MTR_TRP'))
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

  String getLine2PumpStatus(List<FilterationMasterModel> model, int pmpIndex) {
    try {
      String OnStatus = (model
                  .where(
                      (i) => i.tagName!.contains('HD2_FLT_${pmpIndex}_MTR_ON'))
                  .isEmpty
              ? '0'
              : model
                  .singleWhere(
                      (i) => i.tagName!.contains('HD2_FLT_${pmpIndex}_MTR_ON'))
                  .data)
          .toString();
      String OfStatus = (model
                  .where((i) => i.tagName!.contains('HD2_FLT_${pmpIndex}_OFFB'))
                  .isEmpty
              ? '0'
              : model
                  .singleWhere(
                      (i) => i.tagName!.contains('HD2_FLT_${pmpIndex}_OFFB'))
                  .data)
          .toString();
      String FaultyStatus = (model
                  .where(
                      (i) => i.tagName!.contains('HD2_FLT_${pmpIndex}_MTR_TRP'))
                  .isEmpty
              ? '0'
              : model
                  .singleWhere(
                      (i) => i.tagName!.contains('HD2_FLT_${pmpIndex}_MTR_TRP'))
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

  getLine1DPS(List<FilterationMasterModel> model, int pmpIndex) {
    try {
      String OnStatus = (model
                  .where((i) => i.tagName!.contains('FLT_${pmpIndex}_DPS'))
                  .isEmpty
              ? '0'
              : model
                  .singleWhere(
                      (i) => i.tagName!.contains('FLT_${pmpIndex}_DPS'))
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
      return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey),
            color: Colors.red.shade900,
            borderRadius: BorderRadius.circular(50)),
        height: 25,
        width: 25,
      );
    }
  }

  String getLine1ValveStatus(List<FilterationMasterModel> model, int pmpIndex) {
    String OnStatus;
    try {
      OnStatus = (model
                  .singleWhere((i) => i.tagName!.contains(
                      'FLT_${pmpIndex}_INLET_OPN_LS')) //PS1_HD1_FLT_1_INLET_OPN_LS
                  .data ??
              '0')
          .toString();

      if (int.parse(OnStatus) == 1) {
        return "assets/images/greenfilter.png";
      } else {
        return 'assets/images/filter.png';
      }
    } catch (_, ex) {
      return "assets/images/filter.png";
    }
  }
}
