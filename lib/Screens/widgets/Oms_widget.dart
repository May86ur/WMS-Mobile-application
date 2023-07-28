import 'package:flutter/material.dart';
import 'package:WMS_Application/core/app_export.dart';

import '../../Model/Project/ProjectOverviewModel.dart';

// ignore: must_be_immutable
class Group78ItemWidget extends StatelessWidget {
  ProjectOverviewModel? model;
  Group78ItemWidget(ProjectOverviewModel? data) {
    model = data;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: getVerticalSize(
                1.00,
              ),
            ),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorConstant.whiteA700,
              // border: Border(
              //   left: BorderSide(
              //     color: ColorConstant
              //         .cyan301, //ADDED BORDER COLOR INSTEAD OF CONTAINER
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
                ///Image
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        child: Image.asset(
                          ImageConstant.img51,
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
                            0.00,
                          ),
                        ),
                        child: Text(
                          "OMS",
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

                ///Counts
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
                                30.00,
                              ),
                              width: getHorizontalSize(
                                56.00,
                              ),
                              decoration: BoxDecoration(
                                  color: ColorConstant.cyan300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  model!.totalOms.toString(),
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
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //Online
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
                                30.00,
                              ),
                              width: getHorizontalSize(
                                56.00,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.lightGreen,
                              ),
                              child: Text(
                                model!.onlineOms.toString(),
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
                          //Offline
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
                                30.00,
                              ),
                              width: getHorizontalSize(
                                56.00,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                model!.offlineOms.toString(),
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
                          //Damage
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
                                30.00,
                              ),
                              width: getHorizontalSize(
                                56.00,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                model!.damageOms.toString(),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
