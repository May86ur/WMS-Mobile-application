import 'package:WMS_Application/Operations/CommonFunction.dart';

class OmsMasterModel {
  dynamic omsId;
  dynamic areaId;
  dynamic distributaryId;
  dynamic brokerId;
  dynamic gateWayId;
  String? uID;
  String? mACAddress;
  String? publishTopic;
  dynamic lastResponseTime;
  String? deviceTime;
  String? chakNo;
  dynamic chakArea;
  dynamic chakLeaderId;
  String? khasaraNo;
  String? villageName;
  String? coordinates;
  dynamic subChakQty;
  dynamic batteryType;
  dynamic batteryLevel;
  dynamic batteryCurrent;
  dynamic loadVoltage;
  dynamic loadCurrent;
  dynamic solarVoltage;
  dynamic solarCurrent;
  String? deviceType;
  String? packetType;
  dynamic aI1;
  dynamic aI2;
  dynamic aI3;
  dynamic aI4;
  dynamic temperature;
  dynamic door1;
  dynamic door2;
  dynamic door3;
  dynamic dI4;
  dynamic dI5;
  dynamic dI6;
  dynamic pTFail;
  dynamic posFail;
  dynamic highTemp;
  dynamic motion;
  dynamic filterChoke;
  dynamic lowBat;
  dynamic commBat;
  dynamic commSlave1;
  dynamic commSlave2;
  dynamic commSlave3;
  dynamic firmwareVersion;
  dynamic duty;
  dynamic availableResidualHead;
  dynamic iRT;
  dynamic pT2Valve1;
  dynamic posValve1;
  dynamic flowValve1;
  dynamic volValve1;
  dynamic highPressValve1;
  dynamic lowPressValve1;
  dynamic modeValve1;
  dynamic smodeValve1;
  dynamic runTimeValve1;
  dynamic pT2Valve2;
  dynamic posValve2;
  dynamic flowValve2;
  dynamic volValve2;
  dynamic lowPressValve2;
  dynamic highPressValve2;
  dynamic modeValve2;
  dynamic smodeValve2;
  dynamic runTimeValve2;
  dynamic pT2Valve3;
  dynamic posValve3;
  dynamic flowValve3;
  dynamic volValve3;
  dynamic highPressValve3;
  dynamic lowPressValve3;
  dynamic modeValve3;
  dynamic smodeValve3;
  dynamic runTimeValve3;
  dynamic pT2Valve4;
  dynamic posValve4;
  dynamic flowValve4;
  dynamic volValve4;
  dynamic highPressValve4;
  dynamic lowPressValve4;
  dynamic modeValve4;
  dynamic smodeValve4;
  dynamic runTimeValve4;
  dynamic pT2Valve5;
  dynamic posValve5;
  dynamic flowValve5;
  dynamic volValve5;
  dynamic highPressValve5;
  dynamic lowPressValve5;
  dynamic modeValve5;
  dynamic smodeValve5;
  dynamic runTimeValve5;
  dynamic pT2Valve6;
  dynamic posValve6;
  dynamic flowValve6;
  dynamic volValve6;
  dynamic highPressValve6;
  dynamic lowPressValve6;
  dynamic modeValve6;
  dynamic smodeValve6;
  dynamic runTimeValve6;
  dynamic updateFreq;
  dynamic flowSetPt1;
  dynamic sustPress1;
  dynamic redPress1;
  dynamic posSetPt1;
  dynamic flowSetPt2;
  dynamic sustPress2;
  dynamic redPress2;
  dynamic posSetPt2;
  dynamic flowSetPt3;
  dynamic sustPress3;
  dynamic redPress3;
  dynamic posSetPt3;
  dynamic flowSetPt4;
  dynamic sustPress4;
  dynamic redPress4;
  dynamic posSetPt4;
  dynamic flowSetPt5;
  dynamic sustPress5;
  dynamic redPress5;
  dynamic posSetPt5;
  dynamic flowSetPt6;
  dynamic sustPress6;
  dynamic redPress6;
  dynamic posSetPt6;
  dynamic manualOnOff1;
  dynamic manualOnOff2;
  dynamic manualOnOff3;
  dynamic manualOnOff4;
  dynamic manualOnOff5;
  dynamic manualOnOff6;
  dynamic testMin1;
  dynamic testMin2;
  dynamic testMin3;
  dynamic testMin4;
  dynamic testMin5;
  dynamic testMin6;
  dynamic sIRR1;
  dynamic sIRR2;
  dynamic sIRR3;
  dynamic sIRR4;
  dynamic sIRR5;
  dynamic sIRR6;
  dynamic emStop;
  dynamic subChakLeaderId1;
  dynamic subChakLeaderId2;
  dynamic subChakLeaderId3;
  dynamic subChakLeaderId4;
  dynamic subChakLeaderId5;
  dynamic subChakLeaderId6;
  dynamic subChakArea1;
  dynamic subChakArea2;
  dynamic subChakArea3;
  dynamic subChakArea4;
  dynamic subChakArea5;
  dynamic subChakArea6;
  dynamic manualValve1;
  dynamic manualValve2;
  dynamic manualValve3;
  dynamic manualValve4;
  dynamic manualValve5;
  dynamic manualValve6;
  dynamic desiredHeadReduction1;
  dynamic desiredHeadReduction2;
  dynamic desiredHeadReduction3;
  dynamic desiredHeadReduction4;
  dynamic desiredHeadReduction5;
  dynamic desiredHeadReduction6;
  dynamic calculatedVolume;
  dynamic typeId;

  dynamic inletPipeSize;
  dynamic ouletPipe110mm;
  dynamic ouletPipe90mm;
  dynamic ouletPipe75mm;
  dynamic ouletPipe63mm;
  dynamic isChecking;

  String? controlType;
  dynamic lowInletPT;
  dynamic highOutletPT;
  dynamic allValveOpen;
  dynamic anyValveClosed;
  dynamic sIRR;
  dynamic outletPT;
  dynamic valvePosition;
  dynamic flow;
  dynamic dailyVolume;
  dynamic runTime;
  dynamic mode;
  dynamic smode;
  dynamic flowMeterFlow;
  dynamic flowMeterVolume;
  dynamic rmode;
  dynamic volumeV1;
  dynamic volumeV2;
  dynamic volumeV3;
  dynamic volumeV4;
  dynamic volumeV5;
  dynamic volumeV6;
  dynamic volumeV7;
  dynamic volumeV8;
  dynamic statusValve1;
  dynamic statusValve2;
  dynamic statusValve3;
  dynamic statusValve4;
  dynamic statusValve5;
  dynamic statusValve6;
  dynamic statusValve7;
  dynamic statusValve8;
  dynamic downlinkId;
  dynamic batConstantReadingCount;
  dynamic updateBatDateTime;
  String? distributaryName;
  String? areaName;
  dynamic activeAlarm;
  String? chakNo1;
  String? lastResponseTime1;
  dynamic batteryLevel1;
  dynamic totalDamage;
  String? oNLINE;
  String? schedule;
  dynamic rmsId;
  String? rmsNo;
  String? controllertype;
  bool? isIrrigationStarted;

  OmsMasterModel(
      {this.omsId,
      this.areaId,
      this.distributaryId,
      this.brokerId,
      this.gateWayId,
      this.uID,
      this.mACAddress,
      this.publishTopic,
      this.lastResponseTime,
      this.deviceTime,
      this.chakNo,
      this.chakArea,
      this.chakLeaderId,
      this.khasaraNo,
      this.villageName,
      this.coordinates,
      this.subChakQty,
      this.batteryType,
      this.batteryLevel,
      this.batteryCurrent,
      this.loadVoltage,
      this.loadCurrent,
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
      this.dI5,
      this.dI6,
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
      this.duty,
      this.availableResidualHead,
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
      this.calculatedVolume,
      this.typeId,
      this.inletPipeSize,
      this.ouletPipe110mm,
      this.ouletPipe90mm,
      this.ouletPipe75mm,
      this.ouletPipe63mm,
      this.isChecking,
      this.controlType,
      this.lowInletPT,
      this.highOutletPT,
      this.allValveOpen,
      this.anyValveClosed,
      this.sIRR,
      this.outletPT,
      this.valvePosition,
      this.flow,
      this.dailyVolume,
      this.runTime,
      this.mode,
      this.smode,
      this.flowMeterFlow,
      this.flowMeterVolume,
      this.rmode,
      this.volumeV1,
      this.volumeV2,
      this.volumeV3,
      this.volumeV4,
      this.volumeV5,
      this.volumeV6,
      this.volumeV7,
      this.volumeV8,
      this.statusValve1,
      this.statusValve2,
      this.statusValve3,
      this.statusValve4,
      this.statusValve5,
      this.statusValve6,
      this.statusValve7,
      this.statusValve8,
      this.downlinkId,
      this.batConstantReadingCount,
      this.updateBatDateTime,
      this.distributaryName,
      this.areaName,
      this.activeAlarm,
      this.chakNo1,
      this.lastResponseTime1,
      this.batteryLevel1,
      this.totalDamage,
      this.oNLINE,
      this.schedule,
      this.rmsNo,
      this.controllertype});

  OmsMasterModel.fromJson(Map<String, dynamic> json) {
    omsId = json['OmsId'];
    areaId = json['AreaId'];
    distributaryId = json['DistributaryId'];
    brokerId = json['BrokerId'];
    gateWayId = json['GateWayId'];
    uID = json['UID'];
    mACAddress = json['MACAddress'];
    publishTopic = json['PublishTopic'];
    lastResponseTime = json['LastResponseTime'];
    deviceTime = json['DeviceTime'];
    chakNo = json['ChakNo'];
    chakArea = json['ChakArea'];
    chakLeaderId = json['ChakLeaderId'];
    khasaraNo = json['KhasaraNo'];
    villageName = json['VillageName'];
    coordinates = json['Coordinates'];
    subChakQty = json['SubChakQty'];
    batteryType = json['BatteryType'];
    batteryLevel = json['BatteryLevel'];
    batteryCurrent = json['BatteryCurrent'] ?? 0.0;
    loadVoltage = json['LoadVoltage'];
    loadCurrent = json['LoadCurrent'];
    solarVoltage = json['SolarVoltage'] ?? 0.0;
    solarCurrent = json['SolarCurrent'] ?? 0.0;
    deviceType = json['DeviceType'];
    packetType = json['PacketType'];
    aI1 = json['AI1'];
    aI2 = json['AI2'];
    aI3 = json['AI3'];
    aI4 = json['AI4'];
    temperature = json['Temperature'] ?? 0.0;
    door1 = json['Door1'] ?? 0;
    door2 = json['Door2'] ?? 0;
    door3 = json['Door3'] ?? 0;
    dI4 = json['DI4'];
    dI5 = json['DI5'];
    dI6 = json['DI6'];
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
    duty = json['Duty'];
    availableResidualHead = json['AvailableResidualHead'];
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
    isIrrigationStarted = getBoolValue(sIRR1) ||
        getBoolValue(sIRR2) ||
        getBoolValue(sIRR3) ||
        getBoolValue(sIRR4) ||
        getBoolValue(sIRR5) ||
        getBoolValue(sIRR6);
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
    calculatedVolume = json['CalculatedVolume'];
    typeId = json['TypeId'];

    inletPipeSize = json['InletPipeSize'];
    ouletPipe110mm = json['OuletPipe_110mm'];
    ouletPipe90mm = json['OuletPipe_90mm'];
    ouletPipe75mm = json['OuletPipe_75mm'];
    ouletPipe63mm = json['OuletPipe_63mm'];
    isChecking = json['IsChecking'];
    controlType = json['ControlType'];
    lowInletPT = json['LowInletPT'];
    highOutletPT = json['HighOutletPT'];
    allValveOpen = json['AllValveOpen'];
    anyValveClosed = json['AnyValveClosed'];
    sIRR = json['SIRR'];
    outletPT = json['OutletPT'];
    valvePosition = json['ValvePosition'];
    flow = json['Flow'];
    dailyVolume = json['DailyVolume'];
    runTime = json['RunTime'];
    mode = json['Mode'];
    smode = json['Smode'];
    flowMeterFlow = json['FlowMeterFlow'];
    flowMeterVolume = json['FlowMeterVolume'];
    rmode = json['Rmode'];
    volumeV1 = json['VolumeV1'];
    volumeV2 = json['VolumeV2'];
    volumeV3 = json['VolumeV3'];
    volumeV4 = json['VolumeV4'];
    volumeV5 = json['VolumeV5'];
    volumeV6 = json['VolumeV6'];
    volumeV7 = json['VolumeV7'];
    volumeV8 = json['VolumeV8'];
    statusValve1 = json['StatusValve1'];
    statusValve2 = json['StatusValve2'];
    statusValve3 = json['StatusValve3'];
    statusValve4 = json['StatusValve4'];
    statusValve5 = json['StatusValve5'];
    statusValve6 = json['StatusValve6'];
    statusValve7 = json['StatusValve7'];
    statusValve8 = json['StatusValve8'];

    downlinkId = json['DownlinkId'];
    batConstantReadingCount = json['BatConstantReadingCount'];
    updateBatDateTime = json['UpdateBatDateTime'];
    distributaryName = json['DistributaryName'];
    areaName = json['AreaName'];
    activeAlarm = json['ActiveAlarm'];
    chakNo1 = json['ChakNo1'];
    lastResponseTime1 = json['LastResponseTime1'];
    batteryLevel1 = json['BatteryLevel1'] ?? 0.0;
    totalDamage = json['TotalDamage'] ?? 0;
    oNLINE = json['ONLINE'];
    schedule = json['Schedule'];
    if (json.keys.where((element) => element == 'RmsId').isNotEmpty)
      rmsId = json['RmsId'] ?? 0;
    else
      rmsId = 0;
    if (json.keys.where((element) => element == 'RmsNo').isNotEmpty)
      rmsNo = json['RmsNo'] ?? '';
    else
      rmsNo = '';

    if (json.keys.where((element) => element == 'ControlType').isNotEmpty)
      controllertype = json['ControlType'] ?? '';
    else
      controllertype = '';
  }
}
