class AmsMasterModelSql {
  int? amsId;
  int? areaId;
  int? distributroyId;
  int? brokerId;
  String? uID;
  int? sID;
  String? subscribeTopicName;
  String? publishTopic;
  String? lastResponseTime;
  String? amsNo;
  String? typeOfVale;
  dynamic? airvalveSize;
  dynamic? location;
  String? chainageNo;
  String? amsCoordinate;
  double? batteryLevel;
  double? solarVoltage;
  bool? dI1;
  bool? dI2;
  double? aI1;
  double? aI2;
  dynamic? designPressure;
  dynamic? alarmState;
  int? updateFreq;
  dynamic? isAMSCommAlarmset;
  dynamic? interrogateCounter;
  int? pressureAI;
  String? deviceType;
  double? cI;
  double? gSM;
  bool? dataRecieved;
  int? amsSeq;
  String? mACAddress;
  int? cType;
  int? gateWayId;
  int? amsId1;
  String? amsNo1;
  String? description;
  int? distributroyId1;
  String? subArea;
  int? areaId1;
  String? lastResponseTime1;
  int? alarmCount;
  int? isconnected;
  int? batteryPercentage;
  double? designPressure1;
  double? actualPressure;
  dynamic? damage;

  AmsMasterModelSql(
      {this.amsId,
      this.areaId,
      this.distributroyId,
      this.brokerId,
      this.uID,
      this.sID,
      this.subscribeTopicName,
      this.publishTopic,
      this.lastResponseTime,
      this.amsNo,
      this.typeOfVale,
      this.airvalveSize,
      this.location,
      this.chainageNo,
      this.amsCoordinate,
      this.batteryLevel,
      this.solarVoltage,
      this.dI1,
      this.dI2,
      this.aI1,
      this.aI2,
      this.designPressure,
      this.alarmState,
      this.updateFreq,
      this.isAMSCommAlarmset,
      this.interrogateCounter,
      this.pressureAI,
      this.deviceType,
      this.cI,
      this.gSM,
      this.dataRecieved,
      this.amsSeq,
      this.mACAddress,
      this.cType,
      this.gateWayId,
      this.amsId1,
      this.amsNo1,
      this.description,
      this.distributroyId1,
      this.subArea,
      this.areaId1,
      this.lastResponseTime1,
      this.alarmCount,
      this.isconnected,
      this.batteryPercentage,
      this.designPressure1,
      this.actualPressure,
      this.damage});

  AmsMasterModelSql.fromJson(Map<String, dynamic> json) {
    amsId = json['AmsId'];
    areaId = json['AreaId'];
    distributroyId = json['DistributroyId'];
    brokerId = json['BrokerId'];
    uID = json['UID'];
    sID = json['SID'];
    subscribeTopicName = json['SubscribeTopicName'];
    publishTopic = json['PublishTopic'];
    lastResponseTime = json['LastResponseTime'];
    amsNo = json['AmsNo'];
    typeOfVale = json['TypeOfVale'];
    airvalveSize = json['AirvalveSize'];
    location = json['Location'];
    chainageNo = json['ChainageNo'];
    amsCoordinate = json['AmsCoordinate'];
    batteryLevel = json['BatteryLevel'];
    solarVoltage = json['SolarVoltage'];
    dI1 = json['DI1'];
    dI2 = json['DI2'];
    aI1 = json['AI1'];
    aI2 = json['AI2'];
    designPressure = json['DesignPressure'];
    alarmState = json['AlarmState'];
    updateFreq = json['UpdateFreq'];
    isAMSCommAlarmset = json['IsAMSCommAlarmset'];
    interrogateCounter = json['interrogate_Counter'];
    pressureAI = json['PressureAI'];
    deviceType = json['deviceType'];
    cI = json['CI'];
    gSM = json['GSM'];
    dataRecieved = json['DataRecieved'];
    amsSeq = json['AmsSeq'];
    mACAddress = json['MACAddress'];
    cType = json['CType'];
    gateWayId = json['GateWayId'];
    amsId1 = json['AmsId1'];
    amsNo1 = json['AmsNo1'];
    description = json['description'];
    distributroyId1 = json['DistributroyId1'];
    subArea = json['SubArea'];
    areaId1 = json['AreaId1'];
    lastResponseTime1 = json['LastResponseTime1'];
    alarmCount = json['AlarmCount'];
    isconnected = json['isconnected'];
    batteryPercentage = json['BatteryPercentage'];
    designPressure1 = json['DesignPressure1'];
    actualPressure = json['ActualPressure'];
    damage = json['Damage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AmsId'] = this.amsId;
    data['AreaId'] = this.areaId;
    data['DistributroyId'] = this.distributroyId;
    data['BrokerId'] = this.brokerId;
    data['UID'] = this.uID;
    data['SID'] = this.sID;
    data['SubscribeTopicName'] = this.subscribeTopicName;
    data['PublishTopic'] = this.publishTopic;
    data['LastResponseTime'] = this.lastResponseTime;
    data['AmsNo'] = this.amsNo;
    data['TypeOfVale'] = this.typeOfVale;
    data['AirvalveSize'] = this.airvalveSize;
    data['Location'] = this.location;
    data['ChainageNo'] = this.chainageNo;
    data['AmsCoordinate'] = this.amsCoordinate;
    data['BatteryLevel'] = this.batteryLevel;
    data['SolarVoltage'] = this.solarVoltage;
    data['DI1'] = this.dI1;
    data['DI2'] = this.dI2;
    data['AI1'] = this.aI1;
    data['AI2'] = this.aI2;
    data['DesignPressure'] = this.designPressure;
    data['AlarmState'] = this.alarmState;
    data['UpdateFreq'] = this.updateFreq;
    data['IsAMSCommAlarmset'] = this.isAMSCommAlarmset;
    data['interrogate_Counter'] = this.interrogateCounter;
    data['PressureAI'] = this.pressureAI;
    data['deviceType'] = this.deviceType;
    data['CI'] = this.cI;
    data['GSM'] = this.gSM;
    data['DataRecieved'] = this.dataRecieved;
    data['AmsSeq'] = this.amsSeq;
    data['MACAddress'] = this.mACAddress;
    data['CType'] = this.cType;
    data['GateWayId'] = this.gateWayId;
    data['AmsId1'] = this.amsId1;
    data['AmsNo1'] = this.amsNo1;
    data['description'] = this.description;
    data['DistributroyId1'] = this.distributroyId1;
    data['SubArea'] = this.subArea;
    data['AreaId1'] = this.areaId1;
    data['LastResponseTime1'] = this.lastResponseTime1;
    data['AlarmCount'] = this.alarmCount;
    data['isconnected'] = this.isconnected;
    data['BatteryPercentage'] = this.batteryPercentage;
    data['DesignPressure1'] = this.designPressure1;
    data['ActualPressure'] = this.actualPressure;
    data['Damage'] = this.damage;
    return data;
  }
}
