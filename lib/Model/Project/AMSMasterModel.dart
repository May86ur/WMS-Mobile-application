class AMSMasterModel {
  int? amsId;
  int? areaId;
  int? distributaryId;
  int? brokerId;
  int? gateWayId;
  String? uID;
  String? mACAddress;
  String? publishTopic;
  dynamic lastResponseTime;
  dynamic deviceTime;
  dynamic packetType;
  String? amsNo;
  int? chainage;
  String? coordinates;
  dynamic batteryLevel;
  dynamic solarVoltage;
  dynamic aI1;
  dynamic aI2;
  dynamic dI1;
  dynamic dI2;
  int? updateFreq;
  String? typeofValve;
  dynamic firmwareVersion;
  dynamic aLMV;
  dynamic loadVoltage;
  dynamic chargingCurrent;
  int? diaOfPipe;
  dynamic diaOfValve;
  String? deviceType;
  dynamic designPressure;
  dynamic subscribeTopicName;
  String? networkType;
  dynamic pressureAI;
  dynamic typeId;
  dynamic downlinkId;
  dynamic distributaryName;
  String? areaName;
  dynamic activeAlarm;
  String? amsNo1;
  String? lastResponseTime1;
  double? batteryLevel1;
  int? totalDamage;
  String? oNLINE;
  dynamic actualPressure;

  AMSMasterModel(
      {this.amsId,
      this.areaId,
      this.distributaryId,
      this.brokerId,
      this.gateWayId,
      this.uID,
      this.mACAddress,
      this.publishTopic,
      this.lastResponseTime,
      this.deviceTime,
      this.packetType,
      this.amsNo,
      this.chainage,
      this.coordinates,
      this.batteryLevel,
      this.solarVoltage,
      this.aI1,
      this.aI2,
      this.dI1,
      this.dI2,
      this.updateFreq,
      this.typeofValve,
      this.firmwareVersion,
      this.aLMV,
      this.loadVoltage,
      this.chargingCurrent,
      this.diaOfPipe,
      this.diaOfValve,
      this.deviceType,
      this.designPressure,
      this.subscribeTopicName,
      this.networkType,
      this.pressureAI,
      this.typeId,
      this.downlinkId,
      this.distributaryName,
      this.areaName,
      this.activeAlarm,
      this.amsNo1,
      this.lastResponseTime1,
      this.batteryLevel1,
      this.totalDamage,
      this.oNLINE,
      this.actualPressure});

  AMSMasterModel.fromJson(Map<String, dynamic> json) {
    amsId = json['AmsId'];
    areaId = json['AreaId'];
    distributaryId = json['DistributaryId'];
    brokerId = json['BrokerId'];
    gateWayId = json['GateWayId'];
    uID = json['UID'];
    mACAddress = json['MACAddress'];
    publishTopic = json['PublishTopic'];
    lastResponseTime = json['LastResponseTime'];
    deviceTime = json['DeviceTime'];
    packetType = json['PacketType'];
    amsNo = json['AmsNo'];
    chainage = json['Chainage'];
    coordinates = json['Coordinates'];
    batteryLevel = json['BatteryLevel'];
    solarVoltage = json['SolarVoltage'];
    aI1 = json['AI1'];
    aI2 = json['AI2'];
    dI1 = json['DI1'];
    dI2 = json['DI2'];
    updateFreq = json['UpdateFreq'];
    typeofValve = json['TypeofValve'];
    firmwareVersion = json['FirmwareVersion'];
    aLMV = json['ALMV'];
    loadVoltage = json['LoadVoltage'];
    chargingCurrent = json['ChargingCurrent'];
    diaOfPipe = json['DiaOfPipe'];
    diaOfValve = json['DiaOfValve'];
    deviceType = json['DeviceType'];
    designPressure = json['DesignPressure'];
    subscribeTopicName = json['SubscribeTopicName'];
    networkType = json['NetworkType'];
    pressureAI = json['PressureAI'];
    typeId = json['TypeId'];
    downlinkId = json['DownlinkId'];
    distributaryName = json['DistributaryName'];
    areaName = json['AreaName'];
    activeAlarm = json['ActiveAlarm'];
    amsNo1 = json['AmsNo1'];
    lastResponseTime1 = json['LastResponseTime1'];
    batteryLevel1 = json['BatteryLevel1'];
    totalDamage = json['TotalDamage'];
    oNLINE = json['ONLINE'];
    actualPressure = json['ActualPressure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AmsId'] = this.amsId;
    data['AreaId'] = this.areaId;
    data['DistributaryId'] = this.distributaryId;
    data['BrokerId'] = this.brokerId;
    data['GateWayId'] = this.gateWayId;
    data['UID'] = this.uID;
    data['MACAddress'] = this.mACAddress;
    data['PublishTopic'] = this.publishTopic;
    data['LastResponseTime'] = this.lastResponseTime;
    data['DeviceTime'] = this.deviceTime;
    data['PacketType'] = this.packetType;
    data['AmsNo'] = this.amsNo;
    data['Chainage'] = this.chainage;
    data['Coordinates'] = this.coordinates;
    data['BatteryLevel'] = this.batteryLevel;
    data['SolarVoltage'] = this.solarVoltage;
    data['AI1'] = this.aI1;
    data['AI2'] = this.aI2;
    data['DI1'] = this.dI1;
    data['DI2'] = this.dI2;
    data['UpdateFreq'] = this.updateFreq;
    data['TypeofValve'] = this.typeofValve;
    data['FirmwareVersion'] = this.firmwareVersion;
    data['ALMV'] = this.aLMV;
    data['LoadVoltage'] = this.loadVoltage;
    data['ChargingCurrent'] = this.chargingCurrent;
    data['DiaOfPipe'] = this.diaOfPipe;
    data['DiaOfValve'] = this.diaOfValve;
    data['DeviceType'] = this.deviceType;
    data['DesignPressure'] = this.designPressure;
    data['SubscribeTopicName'] = this.subscribeTopicName;
    data['NetworkType'] = this.networkType;
    data['PressureAI'] = this.pressureAI;
    data['TypeId'] = this.typeId;
    data['DownlinkId'] = this.downlinkId;
    data['DistributaryName'] = this.distributaryName;
    data['AreaName'] = this.areaName;
    data['ActiveAlarm'] = this.activeAlarm;
    data['AmsNo1'] = this.amsNo1;
    data['LastResponseTime1'] = this.lastResponseTime1;
    data['BatteryLevel1'] = this.batteryLevel1;
    data['TotalDamage'] = this.totalDamage;
    data['ONLINE'] = this.oNLINE;
    data['ActualPressure'] = this.actualPressure;
    return data;
  }
}
