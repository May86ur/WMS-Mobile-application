
class AmsDataModel {
  int? amsId;
  String? amsNo;
  String? chainageNo;
  int? chainage;
  String? amsCoordinate;
  String? uID;
  String? mACAddress;
  String? lastResponseTime;
  int? alarmState;
  String? publishTopic;
  String? deviceType;
  String? description;
  String? subArea;
  int? updateFreq;
  int? areaId;
  int? distributroyId;
  bool? dI1;
  bool? dI2;
  double? aI1;
  double? aI2;
  double? batteryLevel;
  int? solarVoltage;
  int? designPressure;
  int? cI;
  int? dOOR;
  int? wEAKSOLAR;
  int? lOWBAT;
  int? devStatus;
  double? actualPressure;
  int? hIGHPRESSURE;
  int? lOWPRESSURE;
  int? iNRANGE;
  int? isConnected;
  int? alarmCount;
  String? subTopic;

  AmsDataModel(
      {this.amsId,
      this.amsNo,
      this.chainageNo,
      this.chainage,
      this.amsCoordinate,
      this.uID,
      this.mACAddress,
      this.lastResponseTime,
      this.alarmState,
      this.publishTopic,
      this.deviceType,
      this.description,
      this.subArea,
      this.updateFreq,
      this.areaId,
      this.distributroyId,
      this.dI1,
      this.dI2,
      this.aI1,
      this.aI2,
      this.batteryLevel,
      this.solarVoltage,
      this.designPressure,
      this.cI,
      this.dOOR,
      this.wEAKSOLAR,
      this.lOWBAT,
      this.devStatus,
      this.actualPressure,
      this.hIGHPRESSURE,
      this.lOWPRESSURE,
      this.iNRANGE,
      this.isConnected,
      this.alarmCount,
      this.subTopic});

  AmsDataModel.fromJson(Map<String, dynamic> json) {
    amsId = json['AmsId'];
    amsNo = json['AmsNo'];
    chainageNo = json['ChainageNo'];
    chainage = json['Chainage'];
    amsCoordinate = json['AmsCoordinate'];
    uID = json['UID'];
    mACAddress = json['MACAddress'];
    lastResponseTime = json['LastResponseTime'];
    alarmState = json['AlarmState'];
    publishTopic = json['PublishTopic'];
    deviceType = json['deviceType'];
    description = json['description'];
    subArea = json['SubArea'];
    updateFreq = json['UpdateFreq'];
    areaId = json['AreaId'];
    distributroyId = json['DistributroyId'];
    dI1 = json['DI1'];
    dI2 = json['DI2'];
    aI1 = json['AI1'];
    aI2 = json['AI2'];
    batteryLevel = json['BatteryLevel'];
    solarVoltage = json['SolarVoltage'];
    designPressure = json['DesignPressure'];
    cI = json['CI'];
    dOOR = json['DOOR'];
    wEAKSOLAR = json['WEAK_SOLAR'];
    lOWBAT = json['LOW_BAT'];
    devStatus = json['devStatus'];
    actualPressure = json['ActualPressure'];
    hIGHPRESSURE = json['HIGH_PRESSURE'];
    lOWPRESSURE = json['LOW_PRESSURE'];
    iNRANGE = json['IN_RANGE'];
    isConnected = json['IsConnected'];
    alarmCount = json['AlarmCount'];
    subTopic = json['SubTopic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AmsId'] = this.amsId;
    data['AmsNo'] = this.amsNo;
    data['ChainageNo'] = this.chainageNo;
    data['Chainage'] = this.chainage;
    data['AmsCoordinate'] = this.amsCoordinate;
    data['UID'] = this.uID;
    data['MACAddress'] = this.mACAddress;
    data['LastResponseTime'] = this.lastResponseTime;
    data['AlarmState'] = this.alarmState;
    data['PublishTopic'] = this.publishTopic;
    data['deviceType'] = this.deviceType;
    data['description'] = this.description;
    data['SubArea'] = this.subArea;
    data['UpdateFreq'] = this.updateFreq;
    data['AreaId'] = this.areaId;
    data['DistributroyId'] = this.distributroyId;
    data['DI1'] = this.dI1;
    data['DI2'] = this.dI2;
    data['AI1'] = this.aI1;
    data['AI2'] = this.aI2;
    data['BatteryLevel'] = this.batteryLevel;
    data['SolarVoltage'] = this.solarVoltage;
    data['DesignPressure'] = this.designPressure;
    data['CI'] = this.cI;
    data['DOOR'] = this.dOOR;
    data['WEAK_SOLAR'] = this.wEAKSOLAR;
    data['LOW_BAT'] = this.lOWBAT;
    data['devStatus'] = this.devStatus;
    data['ActualPressure'] = this.actualPressure;
    data['HIGH_PRESSURE'] = this.hIGHPRESSURE;
    data['LOW_PRESSURE'] = this.lOWPRESSURE;
    data['IN_RANGE'] = this.iNRANGE;
    data['IsConnected'] = this.isConnected;
    data['AlarmCount'] = this.alarmCount;
    data['SubTopic'] = this.subTopic;
    return data;
  }
}
