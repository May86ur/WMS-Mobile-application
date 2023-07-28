class SchemeMasterModel {
  int? id;
  String? schemaName;
  int? areaId;

  SchemeMasterModel({this.id, this.schemaName, this.areaId});

  SchemeMasterModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    schemaName = json['SchemaName'];
    areaId = json['AreaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SchemaName'] = this.schemaName;
    data['AreaId'] = this.areaId;
    return data;
  }
}
