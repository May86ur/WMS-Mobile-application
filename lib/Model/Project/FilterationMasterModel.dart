class FilterationMasterModel {
  int? tagId;
  String? data;
  String? deviceTimeStamp;
  int? pumpStationId;
  int? devStatus;
  String? tagName;

  FilterationMasterModel(
      {this.tagId,
      this.data,
      this.deviceTimeStamp,
      this.pumpStationId,
      this.devStatus,
      this.tagName});

  FilterationMasterModel.fromJson(Map<String, dynamic> json) {
    tagId = json['tagId'];
    data = json['data'];
    deviceTimeStamp = json['deviceTimeStamp'];
    pumpStationId = json['pumpStationId'];
    devStatus = json['devStatus'];
    tagName = json['tagName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagId'] = this.tagId;
    data['data'] = this.data;
    data['deviceTimeStamp'] = this.deviceTimeStamp;
    data['pumpStationId'] = this.pumpStationId;
    data['devStatus'] = this.devStatus;
    data['tagName'] = this.tagName;
    return data;
  }
}
