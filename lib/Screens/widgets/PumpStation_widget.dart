import 'package:flutter/material.dart';
import 'package:WMS_Application/core/app_export.dart';

import '../../Model/Project/ProjectOverviewModel.dart';

// ignore: must_be_immutable
class Group79ItemWidget extends StatelessWidget {
  ProjectOverviewModel? model;
  String? ProjectName;
  Group79ItemWidget(ProjectOverviewModel? data, String project) {
    ProjectName = project;
    model = data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getWidgetHeight(
          model!), //getVerticalSize(model!.pS6Status == null ? 100 : 196),
      width: getHorizontalSize(
        340.00,
      ),
      margin: EdgeInsets.only(
        top: getVerticalSize(
          7.50,
        ),
        bottom: getVerticalSize(
          7.50,
        ),
      ),

      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorConstant.whiteA700,
        // border: Border(
        //   left: BorderSide(
        //     color:
        //         ColorConstant.cyan301, //ADDED BORDER COLOR INSTEAD OF CONTAINER
        //     width: 5,
        //   ),
        // ),
        borderRadius: BorderRadius.circular(10),
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
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    ImageConstant.img4ce0c407a39b4,
                    height: getVerticalSize(
                      46.00,
                    ),
                    width: getHorizontalSize(
                      47.00,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Pump \nStation",
                    textScaleFactor: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorConstant.black900,
                      fontSize: getFontSize(
                        14,
                      ),
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
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //     left: getHorizontalSize(
                    //       10.00,
                    //     ),
                    //   ),
                    //   child:
                    // ),
                    //Total
                    Padding(
                      padding: EdgeInsets.only(
                        top: getVerticalSize(
                          8.00,
                        ),
                        right: getHorizontalSize(
                          10.00,
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: getVerticalSize(
                          27.00,
                        ),
                        width: getHorizontalSize(
                          46.00,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.cyan300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          model!.noOfPS.toString(),
                          textScaleFactor: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorConstant.black900,
                            fontSize: getFontSize(
                              16,
                            ),
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
                            if (model!.pS1Status != null)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: getVerticalSize(
                                    8.00,
                                  ),
                                  right: getHorizontalSize(
                                    10.00,
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: getVerticalSize(
                                    27.00,
                                  ),
                                  width: getHorizontalSize(
                                    46.00,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (model!.pS1Status != 0
                                        ? Colors.lightGreen
                                        : Colors.red),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "PS 1",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorConstant.black900,
                                      fontSize: getFontSize(
                                        16,
                                      ),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            if (model!.pS2Status != null)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: getVerticalSize(
                                    8.00,
                                  ),
                                  right: getHorizontalSize(
                                    10.00,
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: getVerticalSize(
                                    27.00,
                                  ),
                                  width: getHorizontalSize(
                                    46.00,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (model!.pS2Status != 0
                                        ? Colors.lightGreen
                                        : Colors.red),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    getPumpName(ProjectName!),
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorConstant.black900,
                                      fontSize: getFontSize(
                                        16,
                                      ),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            if (model!.pS3Status != null)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: getVerticalSize(
                                    8.00,
                                  ),
                                  right: getHorizontalSize(
                                    10.00,
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: getVerticalSize(
                                    27.00,
                                  ),
                                  width: getHorizontalSize(
                                    46.00,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (model!.pS3Status != 0
                                        ? Colors.lightGreen
                                        : Colors.red),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "PS 3",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorConstant.black900,
                                      fontSize: getFontSize(
                                        16,
                                      ),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            if (model!.pS4Status != null)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: getVerticalSize(
                                    8.00,
                                  ),
                                  right: getHorizontalSize(
                                    10.00,
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: getVerticalSize(
                                    27.00,
                                  ),
                                  width: getHorizontalSize(
                                    46.00,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (model!.pS4Status != 0
                                        ? Colors.lightGreen
                                        : Colors.red),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "PS 4",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ColorConstant.black900,
                                      fontSize: getFontSize(
                                        16,
                                      ),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Row(children: [
                          if (model!.pS5Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS5Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 5",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          if (model!.pS6Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS6Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 6",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          if (model!.pS7Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS7Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 7",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          if (model!.pS8Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS8Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 8",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                        ]),
                        Row(children: [
                          if (model!.pS9Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS9Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 9",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          if (model!.pS10Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS10Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 10",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          if (model!.pS11Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS11Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 11",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          if (model!.pS12Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS12Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 12",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
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
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS13Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 13",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          if (model!.pS14Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS14Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 14",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          if (model!.pS15Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS15Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 15",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          if (model!.pS16Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS16Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 16",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
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
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS17Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 17",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          if (model!.pS18Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.pS18Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 18",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          if (model!.ps19Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.ps19Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 19",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          if (model!.ps20Status != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  10.00,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: getVerticalSize(
                                  27.00,
                                ),
                                width: getHorizontalSize(
                                  46.00,
                                ),
                                decoration: BoxDecoration(
                                  color: (model!.ps20Status != 0
                                      ? Colors.lightGreen
                                      : Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "PS 20",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: getFontSize(
                                      16,
                                    ),
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
    px = 65.00 *
        (modelData.noOfPS! > 8 ? 4.8 : ((modelData.noOfPS! > 4 ? 3.4 : 2.55)));
    return px;
  }

  String getPumpName(projectName) {
    if (ProjectName! == 'Pachore') {
      return 'BPS ';
    } else {
      return 'PS 2';
    }
  }
}
