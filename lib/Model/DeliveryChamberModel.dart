class DeliveryChamberModel {
  int? amsId;
  String? amsNo;
  int? isConnected;
  String? lastResponseTime;
  double? batteryLevel;
  double? pressure;
  String? amsCoordinate;
  String? rewaBPTPressure;

  DeliveryChamberModel(
      {this.amsId,
      this.amsNo,
      this.isConnected,
      this.lastResponseTime,
      this.batteryLevel,
      this.pressure,
      this.amsCoordinate,
      this.rewaBPTPressure});

  DeliveryChamberModel.fromJson(Map<String, dynamic> json) {
    amsId = json['AmsId'];
    amsNo = json['AmsNo'];
    isConnected = json['IsConnected'];
    lastResponseTime = json['LastResponseTime'];
    batteryLevel = json['BatteryLevel'];
    pressure = json['Pressure'];
    amsCoordinate = json['AmsCoordinate'];
    rewaBPTPressure = json['RewaBPTPressure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AmsId'] = this.amsId;
    data['AmsNo'] = this.amsNo;
    data['IsConnected'] = this.isConnected;
    data['LastResponseTime'] = this.lastResponseTime;
    data['BatteryLevel'] = this.batteryLevel;
    data['Pressure'] = this.pressure;
    data['AmsCoordinate'] = this.amsCoordinate;
    data['RewaBPTPressure'] = this.rewaBPTPressure;
    return data;
  }
}
