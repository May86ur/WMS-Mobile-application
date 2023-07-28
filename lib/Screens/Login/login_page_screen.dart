// ignore_for_file: must_be_immutable, unused_field, non_constant_identifier_names, unused_catch_stack

import 'package:flutter/material.dart';
import 'package:WMS_Application/Model/LoginModel.dart';
import 'package:WMS_Application/Operations/LoginOperation.dart';
import 'package:WMS_Application/core/app_export.dart';
import 'package:WMS_Application/Screens/Login/State_List_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageScreen extends StatelessWidget {
  TextEditingController UsenameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isVisible = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/img_untitled11.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ///Company Logo
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(
                        54.00,
                      ),
                      top: getVerticalSize(50),
                      right: getHorizontalSize(
                        54.00,
                      ),
                    ),
                    child: Image.asset(
                      ImageConstant.imgLogoresize1,
                      height: getVerticalSize(
                        126.00,
                      ),
                      width: getHorizontalSize(
                        186.00,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Visibility(
                  visible: _isVisible,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Wrong credentials entered",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),

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

                ///Password TextFiled
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    height: getVerticalSize(
                      52.00,
                    ),
                    width: size.width,
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onSaved: (value) {
                        passwordController.text = value!;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
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

                ///Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: InkWell(
                    onTap: () async {
                      try {
                        print(UsenameController.text);
                        LoginModel? data = await fetchLoginDetails(
                          UsenameController.text.toString(),
                          passwordController.text.toString(),
                        );
                        if (data != null) {
                          print(data.fName!);
                          if (passwordController.text == data.pwd) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Processing ",
                                    textScaleFactor: 1,
                                  ),
                                  CircularProgressIndicator()
                                ],
                              )),
                            );
                            getpop(context, data);
                          } else {
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
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setString(
                              'mobileno', UsenameController.text);
                          preferences.setString('firstname', data.fName!);
                          preferences.setString('lastname', data.lName!);
                          preferences.setInt('userid', data.userid!);
                          preferences.setString('usertype', data.userType!);
                          preferences.setString('Password', data.pwd!);
                          //getpop(context, data.fName!);
                        } else {
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
                        }
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
                          "LOGIN",
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getpop(context, LoginModel? data) {
    return showDialog(
      barrierColor: Colors.black54,
      barrierDismissible: false,
      useSafeArea: false,
      context: context,
      builder: (ctx) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.cyan301,
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            width: size.width * 0.85,
            height: 300,
            child: Column(
              children: [
                ///image
                Container(
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: size.height * 0.15,
                  width: size.width * 0.5,
                  child: Image(
                    image: AssetImage(ImageConstant.img2068991),
                    // height: size.height * 0.15,
                    // width: size.width * 0.5,
                  ),
                ),
                // Welcome Text
                Container(
                  height: 100,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Welcome",
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data!.fName.toString(),
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: ColorConstant.whiteA700,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.userType.toString(),
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ]),
                ),

                ///Button
                Container(
                  width: size.width * 0.3,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.blue)))),
                      child: Text("OK",
                          textScaleFactor: 1,
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      onPressed: () async {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectsCategoryScreen()),
                          (Route<dynamic> route) => false,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    /*showDialog(
      barrierDismissible: false,
      useSafeArea: false,
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Center(
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.cyan301,
                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.center,
            width: size.width,
            height: 300,
            child: Column(
              children: [
                Container(
                  child: Image(
                    image: AssetImage(ImageConstant.img2068991),
                    height: size.height * 0.15,
                    width: size.width * 0.5,
                  ),
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  data!.fName.toString(),
                  style: TextStyle(
                      color: ColorConstant.whiteA700,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  data.userType.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),

                ///Button
                Container(
                  width: size.width * 0.3,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.blue)))),
                      child: Text("OK",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProjectsCategoryScreen()));
                      }),
                ),
              ],
            ),
          ),
        ),
        // actions: <Widget>[
        //   // ignore: deprecated_member_use
        //   FlatButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => ProjectsCategoryScreen()));
        //       //Navigator.of(ctx).pop();
        //     },
        //     child: Text("okay"),
        //   ),
        // ],
      ),
    );*/
  }
}
