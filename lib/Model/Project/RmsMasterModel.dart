class RMSMastermodel {
  int? rmsId;
  int? areaId;
  int? distributaryId;
  int? brokerId;
  int? gateWayId;
  String? uID;
  String? mACAddress;
  String? publishTopic;
  String? lastResponseTime;
  String? deviceTime;
  String? rmsNo;
  dynamic villageName;
  int? valveSize;
  int? noOfValves;
  int? chainage;
  int? diaOfPipe;
  dynamic noOfOms;
  String? coordinates;
  dynamic batteryType;
  double? batteryLevel;
  dynamic? batteryCurrent;
  dynamic? solarVoltage;
  dynamic solarCurrent;
  dynamic loadVoltage;
  dynamic loadCurrent;
  dynamic packetType;
  dynamic updateFreq;
  dynamic deviceType;
  dynamic? aI1;
  dynamic? aI2;
  dynamic? aI3;
  dynamic? aI4;
  dynamic temperature;
  dynamic dO1;
  dynamic dO2;
  dynamic? dI1;
  dynamic? dI2;
  dynamic? dI3;
  dynamic? dI4;
  dynamic dI5;
  dynamic dI6;
  dynamic dI7;
  dynamic dI8;
  dynamic dI9;
  dynamic dI10;
  dynamic dI11;
  dynamic dI12;
  dynamic dI13;
  dynamic dI14;
  dynamic dI15;
  dynamic dI16;
  dynamic dI17;
  dynamic dI18;
  dynamic pTFail;
  dynamic posFail;
  dynamic highTemp;
  dynamic lowBattery;
  dynamic emStop;
  dynamic solarChargerStatus;
  dynamic valveClosed;
  dynamic pressureRelief;
  dynamic closedByScada;
  dynamic closedByDoor;
  dynamic? rmsMode;
  dynamic rmsOMode;
  dynamic dailyRunTime;
  dynamic flowGreaterDesignFlow;
  dynamic flowGreaterCumFlow;
  dynamic pressureLesserDesignPress;
  dynamic pressureGreaterDesignPress;
  dynamic? calculatedFlow;
  double? calculatedVolume;
  dynamic externalVolume;
  dynamic totalFlow;
  dynamic? firmwareVersion;
  dynamic downlinkId;
  dynamic typeId;
  dynamic? pressureAI;
  String? networkType;
  dynamic ouletPipe;
  dynamic inletPipe;
  String? controllerType;
  dynamic designFlow;
  double? sustainingPressure;
  dynamic? reducingPressure;
  double? flowSetPoint;
  dynamic positionSetPoint;
  String? distributaryName;
  String? areaName;
  String? rmsNo1;
  String? lastResponseTime1;
  dynamic? batteryLevel1;
  dynamic? totalDamage;
  String? oNLINE;

  RMSMastermodel(
      {this.rmsId,
      this.areaId,
      this.distributaryId,
      this.brokerId,
      this.gateWayId,
      this.uID,
      this.mACAddress,
      this.publishTopic,
      this.lastResponseTime,
      this.deviceTime,
      this.rmsNo,
      this.villageName,
      this.valveSize,
      this.noOfValves,
      this.chainage,
      this.diaOfPipe,
      this.noOfOms,
      this.coordinates,
      this.batteryType,
      this.batteryLevel,
      this.batteryCurrent,
      this.solarVoltage,
      this.solarCurrent,
      this.loadVoltage,
      this.loadCurrent,
      this.packetType,
      this.updateFreq,
      this.deviceType,
      this.aI1,
      this.aI2,
      this.aI3,
      this.aI4,
      this.temperature,
      this.dO1,
      this.dO2,
      this.dI1,
      this.dI2,
      this.dI3,
      this.dI4,
      this.dI5,
      this.dI6,
      this.dI7,
      this.dI8,
      this.dI9,
      this.dI10,
      this.dI11,
      this.dI12,
      this.dI13,
      this.dI14,
      this.dI15,
      this.dI16,
      this.dI17,
      this.dI18,
      this.pTFail,
      this.posFail,
      this.highTemp,
      this.lowBattery,
      this.emStop,
      this.solarChargerStatus,
      this.valveClosed,
      this.pressureRelief,
      this.closedByScada,
      this.closedByDoor,
      this.rmsMode,
      this.rmsOMode,
      this.dailyRunTime,
      this.flowGreaterDesignFlow,
      this.flowGreaterCumFlow,
      this.pressureLesserDesignPress,
      this.pressureGreaterDesignPress,
      this.calculatedFlow,
      this.calculatedVolume,
      this.externalVolume,
      this.totalFlow,
      this.firmwareVersion,
      this.downlinkId,
      this.typeId,
      this.pressureAI,
      this.networkType,
      this.ouletPipe,
      this.inletPipe,
      this.controllerType,
      this.designFlow,
      this.sustainingPressure,
      this.reducingPressure,
      this.flowSetPoint,
      this.positionSetPoint,
      this.distributaryName,
      this.areaName,
      this.rmsNo1,
      this.lastResponseTime1,
      this.batteryLevel1,
      this.totalDamage,
      this.oNLINE});

  RMSMastermodel.fromJson(Map<String, dynamic> json) {
    rmsId = json['RmsId'];
    areaId = json['AreaId'];
    distributaryId = json['DistributaryId'];
    brokerId = json['BrokerId'];
    gateWayId = json['GateWayId'];
    uID = json['UID'];
    mACAddress = json['MACAddress'];
    publishTopic = json['PublishTopic'];
    lastResponseTime = json['LastResponseTime'];
    deviceTime = json['DeviceTime'];
    rmsNo = json['RmsNo'];
    villageName = json['VillageName'];
    valveSize = json['ValveSize'];
    noOfValves = json['NoOfValves'];
    chainage = json['Chainage'];
    diaOfPipe = json['DiaOfPipe'];
    noOfOms = json['NoOfOms'];
    coordinates = json['Coordinates'];
    batteryType = json['BatteryType'];
    batteryLevel = json['BatteryLevel'];
    batteryCurrent = json['BatteryCurrent'];
    solarVoltage = json['SolarVoltage'];
    solarCurrent = json['SolarCurrent'];
    loadVoltage = json['LoadVoltage'];
    loadCurrent = json['LoadCurrent'];
    packetType = json['PacketType'];
    updateFreq = json['UpdateFreq'];
    deviceType = json['DeviceType'];
    aI1 = json['AI1'];
    aI2 = json['AI2'];
    aI3 = json['AI3'];
    aI4 = json['AI4'];
    temperature = json['Temperature'];
    dO1 = json['DO1'];
    dO2 = json['DO2'];
    dI1 = json['DI1'];
    dI2 = json['DI2'];
    dI3 = json['DI3'];
    dI4 = json['DI4'];
    dI5 = json['DI5'];
    dI6 = json['DI6'];
    dI7 = json['DI7'];
    dI8 = json['DI8'];
    dI9 = json['DI9'];
    dI10 = json['DI10'];
    dI11 = json['DI11'];
    dI12 = json['DI12'];
    dI13 = json['DI13'];
    dI14 = json['DI14'];
    dI15 = json['DI15'];
    dI16 = json['DI16'];
    dI17 = json['DI17'];
    dI18 = json['DI18'];
    pTFail = json['PTFail'];
    posFail = json['PosFail'];
    highTemp = json['HighTemp'];
    lowBattery = json['LowBattery'];
    emStop = json['EmStop'];
    solarChargerStatus = json['SolarChargerStatus'];
    valveClosed = json['ValveClosed'];
    pressureRelief = json['PressureRelief'];
    closedByScada = json['ClosedByScada'];
    closedByDoor = json['ClosedByDoor'];
    rmsMode = json['RmsMode'];
    rmsOMode = json['RmsOMode'];
    dailyRunTime = json['DailyRunTime'];
    flowGreaterDesignFlow = json['FlowGreaterDesignFlow'];
    flowGreaterCumFlow = json['FlowGreaterCumFlow'];
    pressureLesserDesignPress = json['PressureLesserDesignPress'];
    pressureGreaterDesignPress = json['PressureGreaterDesignPress'];
    calculatedFlow = json['CalculatedFlow'];
    calculatedVolume = json['CalculatedVolume'];
    externalVolume = json['ExternalVolume'];
    totalFlow = json['TotalFlow'];
    firmwareVersion = json['FirmwareVersion'];
    downlinkId = json['DownlinkId'];
    typeId = json['TypeId'];
    pressureAI = json['PressureAI'];
    networkType = json['NetworkType'];
    ouletPipe = json['OuletPipe'];
    inletPipe = json['InletPipe'];
    controllerType = json['ControllerType'];
    designFlow = json['DesignFlow'];
    sustainingPressure = json['sustainingPressure'];
    reducingPressure = json['reducingPressure'];
    flowSetPoint = json['FlowSetPoint'];
    positionSetPoint = json['PositionSetPoint'];
    distributaryName = json['DistributaryName'];
    areaName = json['AreaName'];
    rmsNo1 = json['RmsNo1'];
    lastResponseTime1 = json['LastResponseTime1'];
    batteryLevel1 = json['BatteryLevel1'];
    totalDamage = json['TotalDamage'];
    oNLINE = json['ONLINE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RmsId'] = this.rmsId;
    data['AreaId'] = this.areaId;
    data['DistributaryId'] = this.distributaryId;
    data['BrokerId'] = this.brokerId;
    data['GateWayId'] = this.gateWayId;
    data['UID'] = this.uID;
    data['MACAddress'] = this.mACAddress;
    data['PublishTopic'] = this.publishTopic;
    data['LastResponseTime'] = this.lastResponseTime;
    data['DeviceTime'] = this.deviceTime;
    data['RmsNo'] = this.rmsNo;
    data['VillageName'] = this.villageName;
    data['ValveSize'] = this.valveSize;
    data['NoOfValves'] = this.noOfValves;
    data['Chainage'] = this.chainage;
    data['DiaOfPipe'] = this.diaOfPipe;
    data['NoOfOms'] = this.noOfOms;
    data['Coordinates'] = this.coordinates;
    data['BatteryType'] = this.batteryType;
    data['BatteryLevel'] = this.batteryLevel;
    data['BatteryCurrent'] = this.batteryCurrent;
    data['SolarVoltage'] = this.solarVoltage;
    data['SolarCurrent'] = this.solarCurrent;
    data['LoadVoltage'] = this.loadVoltage;
    data['LoadCurrent'] = this.loadCurrent;
    data['PacketType'] = this.packetType;
    data['UpdateFreq'] = this.updateFreq;
    data['DeviceType'] = this.deviceType;
    data['AI1'] = this.aI1;
    data['AI2'] = this.aI2;
    data['AI3'] = this.aI3;
    data['AI4'] = this.aI4;
    data['Temperature'] = this.temperature;
    data['DO1'] = this.dO1;
    data['DO2'] = this.dO2;
    data['DI1'] = this.dI1;
    data['DI2'] = this.dI2;
    data['DI3'] = this.dI3;
    data['DI4'] = this.dI4;
    data['DI5'] = this.dI5;
    data['DI6'] = this.dI6;
    data['DI7'] = this.dI7;
    data['DI8'] = this.dI8;
    data['DI9'] = this.dI9;
    data['DI10'] = this.dI10;
    data['DI11'] = this.dI11;
    data['DI12'] = this.dI12;
    data['DI13'] = this.dI13;
    data['DI14'] = this.dI14;
    data['DI15'] = this.dI15;
    data['DI16'] = this.dI16;
    data['DI17'] = this.dI17;
    data['DI18'] = this.dI18;
    data['PTFail'] = this.pTFail;
    data['PosFail'] = this.posFail;
    data['HighTemp'] = this.highTemp;
    data['LowBattery'] = this.lowBattery;
    data['EmStop'] = this.emStop;
    data['SolarChargerStatus'] = this.solarChargerStatus;
    data['ValveClosed'] = this.valveClosed;
    data['PressureRelief'] = this.pressureRelief;
    data['ClosedByScada'] = this.closedByScada;
    data['ClosedByDoor'] = this.closedByDoor;
    data['RmsMode'] = this.rmsMode;
    data['RmsOMode'] = this.rmsOMode;
    data['DailyRunTime'] = this.dailyRunTime;
    data['FlowGreaterDesignFlow'] = this.flowGreaterDesignFlow;
    data['FlowGreaterCumFlow'] = this.flowGreaterCumFlow;
    data['PressureLesserDesignPress'] = this.pressureLesserDesignPress;
    data['PressureGreaterDesignPress'] = this.pressureGreaterDesignPress;
    data['CalculatedFlow'] = this.calculatedFlow;
    data['CalculatedVolume'] = this.calculatedVolume;
    data['ExternalVolume'] = this.externalVolume;
    data['TotalFlow'] = this.totalFlow;
    data['FirmwareVersion'] = this.firmwareVersion;
    data['DownlinkId'] = this.downlinkId;
    data['TypeId'] = this.typeId;
    data['PressureAI'] = this.pressureAI;
    data['NetworkType'] = this.networkType;
    data['OuletPipe'] = this.ouletPipe;
    data['InletPipe'] = this.inletPipe;
    data['ControllerType'] = this.controllerType;
    data['DesignFlow'] = this.designFlow;
    data['sustainingPressure'] = this.sustainingPressure;
    data['reducingPressure'] = this.reducingPressure;
    data['FlowSetPoint'] = this.flowSetPoint;
    data['PositionSetPoint'] = this.positionSetPoint;
    data['DistributaryName'] = this.distributaryName;
    data['AreaName'] = this.areaName;
    data['RmsNo1'] = this.rmsNo1;
    data['LastResponseTime1'] = this.lastResponseTime1;
    data['BatteryLevel1'] = this.batteryLevel1;
    data['TotalDamage'] = this.totalDamage;
    data['ONLINE'] = this.oNLINE;
    return data;
  }
}
