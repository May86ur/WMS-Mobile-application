// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:WMS_Application/Screens/Login/login_page_screen.dart';
import 'package:WMS_Application/Screens/Login/State_List_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawerScreen extends StatefulWidget {
  @override
  State<MyDrawerScreen> createState() => _MyDrawerScreenState();
}

class _MyDrawerScreenState extends State<MyDrawerScreen> {
  String usertype = '';
  String usename = '';
  @override
  void initState() {
    super.initState();
    getUsertype();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: <Color>[Colors.green, Colors.blue])),
              child: Center(
                child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(150.0)),
                    child: Image.asset(
                      'assets/images/img_2068991.png',
                      height: 150,
                      width: 150,
                    )),
              )),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text("WATER MONITORING SYSTEM",
                    textScaleFactor: 1,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 3.0, 0.0, 0.0),
                child: Text(
                  'WMS Mobile Application',
                  textScaleFactor: 1,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 3.0, 0.0, 0.0),
                child: Text('App Version-v1.6.5',
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                child: Text(usename,
                    textScaleFactor: 1,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
          //Process Monitoring

          ListTile(
            leading: ImageIcon(
              AssetImage("assets/images/monitor.png"),
              //  color: Color(0xFF3A5A98),
            ),
            title: Text(
              'PROCESS MONITORING',
              textScaleFactor: 1,
            ),
            // trailing: Icon(
            //   Icons.arrow_right_sharp,
            //   color: Colors.green,
            //   size: 20,
            // ),
            onTap: (() {
              // Navigator.popAndPushNamed(context, '/firstScreen');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => ProjectsCategoryScreen()),
                (Route<dynamic> route) => false,
              );
            }),
          ),
          Divider(),

          //System Monitoring
          if (!usertype.toLowerCase().contains('client')) //
            ListTile(
              leading: ImageIcon(
                AssetImage("assets/images/system_monitering_new.png"),
                //  color: Color(0xFF3A5A98),
              ),
              title: Text(
                'SYSTEM MONITORING',
                textScaleFactor: 1,
              ),
              // trailing: Icon(
              //   Icons.arrow_right_sharp,
              //   color: Colors.green,
              //   size: 20,
              // ),
              onTap: (() {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => SystemMonitoring()),
                //   (Route<dynamic> route) => false,
                // );
                Navigator.popAndPushNamed(context, '/secondScreen');
                // pushReplacement(context, MaterialPageRoute(builder: ((context) => SystemMonitoring())));
                // push(context, MaterialPageRoute(builder: (context) => SystemMonitoring()));
              }),
            ),
          if (!usertype.toLowerCase().contains('client')) Divider(),
          //System Monitoring

          ListTile(
            leading: ImageIcon(
              AssetImage("assets/images/pumpstation.png"),
              //  color: Color(0xFF3A5A98),
            ),
            title: Text(
              'PS MONITORING',
              textScaleFactor: 1,
            ),
            onTap: (() {
              Navigator.popAndPushNamed(context, '/fourthScreen');
            }),
          ),
          Divider(),

          //Add New User
          if (!usertype.toLowerCase().contains('client')) //_Clinet
            ListTile(
              leading: ImageIcon(
                AssetImage("assets/images/add-friend.png"),
              ),
              title: Text(
                'ADD NEW USER',
                textScaleFactor: 1,
              ),
              onTap: (() {
                
              }),
            ),
          if (!usertype.toLowerCase().contains('client')) Divider(),

          //Change Password
          ListTile(
            leading: ImageIcon(
              AssetImage("assets/images/password.png"),
              //  color: Color(0xFF3A5A98),
            ),
            title: Text(
              'CHANGE PASSWORD',
              textScaleFactor: 1,
            ),
            onTap: (() {
              Navigator.popAndPushNamed(context, '/thirdScreen');
            }),
          ),
          Divider(),
          //Logout
          ListTile(
              leading: ImageIcon(
                AssetImage("assets/images/log-out.png"),
                //  color: Color(0xFF3A5A98),
              ),
              title: Text(
                'LOGOUT',
                textScaleFactor: 1,
              ),
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPageScreen()),
                  (Route<dynamic> route) => false,
                );
              }),
        ],
      ),
    );
  }

  getUsertype() {
    try {
      setState(() async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        usertype = preferences.getString('usertype')!;
        usename = preferences.getString('firstname')!;
      });
    } catch (_, e) {
      print(e);
    }
  }
}
