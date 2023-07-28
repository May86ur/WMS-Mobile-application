import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:WMS_Application/Model/Constants.dart';
import 'package:WMS_Application/Model/DeliveryChamberModel.dart';

import 'RestServices.dart';

Future<List<DeliveryChamberModel>> getBPTData() async {
  try {
//var request = http.Request('GET', Uri.parse('http://wmsservices.seprojects.in/api/AMS/GetBPTdata?conString=Data%20Source=135.181.37.205;Initial%20Catalog=BansujaraGL;User%20ID=sa;Password=gat@1234;'));

//http.StreamedResponse response = await request.send();
    final response = await http.get(Uri.parse(GetHttpRequest(WebApiAmsPrefix,
        'GetBPTdata?conString=Data%20Source=65.21.7.97;Initial%20Catalog=BansujaraGL;User%20ID=sa;Password=gat@1234;')));
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<DeliveryChamberModel> result = <DeliveryChamberModel>[];
      json['data']['Response']
          .forEach((v) => result.add(DeliveryChamberModel.fromJson(v)));
      return result;
    } else {
      throw Exception("API Consumed Failed");
    }
  } on Exception catch (_, ex) {
    throw Exception("API Consumed Failed");
  }
}
