/*class OmsList_Model {
  int? omsId;
  int? activeAlarm;
  String? chakNo;
  String? lastResponseTime;
  double? batteryLevel;
  int? totalDamage;
  String? oNLINE;

  OmsList_Model(
      {this.omsId,
      this.activeAlarm,
      this.chakNo,
      this.lastResponseTime,
      this.batteryLevel,
      this.totalDamage,
      this.oNLINE});

  OmsList_Model.fromJson(Map<String, dynamic> json) {
    omsId = json['OmsId'];
    activeAlarm = json['ActiveAlarm'];
    chakNo = json['ChakNo'];
    lastResponseTime = json['LastResponseTime'];
    batteryLevel = json['BatteryLevel'];
    totalDamage = json['TotalDamage'];
    oNLINE = json['ONLINE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OmsId'] = this.omsId;
    data['ActiveAlarm'] = this.activeAlarm;
    data['ChakNo'] = this.chakNo;
    data['LastResponseTime'] = this.lastResponseTime;
    data['BatteryLevel'] = this.batteryLevel;
    data['TotalDamage'] = this.totalDamage;
    data['ONLINE'] = this.oNLINE;
    return data;
  }
}
*/
class OmsList_Model {
  int? omsId;
  String? distributaryName;
  String? areaName;
  int? activeAlarm;
  String? chakNo;
  String? lastResponseTime;
  double? batteryLevel;
  int? totalDamage;
  String? oNLINE;

  OmsList_Model(
      {this.omsId,
      this.distributaryName,
      this.areaName,
      this.activeAlarm,
      this.chakNo,
      this.lastResponseTime,
      this.batteryLevel,
      this.totalDamage,
      this.oNLINE});

  OmsList_Model.fromJson(Map<String, dynamic> json) {
    omsId = json['OmsId'];
    distributaryName = json['DistributaryName'];
    areaName = json['AreaName'];
    activeAlarm = json['ActiveAlarm'];
    chakNo = json['ChakNo'];
    lastResponseTime = json['LastResponseTime'];
    batteryLevel = json['BatteryLevel'];
    totalDamage = json['TotalDamage'];
    oNLINE = json['ONLINE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OmsId'] = this.omsId;
    data['DistributaryName'] = this.distributaryName;
    data['AreaName'] = this.areaName;
    data['ActiveAlarm'] = this.activeAlarm;
    data['ChakNo'] = this.chakNo;
    data['LastResponseTime'] = this.lastResponseTime;
    data['BatteryLevel'] = this.batteryLevel;
    data['TotalDamage'] = this.totalDamage;
    data['ONLINE'] = this.oNLINE;
    return data;
  }
}
