// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:water_management_system/Model/Project/ProjectOverviewModel.dart';

// ignore: must_be_immutable
class FiltrationWidget extends StatelessWidget {
  ProjectOverviewModel? model;
  FiltrationWidget(ProjectOverviewModel? data, {super.key}) {
    model = data;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      child: SizedBox(
        height: getWidgetHeight(model!),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Image.asset(
                        'assets/images/FilterTank.png',
                        height: 46.00,
                        width: 55.00,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        " Primary \nFiltration \nSystem",
                        textScaleFactor: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //Total
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.00,
                            right: 10.00,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 27.00,
                            width: 46.00,
                            decoration: BoxDecoration(
                              color: Colors.cyan.shade300,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              model!.noOfFilter.toString(),
                              textScaleFactor: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                if (model!.f1Status != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.00,
                                      right: 10.00,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 27.00,
                                      width: 46.00,
                                      decoration: BoxDecoration(
                                        color: (model!.f1Status != 0
                                            ? Colors.lightGreen
                                            : Colors.red),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Text(
                                        "FL 1",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (model!.f2Status != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.00,
                                      right: 10.00,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 27.00,
                                      width: 46.00,
                                      decoration: BoxDecoration(
                                        color: (model!.f2Status != 0
                                            ? Colors.lightGreen
                                            : Colors.red),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        "FL 2",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (model!.f3Status != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.00,
                                      right: 10.00,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 27.00,
                                      width: 46.00,
                                      decoration: BoxDecoration(
                                        color: (model!.f3Status != 0
                                            ? Colors.lightGreen
                                            : Colors.red),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Text(
                                        "FL 3",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (model!.f4Status != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.00,
                                      right: 10.00,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 27.00,
                                      width: 46.00,
                                      decoration: BoxDecoration(
                                        color: (model!.f4Status != 0
                                            ? Colors.lightGreen
                                            : Colors.red),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Text(
                                        "FL 4",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Row(children: [
                              if (model!.f5Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.f5Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 5",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              if (model!.f6Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.f6Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 6",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              if (model!.f7Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.f7Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 7",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              if (model!.f8Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.f8Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 8",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                            ]),
                            Row(children: [
                              if (model!.f9Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.f9Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 9",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              if (model!.pS10Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.pS10Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 10",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              if (model!.pS11Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.pS11Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 11",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              if (model!.pS12Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.pS12Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 12",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                            ]),
                            Row(children: [
                              if (model!.pS13Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.pS13Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 13",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              if (model!.pS14Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.pS14Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 14",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              if (model!.pS15Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.pS15Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 15",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              if (model!.pS16Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.pS16Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 16",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                            ]),
                            Row(children: [
                              if (model!.pS17Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.pS17Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 17",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              if (model!.pS18Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.pS18Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 18",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              if (model!.ps19Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.ps19Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 19",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              if (model!.ps20Status != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.00,
                                    right: 10.00,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 27.00,
                                    width: 46.00,
                                    decoration: BoxDecoration(
                                      color: (model!.ps20Status != 0
                                          ? Colors.lightGreen
                                          : Colors.red),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      "FL 20",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getWidgetHeight(ProjectOverviewModel modelData) {
    double px;
    // if (modelData.pS13Status != null) {
    //   px = 260.00;
    // } else if (modelData.pS9Status != null) {
    //   px = 210.00;
    // } else if (modelData.pS5Status != null) {
    //   px = 160.00;
    // } else {
    //   px = 125.00;
    // }
    px = 70.00 *
        (modelData.noOfPS! > 8 ? 3.3 : ((modelData.noOfPS! > 4 ? 1.9 : 1.8)));
    return px;
  }
}
