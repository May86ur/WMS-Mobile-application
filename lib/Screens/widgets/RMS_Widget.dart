import 'package:flutter/material.dart';
import 'package:WMS_Application/Model/ProjectDataResponse.dart';
import 'package:WMS_Application/core/app_export.dart';

import '../../Model/Project/ProjectOverviewModel.dart';

// ignore: must_be_immutable
class Rms_widget extends StatefulWidget {
  ProjectOverviewModel? model;
  Rms_widget(ProjectOverviewModel? data) {
    model = data;
  }

  @override
  State<Rms_widget> createState() => _Rms_widgetState();
}

class _Rms_widgetState extends State<Rms_widget> {
  Future<List<ProjectDataResponse>>? project;

  List<ProjectDataResponse>? projectSelection;

  List<ProjectDataResponse>? projectList;

  Set<String>? stateList;


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
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        child: Image.asset(
                          ImageConstant.imgrms,
                          height: getVerticalSize(
                            46.00,
                          ),
                          width: getHorizontalSize(
                            47.00,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        "RMS",
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
                                30.00,
                              ),
                              width: getHorizontalSize(
                                56.00,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorConstant.cyan300,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  widget.model!.totalRms.toString(),
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
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                widget.model!.onlineRms.toString(),
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
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                widget.model!.offlineRms.toString(),
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
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  widget.model!.damageRms.toString(),
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
