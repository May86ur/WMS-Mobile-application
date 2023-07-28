class OmsNewDataModel {
  int? omsId;
  String? chakNo;
  String? description;
  String? DistributroyId;
  String? subArea;
  String? AreaId;
  String? lastResponseTime;
  int? alarmCount;
  int? isConnected;
  int? batteryPercentage;
  int? damage;

  OmsNewDataModel({
    this.omsId,
    this.chakNo,
    this.description,
    this.DistributroyId,
    this.subArea,
    this.AreaId,
    this.lastResponseTime,
    this.alarmCount,
    this.isConnected,
    this.batteryPercentage,
    this.damage,
  });

  OmsNewDataModel.fromJson(Map<String, dynamic> json) {
    omsId = json['OmsId'] as int?;
    chakNo = json['ChakNo'] as String?;
    description = json['description'] as String?;
    DistributroyId = json['DistributroyId'] as String?;
    subArea = json['SubArea'] as String?;
    AreaId = json['AreaId'] as String?;
    lastResponseTime = json['LastResponseTime'] as String?;
    alarmCount = json['AlarmCount'] as int?;
    isConnected = json['IsConnected'] as int?;
    batteryPercentage = json['BatteryPercentage'] as int?;
    damage = json['Damage'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['OmsId'] = omsId;
    json['ChakNo'] = chakNo;
    json['description'] = description;
    json['DistributroyId'] = DistributroyId;
    json['SubArea'] = subArea;
    json['AreaId'] = AreaId;
    json['LastResponseTime'] = lastResponseTime;
    json['AlarmCount'] = alarmCount;
    json['IsConnected'] = isConnected;
    json['BatteryPercentage'] = batteryPercentage;
    json['Damage'] = damage;
    return json;
  }
}
