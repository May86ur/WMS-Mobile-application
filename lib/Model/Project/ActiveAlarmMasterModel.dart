class ActiveAlarmMasterModel {
  int? omsid;
  String? alarmType;
  String? description;
  String? alarmStartDate;
  String? chakNo;
  int? amsid;
  dynamic amsNo;

  ActiveAlarmMasterModel(
      {this.omsid,
      this.alarmType,
      this.description,
      this.alarmStartDate,
      this.chakNo,
      this.amsid,
      this.amsNo});

  ActiveAlarmMasterModel.fromJson(Map<String, dynamic> json) {
    omsid = json['omsid'];
    alarmType = json['AlarmType'];
    description = json['Description'];
    alarmStartDate = json['AlarmStartDate'];
    chakNo = json['ChakNo'];
    amsid = json['amsid'];
    amsNo = json['AmsNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['omsid'] = this.omsid;
    data['AlarmType'] = this.alarmType;
    data['Description'] = this.description;
    data['AlarmStartDate'] = this.alarmStartDate;
    data['ChakNo'] = this.chakNo;
    data['amsid'] = this.amsid;
    data['AmsNo'] = this.amsNo;
    return data;
  }
}

/*class ActiveAlarmMasterModel {
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
}*/
