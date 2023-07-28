class LoRaGateWayMasterModel {
  dynamic? gatewayNo;
  String? gatewayName;
  double? batteryLevel;
  String? lastDataReceived;
  int? devStatus;

  LoRaGateWayMasterModel(
      {this.gatewayNo,
      this.gatewayName,
      this.batteryLevel,
      this.lastDataReceived,
      this.devStatus});

  LoRaGateWayMasterModel.fromJson(Map<String, dynamic> json) {
    gatewayNo = json['GatewayNo'];
    gatewayName = json['GatewayName'];
    batteryLevel = json['BatteryLevel'] ?? 0.0;
    lastDataReceived = json['LastDataReceived'];
    devStatus = json['DevStatus'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GatewayNo'] = this.gatewayNo;
    data['GatewayName'] = this.gatewayName;
    data['BatteryLevel'] = this.batteryLevel;
    data['LastDataReceived'] = this.lastDataReceived;
    data['DevStatus'] = this.devStatus;
    return data;
  }
}
