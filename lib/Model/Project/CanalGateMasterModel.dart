class CanalGateMasterModel {
  int? deviceId;
  String? deviceName;
  int? commStatus;
  String? sUMPLEVELVAL;
  String? gAT1POSVAL;
  String? gAT2POSVAL;
  String? gAT3POSVAL;
  String? gAT4POSVAL;
  String? lT1VAL;
  double? pressure;

  CanalGateMasterModel(
      {this.deviceId,
      this.deviceName,
      this.commStatus,
      this.sUMPLEVELVAL,
      this.gAT1POSVAL,
      this.gAT2POSVAL,
      this.gAT3POSVAL,
      this.gAT4POSVAL,
      this.lT1VAL,
      this.pressure});

  CanalGateMasterModel.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    commStatus = json['CommStatus'];
    sUMPLEVELVAL = json['SUMP_LEVEL_VAL'];
    gAT1POSVAL = json['GAT1_POS_VAL'];
    gAT2POSVAL = json['GAT2_POS_VAL'];
    gAT3POSVAL = json['GAT3_POS_VAL'];
    gAT4POSVAL = json['GAT4_POS_VAL'];
    lT1VAL = json['LT1_VAL'];
    pressure = json['Pressure'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['deviceId'] = this.deviceId;
  //   data['deviceName'] = this.deviceName;
  //   data['CommStatus'] = this.commStatus;
  //   data['SUMP_LEVEL_VAL'] = this.sUMPLEVELVAL;
  //   data['GAT1_POS_VAL'] = this.gAT1POSVAL;
  //   data['GAT2_POS_VAL'] = this.gAT2POSVAL;
  //   data['GAT3_POS_VAL'] = this.gAT3POSVAL;
  //   data['GAT4_POS_VAL'] = this.gAT4POSVAL;
  //   data['LT1_VAL'] = this.lT1VAL;
  //   data['Pressure'] = this.pressure;
  //   return data;
  // }
}
