class ActiveAlarmMasterModel {
  int? omsId;
  String? chakNo;
  String? description;
  String? startTime;
  String? distributaryName;
  String? areaName;

  ActiveAlarmMasterModel(
      {this.omsId,
      this.chakNo,
      this.description,
      this.startTime,
      this.distributaryName,
      this.areaName});

  ActiveAlarmMasterModel.fromJson(Map<String, dynamic> json) {
    omsId = json['OmsId'];
    chakNo = json['ChakNo'];
    description = json['Description'];
    startTime = json['StartTime'];
    distributaryName = json['DistributaryName'];
    areaName = json['AreaName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OmsId'] = this.omsId;
    data['ChakNo'] = this.chakNo;
    data['Description'] = this.description;
    data['StartTime'] = this.startTime;
    data['DistributaryName'] = this.distributaryName;
    data['AreaName'] = this.areaName;
    return data;
  }
}
