class OmsStatusModel {
  int? omsId;
  String? chakNo;
  int? alarmCount;
  int? devStatus;
  String? lastResponseTime;
  int? areaId;
  int? distributaryId;
  String? distributoryName;
  String? areaName;
  String? lastRoutineDate;
  int? damageCount;
  int? batteryPercentage;

  OmsStatusModel(
      {this.omsId,
      this.chakNo,
      this.alarmCount,
      this.devStatus,
      this.lastResponseTime,
      this.areaId,
      this.distributaryId,
      this.distributoryName,
      this.areaName,
      this.lastRoutineDate,
      this.damageCount,
      this.batteryPercentage});

  OmsStatusModel.fromJson(Map<String, dynamic> json) {
    omsId = json['OmsId'];
    chakNo = json['ChakNo'];
    alarmCount = json['AlarmCount'];
    devStatus = json['devStatus'];
    lastResponseTime = json['LastResponseTime'];
    areaId = json['AreaId'];
    distributaryId = json['DistributaryId'];
    distributoryName = json['DistributoryName'];
    areaName = json['AreaName'];
    lastRoutineDate = json['LastRoutineDate'];
    damageCount = json['DamageCount'];
    batteryPercentage = json['BatteryPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OmsId'] = this.omsId;
    data['ChakNo'] = this.chakNo;
    data['AlarmCount'] = this.alarmCount;
    data['devStatus'] = this.devStatus;
    data['LastResponseTime'] = this.lastResponseTime;
    data['AreaId'] = this.areaId;
    data['DistributaryId'] = this.distributaryId;
    data['DistributoryName'] = this.distributoryName;
    data['AreaName'] = this.areaName;
    data['LastRoutineDate'] = this.lastRoutineDate;
    data['DamageCount'] = this.damageCount;
    data['BatteryPercentage'] = this.batteryPercentage;
    return data;
  }
}

class KOMSReportDataModel {
  int? omsId;
  int? areaId;
  int? distributaryId;
  int? gatewayId;
  int? brokerId;
  String? uID;
  String? mACAddress;
  String? publishTopic;
  String? lastResponseTime;
  int? devStatus;
  int? alarmCount;
  DateTime? deviceTime;
  String? chakNo;
  double? chakArea;
  int? chakLeaderId;
  String? khasaraNo;
  String? villageName;
  double? designPressure;
  String? coordinates;
  int? subChakQty;
  double? batteryLevel;
  double? solarVoltage;
  double? solarCurrent;
  String? deviceType;
  String? packetType;
  int? aI1;
  int? aI2;
  double? aI3;
  double? aI4;
  double? temperature;
  int? door1;
  int? door2;
  int? door3;
  int? dI4;
  int? pTFail;
  int? posFail;
  int? highTemp;
  int? motion;
  int? filterChoke;
  int? lowBat;
  int? commBat;
  int? commSlave1;
  int? commSlave2;
  int? commSlave3;
  double? firmwareVersion;
  int? iRT;
  double? pT2Valve1;
  double? posValve1;
  int? flowValve1;
  double? volValve1;
  int? highPressValve1;
  int? lowPressValve1;
  int? modeValve1;
  int? smodeValve1;
  int? runTimeValve1;
  double? pT2Valve2;
  double? posValve2;
  int? flowValve2;
  double? volValve2;
  int? highPressValve2;
  int? lowPressValve2;
  int? modeValve2;
  int? smodeValve2;
  int? runTimeValve2;
  double? pT2Valve3;
  double? posValve3;
  int? flowValve3;
  double? volValve3;
  int? highPressValve3;
  int? lowPressValve3;
  int? modeValve3;
  int? smodeValve3;
  int? runTimeValve3;
  double? pT2Valve4;
  double? posValve4;
  int? flowValve4;
  double? volValve4;
  int? highPressValve4;
  int? lowPressValve4;
  int? modeValve4;
  int? smodeValve4;
  int? runTimeValve4;
  double? pT2Valve5;
  double? posValve5;
  int? flowValve5;
  double? volValve5;
  int? highPressValve5;
  int? lowPressValve5;
  int? modeValve5;
  int? smodeValve5;
  int? runTimeValve5;
  double? pT2Valve6;
  double? posValve6;
  int? flowValve6;
  double? volValve6;
  int? highPressValve6;
  int? lowPressValve6;
  int? modeValve6;
  int? smodeValve6;
  int? runTimeValve6;
  int? updateFreq;
  double? flowSetPt1;
  double? sustPress1;
  double? redPress1;
  double? posSetPt1;
  double? flowSetPt2;
  double? sustPress2;
  double? redPress2;
  double? posSetPt2;
  double? flowSetPt3;
  double? sustPress3;
  double? redPress3;
  double? posSetPt3;
  double? flowSetPt4;
  double? sustPress4;
  double? redPress4;
  double? posSetPt4;
  double? flowSetPt5;
  double? sustPress5;
  double? redPress5;
  double? posSetPt5;
  double? flowSetPt6;
  double? sustPress6;
  double? redPress6;
  double? posSetPt6;
  int? manualOnOff1;
  int? manualOnOff2;
  int? manualOnOff3;
  int? manualOnOff4;
  int? manualOnOff5;
  int? manualOnOff6;
  int? testMin1;
  int? testMin2;
  int? testMin3;
  int? testMin4;
  int? testMin5;
  int? testMin6;
  int? sIRR1;
  int? sIRR2;
  int? sIRR3;
  int? sIRR4;
  int? sIRR5;
  int? sIRR6;
  int? emStop;
  int? subChakLeaderId1;
  int? subChakLeaderId2;
  int? subChakLeaderId3;
  int? subChakLeaderId4;
  int? subChakLeaderId5;
  int? subChakLeaderId6;
  double? subChakArea1;
  double? subChakArea2;
  double? subChakArea3;
  double? subChakArea4;
  double? subChakArea5;
  double? subChakArea6;
  int? manualValve1;
  int? manualValve2;
  int? manualValve3;
  int? manualValve4;
  int? manualValve5;
  int? manualValve6;
  int? desiredHeadReduction1;
  double? desiredHeadReduction2;
  double? desiredHeadReduction3;
  double? desiredHeadReduction4;
  double? desiredHeadReduction5;
  double? desiredHeadReduction6;
  int? downlinkId;
  String? areaName;
  String? distName;
  String? firstName;
  String? mobileno;
  String? subChakLeader1;
  String? mobileno1;
  String? subChakLeader2;
  String? mobileno2;
  String? subChakLeader3;
  String? mobileno3;
  String? subChakLeader4;
  String? mobileno4;
  String? subChakLeader5;
  String? mobileno5;
  String? subChakLeader6;
  String? mobileno6;
  String? gatewayName;
  String? downlinkName;
  String? distributoryName;
  String? areaName1;
  String? lastRoutineDate;
  double? damageCount;
  double? batteryPercentage;

  KOMSReportDataModel(
      {this.omsId,
      this.areaId,
      this.distributaryId,
      this.gatewayId,
      this.brokerId,
      this.uID,
      this.mACAddress,
      this.publishTopic,
      this.lastResponseTime,
      this.devStatus,
      this.alarmCount,
      this.deviceTime,
      this.chakNo,
      this.chakArea,
      this.chakLeaderId,
      this.khasaraNo,
      this.villageName,
      this.designPressure,
      this.coordinates,
      this.subChakQty,
      this.batteryLevel,
      this.solarVoltage,
      this.solarCurrent,
      this.deviceType,
      this.packetType,
      this.aI1,
      this.aI2,
      this.aI3,
      this.aI4,
      this.temperature,
      this.door1,
      this.door2,
      this.door3,
      this.dI4,
      this.pTFail,
      this.posFail,
      this.highTemp,
      this.motion,
      this.filterChoke,
      this.lowBat,
      this.commBat,
      this.commSlave1,
      this.commSlave2,
      this.commSlave3,
      this.firmwareVersion,
      this.iRT,
      this.pT2Valve1,
      this.posValve1,
      this.flowValve1,
      this.volValve1,
      this.highPressValve1,
      this.lowPressValve1,
      this.modeValve1,
      this.smodeValve1,
      this.runTimeValve1,
      this.pT2Valve2,
      this.posValve2,
      this.flowValve2,
      this.volValve2,
      this.highPressValve2,
      this.lowPressValve2,
      this.modeValve2,
      this.smodeValve2,
      this.runTimeValve2,
      this.pT2Valve3,
      this.posValve3,
      this.flowValve3,
      this.volValve3,
      this.highPressValve3,
      this.lowPressValve3,
      this.modeValve3,
      this.smodeValve3,
      this.runTimeValve3,
      this.pT2Valve4,
      this.posValve4,
      this.flowValve4,
      this.volValve4,
      this.highPressValve4,
      this.lowPressValve4,
      this.modeValve4,
      this.smodeValve4,
      this.runTimeValve4,
      this.pT2Valve5,
      this.posValve5,
      this.flowValve5,
      this.volValve5,
      this.highPressValve5,
      this.lowPressValve5,
      this.modeValve5,
      this.smodeValve5,
      this.runTimeValve5,
      this.pT2Valve6,
      this.posValve6,
      this.flowValve6,
      this.volValve6,
      this.highPressValve6,
      this.lowPressValve6,
      this.modeValve6,
      this.smodeValve6,
      this.runTimeValve6,
      this.updateFreq,
      this.flowSetPt1,
      this.sustPress1,
      this.redPress1,
      this.posSetPt1,
      this.flowSetPt2,
      this.sustPress2,
      this.redPress2,
      this.posSetPt2,
      this.flowSetPt3,
      this.sustPress3,
      this.redPress3,
      this.posSetPt3,
      this.flowSetPt4,
      this.sustPress4,
      this.redPress4,
      this.posSetPt4,
      this.flowSetPt5,
      this.sustPress5,
      this.redPress5,
      this.posSetPt5,
      this.flowSetPt6,
      this.sustPress6,
      this.redPress6,
      this.posSetPt6,
      this.manualOnOff1,
      this.manualOnOff2,
      this.manualOnOff3,
      this.manualOnOff4,
      this.manualOnOff5,
      this.manualOnOff6,
      this.testMin1,
      this.testMin2,
      this.testMin3,
      this.testMin4,
      this.testMin5,
      this.testMin6,
      this.sIRR1,
      this.sIRR2,
      this.sIRR3,
      this.sIRR4,
      this.sIRR5,
      this.sIRR6,
      this.emStop,
      this.subChakLeaderId1,
      this.subChakLeaderId2,
      this.subChakLeaderId3,
      this.subChakLeaderId4,
      this.subChakLeaderId5,
      this.subChakLeaderId6,
      this.subChakArea1,
      this.subChakArea2,
      this.subChakArea3,
      this.subChakArea4,
      this.subChakArea5,
      this.subChakArea6,
      this.manualValve1,
      this.manualValve2,
      this.manualValve3,
      this.manualValve4,
      this.manualValve5,
      this.manualValve6,
      this.desiredHeadReduction1,
      this.desiredHeadReduction2,
      this.desiredHeadReduction3,
      this.desiredHeadReduction4,
      this.desiredHeadReduction5,
      this.desiredHeadReduction6,
      this.downlinkId,
      this.areaName,
      this.distName,
      this.firstName,
      this.mobileno,
      this.subChakLeader1,
      this.mobileno1,
      this.subChakLeader2,
      this.mobileno2,
      this.subChakLeader3,
      this.mobileno3,
      this.subChakLeader4,
      this.mobileno4,
      this.subChakLeader5,
      this.mobileno5,
      this.subChakLeader6,
      this.mobileno6,
      this.gatewayName,
      this.downlinkName,
      this.distributoryName,
      this.areaName1,
      this.lastRoutineDate,
      this.damageCount,
      this.batteryPercentage});

  KOMSReportDataModel.fromJson(Map<String, dynamic> json) {
    omsId = json['OmsId'];
    areaId = json['AreaId'];
    distributaryId = json['DistributaryId'];
    gatewayId = json['GatewayId'];
    brokerId = json['BrokerId'];
    uID = json['UID'];
    mACAddress = json['MACAddress'];
    publishTopic = json['PublishTopic'];
    lastResponseTime = json['LastResponseTime'];
    devStatus = json['devStatus'];
    alarmCount = json['AlarmCount'];
    deviceTime = json['DeviceTime'];
    chakNo = json['ChakNo'];
    chakArea = json['ChakArea'];
    chakLeaderId = json['ChakLeaderId'];
    khasaraNo = json['KhasaraNo'];
    villageName = json['VillageName'];
    designPressure = json['DesignPressure'];
    coordinates = json['Coordinates'];
    subChakQty = json['SubChakQty'];
    batteryLevel = json['BatteryLevel'];
    solarVoltage = json['SolarVoltage'];
    solarCurrent = json['SolarCurrent'];
    deviceType = json['DeviceType'];
    packetType = json['PacketType'];
    aI1 = json['AI1'];
    aI2 = json['AI2'];
    aI3 = json['AI3'];
    aI4 = json['AI4'];
    temperature = json['Temperature'];
    door1 = json['Door1'];
    door2 = json['Door2'];
    door3 = json['Door3'];
    dI4 = json['DI4'];
    pTFail = json['PT_Fail'];
    posFail = json['Pos_Fail'];
    highTemp = json['High_Temp'];
    motion = json['Motion'];
    filterChoke = json['Filter_Choke'];
    lowBat = json['Low_Bat'];
    commBat = json['Comm_Bat'];
    commSlave1 = json['Comm_Slave1'];
    commSlave2 = json['Comm_Slave2'];
    commSlave3 = json['Comm_Slave3'];
    firmwareVersion = json['FirmwareVersion'];
    iRT = json['IRT'];
    pT2Valve1 = json['PT2Valve1'];
    posValve1 = json['PosValve1'];
    flowValve1 = json['FlowValve1'];
    volValve1 = json['VolValve1'];
    highPressValve1 = json['HighPressValve1'];
    lowPressValve1 = json['LowPressValve1'];
    modeValve1 = json['ModeValve1'];
    smodeValve1 = json['SmodeValve1'];
    runTimeValve1 = json['RunTimeValve1'];
    pT2Valve2 = json['PT2Valve2'];
    posValve2 = json['PosValve2'];
    flowValve2 = json['FlowValve2'];
    volValve2 = json['VolValve2'];
    highPressValve2 = json['HighPressValve2'];
    lowPressValve2 = json['LowPressValve2'];
    modeValve2 = json['ModeValve2'];
    smodeValve2 = json['SmodeValve2'];
    runTimeValve2 = json['RunTimeValve2'];
    pT2Valve3 = json['PT2Valve3'];
    posValve3 = json['PosValve3'];
    flowValve3 = json['FlowValve3'];
    volValve3 = json['VolValve3'];
    highPressValve3 = json['HighPressValve3'];
    lowPressValve3 = json['LowPressValve3'];
    modeValve3 = json['ModeValve3'];
    smodeValve3 = json['SmodeValve3'];
    runTimeValve3 = json['RunTimeValve3'];
    pT2Valve4 = json['PT2Valve4'];
    posValve4 = json['PosValve4'];
    flowValve4 = json['FlowValve4'];
    volValve4 = json['VolValve4'];
    highPressValve4 = json['HighPressValve4'];
    lowPressValve4 = json['LowPressValve4'];
    modeValve4 = json['ModeValve4'];
    smodeValve4 = json['SmodeValve4'];
    runTimeValve4 = json['RunTimeValve4'];
    pT2Valve5 = json['PT2Valve5'];
    posValve5 = json['PosValve5'];
    flowValve5 = json['FlowValve5'];
    volValve5 = json['VolValve5'];
    highPressValve5 = json['HighPressValve5'];
    lowPressValve5 = json['LowPressValve5'];
    modeValve5 = json['ModeValve5'];
    smodeValve5 = json['SmodeValve5'];
    runTimeValve5 = json['RunTimeValve5'];
    pT2Valve6 = json['PT2Valve6'];
    posValve6 = json['PosValve6'];
    flowValve6 = json['FlowValve6'];
    volValve6 = json['VolValve6'];
    highPressValve6 = json['HighPressValve6'];
    lowPressValve6 = json['LowPressValve6'];
    modeValve6 = json['ModeValve6'];
    smodeValve6 = json['SmodeValve6'];
    runTimeValve6 = json['RunTimeValve6'];
    updateFreq = json['UpdateFreq'];
    flowSetPt1 = json['FlowSetPt1'];
    sustPress1 = json['sustPress1'];
    redPress1 = json['redPress1'];
    posSetPt1 = json['PosSetPt1'];
    flowSetPt2 = json['FlowSetPt2'];
    sustPress2 = json['sustPress2'];
    redPress2 = json['redPress2'];
    posSetPt2 = json['PosSetPt2'];
    flowSetPt3 = json['FlowSetPt3'];
    sustPress3 = json['sustPress3'];
    redPress3 = json['redPress3'];
    posSetPt3 = json['PosSetPt3'];
    flowSetPt4 = json['FlowSetPt4'];
    sustPress4 = json['sustPress4'];
    redPress4 = json['redPress4'];
    posSetPt4 = json['PosSetPt4'];
    flowSetPt5 = json['FlowSetPt5'];
    sustPress5 = json['sustPress5'];
    redPress5 = json['redPress5'];
    posSetPt5 = json['PosSetPt5'];
    flowSetPt6 = json['FlowSetPt6'];
    sustPress6 = json['sustPress6'];
    redPress6 = json['redPress6'];
    posSetPt6 = json['PosSetPt6'];
    manualOnOff1 = json['ManualOnOff1'];
    manualOnOff2 = json['ManualOnOff2'];
    manualOnOff3 = json['ManualOnOff3'];
    manualOnOff4 = json['ManualOnOff4'];
    manualOnOff5 = json['ManualOnOff5'];
    manualOnOff6 = json['ManualOnOff6'];
    testMin1 = json['TestMin1'];
    testMin2 = json['TestMin2'];
    testMin3 = json['TestMin3'];
    testMin4 = json['TestMin4'];
    testMin5 = json['TestMin5'];
    testMin6 = json['TestMin6'];
    sIRR1 = json['SIRR1'];
    sIRR2 = json['SIRR2'];
    sIRR3 = json['SIRR3'];
    sIRR4 = json['SIRR4'];
    sIRR5 = json['SIRR5'];
    sIRR6 = json['SIRR6'];
    emStop = json['EmStop'];
    subChakLeaderId1 = json['SubChakLeaderId1'];
    subChakLeaderId2 = json['SubChakLeaderId2'];
    subChakLeaderId3 = json['SubChakLeaderId3'];
    subChakLeaderId4 = json['SubChakLeaderId4'];
    subChakLeaderId5 = json['SubChakLeaderId5'];
    subChakLeaderId6 = json['SubChakLeaderId6'];
    subChakArea1 = json['SubChakArea1'];
    subChakArea2 = json['SubChakArea2'];
    subChakArea3 = json['SubChakArea3'];
    subChakArea4 = json['SubChakArea4'];
    subChakArea5 = json['SubChakArea5'];
    subChakArea6 = json['SubChakArea6'];
    manualValve1 = json['ManualValve1'];
    manualValve2 = json['ManualValve2'];
    manualValve3 = json['ManualValve3'];
    manualValve4 = json['ManualValve4'];
    manualValve5 = json['ManualValve5'];
    manualValve6 = json['ManualValve6'];
    desiredHeadReduction1 = json['DesiredHeadReduction1'];
    desiredHeadReduction2 = json['DesiredHeadReduction2'];
    desiredHeadReduction3 = json['DesiredHeadReduction3'];
    desiredHeadReduction4 = json['DesiredHeadReduction4'];
    desiredHeadReduction5 = json['DesiredHeadReduction5'];
    desiredHeadReduction6 = json['DesiredHeadReduction6'];
    downlinkId = json['DownlinkId'];
    areaName = json['AreaName'];
    distName = json['DistName'];
    firstName = json['FirstName'];
    mobileno = json['mobileno'];
    subChakLeader1 = json['SubChakLeader1'];
    mobileno1 = json['mobileno1'];
    subChakLeader2 = json['SubChakLeader2'];
    mobileno2 = json['mobileno2'];
    subChakLeader3 = json['SubChakLeader3'];
    mobileno3 = json['mobileno3'];
    subChakLeader4 = json['SubChakLeader4'];
    mobileno4 = json['mobileno4'];
    subChakLeader5 = json['SubChakLeader5'];
    mobileno5 = json['mobileno5'];
    subChakLeader6 = json['SubChakLeader6'];
    mobileno6 = json['mobileno6'];
    gatewayName = json['GatewayName'];
    downlinkName = json['DownlinkName'];
    distributoryName = json['DistributoryName'];
    areaName1 = json['AreaName1'];
    lastRoutineDate = json['LastRoutineDate'];
    damageCount = json['DamageCount'];
    batteryPercentage = json['BatteryPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OmsId'] = this.omsId;
    data['AreaId'] = this.areaId;
    data['DistributaryId'] = this.distributaryId;
    data['GatewayId'] = this.gatewayId;
    data['BrokerId'] = this.brokerId;
    data['UID'] = this.uID;
    data['MACAddress'] = this.mACAddress;
    data['PublishTopic'] = this.publishTopic;
    data['LastResponseTime'] = this.lastResponseTime;
    data['devStatus'] = this.devStatus;
    data['AlarmCount'] = this.alarmCount;
    data['DeviceTime'] = this.deviceTime;
    data['ChakNo'] = this.chakNo;
    data['ChakArea'] = this.chakArea;
    data['ChakLeaderId'] = this.chakLeaderId;
    data['KhasaraNo'] = this.khasaraNo;
    data['VillageName'] = this.villageName;
    data['DesignPressure'] = this.designPressure;
    data['Coordinates'] = this.coordinates;
    data['SubChakQty'] = this.subChakQty;
    data['BatteryLevel'] = this.batteryLevel;
    data['SolarVoltage'] = this.solarVoltage;
    data['SolarCurrent'] = this.solarCurrent;
    data['DeviceType'] = this.deviceType;
    data['PacketType'] = this.packetType;
    data['AI1'] = this.aI1;
    data['AI2'] = this.aI2;
    data['AI3'] = this.aI3;
    data['AI4'] = this.aI4;
    data['Temperature'] = this.temperature;
    data['Door1'] = this.door1;
    data['Door2'] = this.door2;
    data['Door3'] = this.door3;
    data['DI4'] = this.dI4;
    data['PT_Fail'] = this.pTFail;
    data['Pos_Fail'] = this.posFail;
    data['High_Temp'] = this.highTemp;
    data['Motion'] = this.motion;
    data['Filter_Choke'] = this.filterChoke;
    data['Low_Bat'] = this.lowBat;
    data['Comm_Bat'] = this.commBat;
    data['Comm_Slave1'] = this.commSlave1;
    data['Comm_Slave2'] = this.commSlave2;
    data['Comm_Slave3'] = this.commSlave3;
    data['FirmwareVersion'] = this.firmwareVersion;
    data['IRT'] = this.iRT;
    data['PT2Valve1'] = this.pT2Valve1;
    data['PosValve1'] = this.posValve1;
    data['FlowValve1'] = this.flowValve1;
    data['VolValve1'] = this.volValve1;
    data['HighPressValve1'] = this.highPressValve1;
    data['LowPressValve1'] = this.lowPressValve1;
    data['ModeValve1'] = this.modeValve1;
    data['SmodeValve1'] = this.smodeValve1;
    data['RunTimeValve1'] = this.runTimeValve1;
    data['PT2Valve2'] = this.pT2Valve2;
    data['PosValve2'] = this.posValve2;
    data['FlowValve2'] = this.flowValve2;
    data['VolValve2'] = this.volValve2;
    data['HighPressValve2'] = this.highPressValve2;
    data['LowPressValve2'] = this.lowPressValve2;
    data['ModeValve2'] = this.modeValve2;
    data['SmodeValve2'] = this.smodeValve2;
    data['RunTimeValve2'] = this.runTimeValve2;
    data['PT2Valve3'] = this.pT2Valve3;
    data['PosValve3'] = this.posValve3;
    data['FlowValve3'] = this.flowValve3;
    data['VolValve3'] = this.volValve3;
    data['HighPressValve3'] = this.highPressValve3;
    data['LowPressValve3'] = this.lowPressValve3;
    data['ModeValve3'] = this.modeValve3;
    data['SmodeValve3'] = this.smodeValve3;
    data['RunTimeValve3'] = this.runTimeValve3;
    data['PT2Valve4'] = this.pT2Valve4;
    data['PosValve4'] = this.posValve4;
    data['FlowValve4'] = this.flowValve4;
    data['VolValve4'] = this.volValve4;
    data['HighPressValve4'] = this.highPressValve4;
    data['LowPressValve4'] = this.lowPressValve4;
    data['ModeValve4'] = this.modeValve4;
    data['SmodeValve4'] = this.smodeValve4;
    data['RunTimeValve4'] = this.runTimeValve4;
    data['PT2Valve5'] = this.pT2Valve5;
    data['PosValve5'] = this.posValve5;
    data['FlowValve5'] = this.flowValve5;
    data['VolValve5'] = this.volValve5;
    data['HighPressValve5'] = this.highPressValve5;
    data['LowPressValve5'] = this.lowPressValve5;
    data['ModeValve5'] = this.modeValve5;
    data['SmodeValve5'] = this.smodeValve5;
    data['RunTimeValve5'] = this.runTimeValve5;
    data['PT2Valve6'] = this.pT2Valve6;
    data['PosValve6'] = this.posValve6;
    data['FlowValve6'] = this.flowValve6;
    data['VolValve6'] = this.volValve6;
    data['HighPressValve6'] = this.highPressValve6;
    data['LowPressValve6'] = this.lowPressValve6;
    data['ModeValve6'] = this.modeValve6;
    data['SmodeValve6'] = this.smodeValve6;
    data['RunTimeValve6'] = this.runTimeValve6;
    data['UpdateFreq'] = this.updateFreq;
    data['FlowSetPt1'] = this.flowSetPt1;
    data['sustPress1'] = this.sustPress1;
    data['redPress1'] = this.redPress1;
    data['PosSetPt1'] = this.posSetPt1;
    data['FlowSetPt2'] = this.flowSetPt2;
    data['sustPress2'] = this.sustPress2;
    data['redPress2'] = this.redPress2;
    data['PosSetPt2'] = this.posSetPt2;
    data['FlowSetPt3'] = this.flowSetPt3;
    data['sustPress3'] = this.sustPress3;
    data['redPress3'] = this.redPress3;
    data['PosSetPt3'] = this.posSetPt3;
    data['FlowSetPt4'] = this.flowSetPt4;
    data['sustPress4'] = this.sustPress4;
    data['redPress4'] = this.redPress4;
    data['PosSetPt4'] = this.posSetPt4;
    data['FlowSetPt5'] = this.flowSetPt5;
    data['sustPress5'] = this.sustPress5;
    data['redPress5'] = this.redPress5;
    data['PosSetPt5'] = this.posSetPt5;
    data['FlowSetPt6'] = this.flowSetPt6;
    data['sustPress6'] = this.sustPress6;
    data['redPress6'] = this.redPress6;
    data['PosSetPt6'] = this.posSetPt6;
    data['ManualOnOff1'] = this.manualOnOff1;
    data['ManualOnOff2'] = this.manualOnOff2;
    data['ManualOnOff3'] = this.manualOnOff3;
    data['ManualOnOff4'] = this.manualOnOff4;
    data['ManualOnOff5'] = this.manualOnOff5;
    data['ManualOnOff6'] = this.manualOnOff6;
    data['TestMin1'] = this.testMin1;
    data['TestMin2'] = this.testMin2;
    data['TestMin3'] = this.testMin3;
    data['TestMin4'] = this.testMin4;
    data['TestMin5'] = this.testMin5;
    data['TestMin6'] = this.testMin6;
    data['SIRR1'] = this.sIRR1;
    data['SIRR2'] = this.sIRR2;
    data['SIRR3'] = this.sIRR3;
    data['SIRR4'] = this.sIRR4;
    data['SIRR5'] = this.sIRR5;
    data['SIRR6'] = this.sIRR6;
    data['EmStop'] = this.emStop;
    data['SubChakLeaderId1'] = this.subChakLeaderId1;
    data['SubChakLeaderId2'] = this.subChakLeaderId2;
    data['SubChakLeaderId3'] = this.subChakLeaderId3;
    data['SubChakLeaderId4'] = this.subChakLeaderId4;
    data['SubChakLeaderId5'] = this.subChakLeaderId5;
    data['SubChakLeaderId6'] = this.subChakLeaderId6;
    data['SubChakArea1'] = this.subChakArea1;
    data['SubChakArea2'] = this.subChakArea2;
    data['SubChakArea3'] = this.subChakArea3;
    data['SubChakArea4'] = this.subChakArea4;
    data['SubChakArea5'] = this.subChakArea5;
    data['SubChakArea6'] = this.subChakArea6;
    data['ManualValve1'] = this.manualValve1;
    data['ManualValve2'] = this.manualValve2;
    data['ManualValve3'] = this.manualValve3;
    data['ManualValve4'] = this.manualValve4;
    data['ManualValve5'] = this.manualValve5;
    data['ManualValve6'] = this.manualValve6;
    data['DesiredHeadReduction1'] = this.desiredHeadReduction1;
    data['DesiredHeadReduction2'] = this.desiredHeadReduction2;
    data['DesiredHeadReduction3'] = this.desiredHeadReduction3;
    data['DesiredHeadReduction4'] = this.desiredHeadReduction4;
    data['DesiredHeadReduction5'] = this.desiredHeadReduction5;
    data['DesiredHeadReduction6'] = this.desiredHeadReduction6;
    data['DownlinkId'] = this.downlinkId;
    data['AreaName'] = this.areaName;
    data['DistName'] = this.distName;
    data['FirstName'] = this.firstName;
    data['mobileno'] = this.mobileno;
    data['SubChakLeader1'] = this.subChakLeader1;
    data['mobileno1'] = this.mobileno1;
    data['SubChakLeader2'] = this.subChakLeader2;
    data['mobileno2'] = this.mobileno2;
    data['SubChakLeader3'] = this.subChakLeader3;
    data['mobileno3'] = this.mobileno3;
    data['SubChakLeader4'] = this.subChakLeader4;
    data['mobileno4'] = this.mobileno4;
    data['SubChakLeader5'] = this.subChakLeader5;
    data['mobileno5'] = this.mobileno5;
    data['SubChakLeader6'] = this.subChakLeader6;
    data['mobileno6'] = this.mobileno6;
    data['GatewayName'] = this.gatewayName;
    data['DownlinkName'] = this.downlinkName;
    data['DistributoryName'] = this.distributoryName;
    data['AreaName1'] = this.areaName1;
    data['LastRoutineDate'] = this.lastRoutineDate;
    data['DamageCount'] = this.damageCount;
    data['BatteryPercentage'] = this.batteryPercentage;
    return data;
  }
}
