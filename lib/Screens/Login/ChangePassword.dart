// ignore_for_file: unused_field, unused_catch_stack

import 'package:WMS_Application/Model/Project/ChangePasswordMasterModel.dart';
import 'package:WMS_Application/Operations/LoginOperation.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/core/app_export.dart';
import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController UsenameController = TextEditingController();
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  bool _isObscure = true;
  bool _isVisible = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawerScreen(),
        appBar: AppBar(
          title: Text(
            "CHNAGE PASSWORD",
            textScaleFactor: 1,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.lightBlue),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(image: backgroundImage),
          height: size.height,
          width: size.width,
          child: Center(
              child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      ///Mobile Number TextFiled
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: getVerticalSize(50)),
                        child: Container(
                          height: getVerticalSize(
                            52.00,
                          ),
                          width: size.width,
                          child: TextFormField(
                            controller: UsenameController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter mobile no';
                              } else if (value.length < 10) {
                                return 'Please enter valid number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              UsenameController.text = value!;
                            },
                            decoration: InputDecoration(
                              hintText: 'Mobile No.',
                              hintStyle: TextStyle(
                                fontSize: getFontSize(
                                  13.0,
                                ),
                                color: ColorConstant.gray600,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    15.00,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConstant.green900,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    15.00,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConstant.green900,
                                  width: 1,
                                ),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  20.00,
                                ),
                                top: getVerticalSize(
                                  19.11,
                                ),
                                bottom: getVerticalSize(
                                  19.11,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: ColorConstant.gray600,
                              fontSize: getFontSize(
                                13.0,
                              ),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      ///Old Password TextFiled
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: getVerticalSize(10)),
                        child: Container(
                          height: getVerticalSize(
                            52.00,
                          ),
                          width: size.width,
                          child: TextFormField(
                            controller: oldpasswordController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            onSaved: (value) {
                              oldpasswordController.text = value!;
                            },
                            decoration: InputDecoration(
                              hintText: 'Old Password',
                              hintStyle: TextStyle(
                                fontSize: getFontSize(
                                  13.0,
                                ),
                                color: ColorConstant.gray600,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    15.00,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConstant.green900,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    15.00,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConstant.green900,
                                  width: 1,
                                ),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  20.00,
                                ),
                                top: getVerticalSize(
                                  19.11,
                                ),
                                bottom: getVerticalSize(
                                  19.11,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: ColorConstant.gray600,
                              fontSize: getFontSize(
                                13.0,
                              ),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      ///New Password TextFiled
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: getVerticalSize(10),
                            bottom: 20),
                        child: Container(
                          height: getVerticalSize(
                            52.00,
                          ),
                          width: size.width,
                          child: TextFormField(
                            controller: newpasswordController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            onSaved: (value) {
                              newpasswordController.text = value!;
                            },
                            decoration: InputDecoration(
                              hintText: 'New Password',
                              hintStyle: TextStyle(
                                fontSize: getFontSize(
                                  13.0,
                                ),
                                color: ColorConstant.gray600,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    15.00,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConstant.green900,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    15.00,
                                  ),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConstant.green900,
                                  width: 1,
                                ),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  20.00,
                                ),
                                top: getVerticalSize(
                                  19.11,
                                ),
                                bottom: getVerticalSize(
                                  19.11,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: ColorConstant.gray600,
                              fontSize: getFontSize(
                                13.0,
                              ),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      ///Change Password Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 90),
                        child: InkWell(
                          onTap: () async {
                            try {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              String? mobileNumber =
                                  preferences.getString('mobileno');
                              String? oldPassword =
                                  preferences.getString('Password');
                              if (UsenameController.text == mobileNumber &&
                                  oldpasswordController.text == oldPassword) {
                                // print('Old Details Matched');
                                ChangePasswordMasterModel? data =
                                    await chnagePassword(
                                  UsenameController.text.toString(),
                                  oldpasswordController.text.toString(),
                                  newpasswordController.text.toString(),
                                );
                                if (data != null) {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.setString(
                                      'Password', newpasswordController.text);
                                  print(data.response.toString());
                                }
                              } else {
                                print('Password Not Matched');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Wrong Cradentials ",
                                        textScaleFactor: 1,
                                      ),
                                    ],
                                  )),
                                );
                              }

                              /* else {
                                // ignore: avoid_print
                                print("Something went wrong");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Enter Cradentials ",
                                        textScaleFactor: 1,
                                      ),
                                    ],
                                  )),
                                );
                              }*/
                            } catch (_, ex) {}
                          },
                          child: Container(
                              width: size.width,
                              height: 50,
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
                                      ColorConstant.cyan301,
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                  child: Text(
                                "Change Password",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ))),
                        ),
                      )
                    ],
                  ))),
        ));
  }
}
