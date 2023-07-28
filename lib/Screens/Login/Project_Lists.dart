// ignore_for_file: must_be_immutable, unused_local_variable, non_constant_identifier_names
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';
import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:WMS_Application/Model/Project/State_list_Model.dart';
import 'package:WMS_Application/Operations/StateselectionOperation.dart';
import 'package:WMS_Application/core/app_export.dart';
import 'package:WMS_Application/Screens/Login/Project_Overview_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MpProjectsSubCategoryScreen extends StatefulWidget {
  String? stateName;
  MpProjectsSubCategoryScreen(String state) {
    stateName = state;
  }

  @override
  State<MpProjectsSubCategoryScreen> createState() =>
      _MpProjectsSubCategoryScreenState();
}

class _MpProjectsSubCategoryScreenState
    extends State<MpProjectsSubCategoryScreen> {
  @override
  void initState() {
    super.initState();
    getProjectList();
  }

  Future<List<State_list_Model>>? futureProjectList;
  getProjectList() {
    setState(() {
      futureProjectList = getStateAuthority();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawerScreen(),
        appBar: AppBar(
            title: Text(
              widget.stateName!.toUpperCase(),
              textScaleFactor: 1,
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(color: Colors.lightBlue),
            ),
            leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
            )),
        // backgroundColor: ColorConstant.whiteA700,
        body: RefreshIndicator(
          onRefresh: () async {
            await getProjectList();
          },
          child: Container(
            decoration: BoxDecoration(image: backgroundImage),
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        child: Image.asset(
                          ImageConstant.imgRectangle35,
                          height: getVerticalSize(
                            163.00,
                          ),
                          width: size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: futureProjectList,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "${snapshot.error}",
                              textScaleFactor: 1,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          var data = snapshot.data as List<State_list_Model>;
                          var items = data
                              .where((element) =>
                                  element.state!.contains(widget.stateName!))
                              .toList();
                          Set<String> Project = new Set<String>();
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                  onTap: () async {
                                    var constring = 'Data Source=' +
                                        items[index].hostIp! +
                                        ';Initial Catalog=' +
                                        items[index].project! +
                                        ';User ID=' +
                                        items[index].userName! +
                                        ';Password=' +
                                        items[index].password! +
                                        ';';
                                    // print(constring);
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    preferences.setString(
                                        'conString', constring);
                                    preferences.setString(
                                        'project', items[index].project!);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AndroidSmall5Screen(
                                                    items[index].projectName!,
                                                    constring)));
                                  },
                                  child: Column(children: [
                                    getProject_list(items[index])
                                  ]),
                                );
                              }));
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getProject_list(State_list_Model? model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: getVerticalSize(
          76.00,
        ),
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      model!.projectName!.toUpperCase(),
                      textScaleFactor: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorConstant.black900,
                        fontSize: getFontSize(
                          16,
                        ),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Command Area " + model.totalArea.toString() + " Ha",
                      textScaleFactor: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorConstant.gray600,
                        fontSize: getFontSize(
                          12,
                        ),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
