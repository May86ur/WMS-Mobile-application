class PSMonitoringModel {
  String? projectName;
  String? state;
  int? pumpStationId;
  String? deviceName;
  int? status;
  String? pumpLatResponseTime;

  PSMonitoringModel(
      {this.projectName,
      this.state,
      this.pumpStationId,
      this.deviceName,
      this.status,
      this.pumpLatResponseTime});

  PSMonitoringModel.fromJson(Map<String, dynamic> json) {
    projectName = json['ProjectName'];
    state = json['State'];
    pumpStationId = json['PumpStationId'];
    deviceName = json['DeviceName'];
    status = json['Status'];
    pumpLatResponseTime = json['PumpLatResponseTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProjectName'] = this.projectName;
    data['State'] = this.state;
    data['PumpStationId'] = this.pumpStationId;
    data['DeviceName'] = this.deviceName;
    data['Status'] = this.status;
    data['PumpLatResponseTime'] = this.pumpLatResponseTime;
    return data;
  }
}
