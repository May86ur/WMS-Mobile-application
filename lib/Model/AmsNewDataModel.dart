class AmsNewDataModel {
  int? amsId;
  String? deviceType;
  String? amsNo;
  String? chainageNo;
  String? amsCoordinate;
  String? lastResponseTime;
  String? description;
  String? subArea;
  double? batteryLevel;
  int? solarVoltage;
  int? designPressure;
  int? dOOR;
  double? actualPressure;
  int? isConnected;
  int? batterypercentage;

  AmsNewDataModel(
      {this.amsId,
      this.deviceType,
      this.amsNo,
      this.chainageNo,
      this.amsCoordinate,
      this.lastResponseTime,
      this.description,
      this.subArea,
      this.batteryLevel,
      this.solarVoltage,
      this.designPressure,
      this.dOOR,
      this.actualPressure,
      this.isConnected,
      this.batterypercentage});

  AmsNewDataModel.fromJson(Map<String, dynamic> json) {
    amsId = json['AmsId'];
    deviceType = json['DeviceType'];
    amsNo = json['AmsNo'];
    chainageNo = json['ChainageNo'];
    amsCoordinate = json['AmsCoordinate'];
    lastResponseTime = json['LastResponseTime'];
    description = json['description'];
    subArea = json['SubArea'];
    batteryLevel = json['BatteryLevel'];
    solarVoltage = json['SolarVoltage'];
    designPressure = json['DesignPressure'];
    dOOR = json['DOOR'];
    actualPressure = json['ActualPressure'];
    isConnected = json['IsConnected'];
    batterypercentage = json['batterypercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AmsId'] = this.amsId;
    data['DeviceType'] = this.deviceType;
    data['AmsNo'] = this.amsNo;
    data['ChainageNo'] = this.chainageNo;
    data['AmsCoordinate'] = this.amsCoordinate;
    data['LastResponseTime'] = this.lastResponseTime;
    data['description'] = this.description;
    data['SubArea'] = this.subArea;
    data['BatteryLevel'] = this.batteryLevel;
    data['SolarVoltage'] = this.solarVoltage;
    data['DesignPressure'] = this.designPressure;
    data['DOOR'] = this.dOOR;
    data['ActualPressure'] = this.actualPressure;
    data['IsConnected'] = this.isConnected;
    data['batterypercentage'] = this.batterypercentage;
    return data;
  }
}
