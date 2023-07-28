import 'package:WMS_Application/Screens/OMS/Graphical_Screen_Sql.dart';
import 'package:flutter/material.dart';
import 'package:WMS_Application/Model/Project/ProjectOverviewModel.dart';
import 'package:WMS_Application/core/app_export.dart';

// ignore: must_be_immutable
class Group79aItemWidget extends StatelessWidget {
  ProjectOverviewModel? model;
  String? ProjectName;
  Group79aItemWidget(ProjectOverviewModel? data, String project) {
    ProjectName = project;
    model = data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getVerticalSize(
        98.00,
      ),
      width: getHorizontalSize(
        340.00,
      ),
      // margin: EdgeInsets.only(
      //   top: getVerticalSize(
      //     7.50,
      //   ),
      //   bottom: getVerticalSize(
      //     7.50,
      //   ),
      // ),
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
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    ImageConstant.img26901,
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
                    getWidgetName(ProjectName)
                    // ProjectName!.toLowerCase() == 'BISTAN'.toLowerCase()
                    //     ? 'Surge \nTank'
                    //     : "Delivery \nChamber "
                    ,
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(
                            model!.noOfDC.toString(),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
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
                              color: (model!.dC1Status != 0 ||
                                      model!.dC1AStatus != 0
                                  ? Colors.lightGreen
                                  : Colors.red),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              ProjectName!.toLowerCase().contains('lbc')
                                  ? 'DC-1A'
                                  : (getWidget(ProjectName) + "1")
                              // ProjectName!.toLowerCase() ==
                              //         'BISTAN'.toLowerCase()
                              //     ? "SG 1"
                              //     : "DC 1"
                              ,
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
                              color: (model!.dC2Status != 0 ||
                                      model!.dC1Btatus != 0
                                  ? Colors.lightGreen
                                  : Colors.red),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              ProjectName!.toLowerCase().contains('lbc')
                                  ? 'DC-1B'
                                  : (getWidget(ProjectName) + "2")
                              // ProjectName!.toLowerCase() ==
                              //         'BISTAN'.toLowerCase()
                              //     ? "SG 2"
                              //     : "DC 2"
                              ,
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
                      if (model!.noOfDC! >= 3)
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
                              color:
                                  ((ProjectName!.toLowerCase().contains('lbc')
                                          ? (model!.dC2Status != 0)
                                          : (model!.dc3Status != 0))
                                      ? Colors.lightGreen
                                      : Colors.red),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              ProjectName!.toLowerCase().contains('lbc')
                                  ? 'DC-2'
                                  : getWidget(ProjectName) + "3"
                              // ProjectName!.toLowerCase() ==
                              //         'BISTAN'.toLowerCase()
                              //     ? "SG 3"
                              //     : "DC 3"
                              ,
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
                      if (model!.noOfDC! >= 4)
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
                              ProjectName!.toLowerCase().contains('lbc')
                                  ? 'DC-3'
                                  : getWidget(ProjectName) + "4"
                              // ProjectName!.toLowerCase() ==
                              //         'BISTAN'.toLowerCase()
                              //     ? "SG 4"
                              //     : "DC 4"
                              ,
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
                      if (model!.noOfDC! >= 5)
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
                              getWidget(ProjectName) + "5"
                              // ProjectName!.toLowerCase() ==
                              //         'BISTAN'.toLowerCase()
                              //     ? "SG 5"
                              //     : "DC 5"
                              ,
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
                      if (model!.noOfDC! >= 6)
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
                              getWidget(ProjectName) + "6"
                              // ProjectName!.toLowerCase() ==
                              //         'BISTAN'.toLowerCase()
                              //     ? "SG 6"
                              //     : "DC 6"
                              ,
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
                          // width: getHorizontalSize(
                          //   46.00,
                          // ),
                          decoration: BoxDecoration(
                            color: (model!.dC1Status != 0
                                ? Colors.lightGreen
                                : Colors.red),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Text(
                              "DC 1A",
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
                          // width: getHorizontalSize(
                          //   46.00,
                          // ),
                          decoration: BoxDecoration(
                            color: (model!.dC2Status != 0
                                ? Colors.lightGreen
                                : Colors.red),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Text(
                              "DC 1B",
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
                    if (model!.noOfDC! >= 3)
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
                                ? Colors.lightGreen
                                : Colors.red),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "DC 3",
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
                    if (model!.noOfDC! >= 4)
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
                                ? Colors.lightGreen
                                : Colors.red),
                          ),
                          child: Text(
                            "DC 4",
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
                    if (model!.noOfDC! >= 5)
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
                          ),
                          child: Text(
                            "DC 5",
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
                    if (model!.noOfDC! >= 6)
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
                          ),
                          child: Text(
                            "DC 6",
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
              */
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getWidgetName(projectName) {
    if (ProjectName! == 'Garoth' || ProjectName! == 'Mohanpura') {
      return 'BPT';
    } else if (ProjectName! == 'Bistan') {
      return 'Surge \nTank';
    } else {
      return 'Delivery \nChamber';
    }
  }

  String getWidget(projectName) {
    if (ProjectName! == 'Garoth' || ProjectName! == 'Mohanpura') {
      return 'BPT';
    } else if (ProjectName! == 'Bistan') {
      return 'ST';
    } else {
      return 'DC';
    }
  }
}
