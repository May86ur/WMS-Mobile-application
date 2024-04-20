// ignore_for_file: must_be_immutable, non_constant_identifier_names, avoid_print, prefer_const_constructors, empty_catches, unnecessary_brace_in_string_interps, deprecated_member_use, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_management_system/Model/AreaModel.dart';
import 'package:water_management_system/Model/Project/ProjectReportModel.dart';
import 'package:water_management_system/Model/Project/RMS_Overview_model.dart';
import 'package:water_management_system/Operations/StateselectionOperation.dart';
import 'package:water_management_system/Screens/Active%20Alarm%20Reports/PdfConstant.dart';

class ProjectReportScreen extends StatefulWidget {
  String? projectName;
  ProjectReportScreen({super.key, String? ProjectName}) {
    projectName = ProjectName;
  }

  @override
  State<ProjectReportScreen> createState() => _ProjectReportScreenState();
}

class _ProjectReportScreenState extends State<ProjectReportScreen> {
  String? pdfString;
  String? project;
  int? currentHour;
  List<AreaModel>? futureArea;
  List<RMS_Overview_model>? Rmsmodel;
  List<String>? omsList;
  List<String>? rmsList;
  List<String>? amsList;
  @override
  void initState() {
    GetPDFbyPath("${widget.projectName} Report");
    setState(() {
      project = widget.projectName;
    });
    getProjectList();
    super.initState();
  }

  Future<List<ProjectReportModel>>? futureProjectList;

  getProjectList() async {
    setState(() {
      futureProjectList = getProjectReportList();
    });
    futureArea = await getAreaid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$project Report",
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
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
                var items =
                    data.where((element) => element.projectName == project);

                Set<int> areaid = <int>{};

                for (var x in items) {
                  areaid.add(x.areaId!);
                }

                List<String>? areaName = [];
                for (var x in futureArea ?? [].toList()) {
                  areaName.add(x.areaName!);
                }

                if (areaName.isNotEmpty) {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data
                          .where((element) => element.projectName == project)
                          .length,
                      itemBuilder: ((context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                "${widget.projectName} ${areaName.elementAt(areaid.elementAt(index))}",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () async {
                                await GetPDFbyPath(
                                    "${areaid.elementAt(index)}");
                                await base64ToPdf(pdfString!,
                                    '$project Zone - ${areaid.elementAt(index)}');
                              },
                            ),
                          ),
                        );
                      }));
                } else {
                  return Expanded(
                      child: Center(child: CircularProgressIndicator()));
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ]),
      ),
    );
  }

  Future<String> GetPDFbyPath(String? areaId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? fileDate;
    String pdf64base = "";
    String? userType = preferences.getString('usertype');
    var fileName = userType!.toLowerCase().contains('manager')
        ? 'ActiveAlarmManagerReport'
        : 'ActiveAlarmReport';
    try {
      DateTime currentTime = DateTime.now();
      currentHour = currentTime.hour;
      if (!userType.toLowerCase().contains('manager')) {
        if (currentHour! >= 9 && currentHour! <= 17) {
          fileDate = "${DateFormat('dd MMM yyyy').format(DateTime.now())}-10";
        } else if (currentHour! == 18 || currentHour! > 18) {
          fileDate = "${DateFormat('dd MMM yyyy').format(DateTime.now())}-18";
        } else if (currentHour! < 9) {
          fileDate =
              "${DateFormat('dd MMM yyyy').format(DateTime.now().subtract(Duration(days: 1)))}-18";
        }
      } else {
        fileDate = "${DateFormat('dd MMM yyyy').format(DateTime.now())}-10";
      }

      var request = http.Request(
          'GET',
          Uri.parse(
              'http://wmsservices.seprojects.in/api/Image/GetImage?imgPath=C:\\SEECM\\Whatsapp_PDF\\${widget.projectName}\\$areaId\\${fileName}_${fileDate}.pdf'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        pdf64base = await response.stream.bytesToString();
        setState(() {
          pdfString = pdf64base.replaceAll('"', '');
        });
      } else {
        setState(() {
          pdfString = PdfConstant.base64pdf;
        });
        print(response.reasonPhrase);
      }
    } catch (ex) {}
    return pdf64base;
  }

  base64ToPdf(String base64String, String fileName) async {
    var bytes = base64Decode(base64String);
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$fileName.pdf");
    await file.writeAsBytes(bytes.buffer.asUint8List());
    await OpenFilex.open("${output.path}/$fileName.pdf");
  }
}
