import 'package:flutter/material.dart';
import 'package:WMS_Application/Model/Project/ProjectOverviewModel.dart';
import 'package:WMS_Application/core/app_export.dart';

// ignore: must_be_immutable
class Group80ItemWidget extends StatelessWidget {
  ProjectOverviewModel? model;
  Group80ItemWidget(ProjectOverviewModel? data) {
    model = data;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getVerticalSize(
        96.00,
      ),
      width: size.width,
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
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    ImageConstant.img62,
                    height: getVerticalSize(
                      46.00,
                    ),
                    width: getHorizontalSize(
                      55.00,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Active \nAlarm",
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
              crossAxisAlignment: CrossAxisAlignment.end,
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
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          model!.activeAlarms.toString(),
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
                /*Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (model!.noOfDC! >= 1)
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
                              color: (model!.dC1Status != 0
                                  ? Colors.green
                                  : Colors.red)),
                          child: Text(
                            "DC 1",
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
                    if (model!.noOfDC! >= 2)
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
                            color: (model!.dC2Status != 0
                                ? Colors.green
                                : Colors.red),
                          ),
                          child: Text(
                            "PS 2",
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
                    /*if (model!.noOfDC! >= 3)
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
                            color: (model!.dC2Status != 0
                                ? Colors.green
                                : Colors.red),
                          ),
                          child: Text(
                            "PS 3",
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
                    if (model!.noOfPS! >= 4)
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
                                ? Colors.green
                                : Colors.red),
                          ),
                          child: Text(
                            "PS 4",
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
                    if (model!.noOfPS! >= 5)
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
                                ? Colors.green
                                : Colors.red),
                          ),
                          child: Text(
                            "PS 5",
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
                    if (model!.noOfPS! >= 6)
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
                                ? Colors.green
                                : Colors.red),
                          ),
                          child: Text(
                            "PS 6",
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
                  */
                  ],
                ),
              */
              ],
            ),
          ),
        ],
      ),
    );
    /*Container(
      height: getVerticalSize(
        76.00,
      ),
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
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(
                top: getVerticalSize(
                  1.00,
                ),
              ),
              decoration: BoxDecoration(
                color: ColorConstant.whiteA700,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: ColorConstant.cyan301, width: 5))),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: getHorizontalSize(
                          15.00,
                        ),
                        top: getVerticalSize(
                          7.00,
                        ),
                        bottom: getVerticalSize(
                          11.00,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: getVerticalSize(
                                8.00,
                              ),
                              bottom: getVerticalSize(
                                3.00,
                              ),
                            ),
                            child: Image.asset(
                              //"assets/images/istockphoto-1271839132-612x612.jpg",
                              ImageConstant.img62,
                              height: getVerticalSize(
                                46.00,
                              ),
                              width: getHorizontalSize(
                                47.00,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(
                                10.00,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Active Alarm",
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
                                Row(
                                  children: [
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
                                            color: ColorConstant.cyan300),
                                        child: Text(
                                          model!.activeAlarms.toString(),
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
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //     left: getHorizontalSize(
                          //       80.00,
                          //     ),
                          //     top: getVerticalSize(
                          //       10.00,
                          //     ),
                          //     right: getHorizontalSize(
                          //       7.00,
                          //     ),
                          //     bottom: getVerticalSize(
                          //       33.00,
                          //     ),
                          //   ),
                          //   child: Container(
                          //       height: getVerticalSize(
                          //         21.00,
                          //       ),
                          //       width: getHorizontalSize(
                          //         12.00,
                          //       ),
                          //       child: IconButton(
                          //           onPressed: () {},
                          //           icon: Icon(
                          //             Icons.arrow_forward_ios,
                          //             color: Colors.cyan,
                          //             size: 50,
                          //           ))),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   height: getVerticalSize(
          //     76.00,
          //   ),
          //   width: getHorizontalSize(
          //     4.00,
          //   ),
          //   margin: EdgeInsets.only(
          //     right: getHorizontalSize(
          //       10.00,
          //     ),
          //   ),
          //   decoration: BoxDecoration(
          //     color: ColorConstant.cyan301,
          //   ),
          // ),
        ],
      ),
    )*/
  }
}
