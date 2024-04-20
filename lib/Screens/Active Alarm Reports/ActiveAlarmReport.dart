// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_management_system/Model/Project/ProjectReportModel.dart';

import 'package:water_management_system/Operations/StateselectionOperation.dart';
import 'package:water_management_system/Screens/Active%20Alarm%20Reports/ReportPage.dart';

class ActiveAlarmReport extends StatefulWidget {
  const ActiveAlarmReport({super.key});

  @override
  State<ActiveAlarmReport> createState() => _ActiveAlarmReportState();
}

class _ActiveAlarmReportState extends State<ActiveAlarmReport> {
  @override
  void initState() {
    super.initState();
    getProjectList();
  }

  Future<List<ProjectReportModel>>? futureProjectList;
  getProjectList() {
    setState(() {
      futureProjectList = getProjectReportList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Active Alarm Reports",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                    var data = snapshot.data as List<ProjectReportModel>;
                    var items = data;

                    Set<String> project = <String>{};
                    for (var x in items) {
                      project.add(x.projectName!);
                    }
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: project.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () async {
                              String? constring;
                              constring = items
                                  .where((element) =>
                                      element.projectName ==
                                      project.elementAt(index))
                                  .first
                                  .conString;
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setString(
                                  'conString', constring ?? '');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProjectReportScreen(
                                            ProjectName:
                                                project.elementAt(index),
                                          )));
                            },
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 2),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 5,
                                  child: SizedBox(
                                    height: 76,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Text(
                                                  project
                                                      .elementAt(index)
                                                      .toUpperCase(),
                                                  textScaleFactor: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          );
                        }));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getProject_list(ProjectReportModel? model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
        child: SizedBox(
          height: 76,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
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
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
