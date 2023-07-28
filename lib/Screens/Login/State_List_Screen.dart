import 'package:WMS_Application/styles.dart';
import 'package:flutter/material.dart';
import 'package:WMS_Application/Model/Project/State_list_Model.dart';
import 'package:WMS_Application/Operations/StateselectionOperation.dart';
import 'package:WMS_Application/core/app_export.dart';
import 'package:WMS_Application/Screens/Login/Project_Lists.dart';
import 'package:WMS_Application/Screens/Login/MyDrawerScreen.dart';

class ProjectsCategoryScreen extends StatefulWidget {
  @override
  State<ProjectsCategoryScreen> createState() => _ProjectsCategoryScreenState();
}

class _ProjectsCategoryScreenState extends State<ProjectsCategoryScreen> {
  @override
  void initState() {
    super.initState();
    getFutureStateList();
  }

  Future<List<State_list_Model>>? futureProjectList;
  getFutureStateList() {
    setState(() {
      futureProjectList = getStateAuthority();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        drawer: MyDrawerScreen(),
        appBar: AppBar(
          title: Text(
            'Projects'.toUpperCase(),
            textScaleFactor: 1,
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await getFutureStateList();
          },
          child: Container(
            decoration: BoxDecoration(image: backgroundImage),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ///Image Banner
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Image.asset(
                      ImageConstant.imgBanner,
                      height: getVerticalSize(
                        163.00,
                      ),
                      width: size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                ///State List
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: futureProjectList,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 80),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(211, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(25)),
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                          height: 100,
                                          width: 100,
                                          image: AssetImage(
                                              'assets/images/storm.png')),
                                      Text(
                                        'OPPS!',
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 24,
                                            fontFamily: "RaleWay",
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        child: Text(
                                          'it seems Something went wrong with the Connection please try after sometime',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "RaleWay",
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            var items = snapshot.data as List<State_list_Model>;
                            Set<String> state = new Set<String>();
                            items.forEach((x) => state.add(x.state!));
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.length,
                                itemBuilder: ((context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MpProjectsSubCategoryScreen(
                                                      state.elementAt(index))));
                                    },
                                    child: getStateList(
                                        state.elementAt(index),
                                        items
                                            .where((element) =>
                                                element.state ==
                                                state.elementAt(index))
                                            .toList()),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  getStateList(String? state, List<State_list_Model>? model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: getVerticalSize(
          66.00,
        ),
        decoration: BoxDecoration(
          color: ColorConstant.whiteA700,
          borderRadius: BorderRadius.circular(20),
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
            Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                state!.toUpperCase(),
                textScaleFactor: 1,
                overflow: TextOverflow.ellipsis,
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
          ],
        ),
      ),
    );
  }
}
