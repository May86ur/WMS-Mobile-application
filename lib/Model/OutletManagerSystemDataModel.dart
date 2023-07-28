class OutletManagerSystemDataModel {
  int? omsId;
  int? flowRate;
  String? chakNo;
  double? chakArea;
  double? outLetPressure;
  double? calculatedVolume;
  int? onOffValvesQty;
  String? omsCoordinate;
  String? mACAddress;
  int? isConnected;
  String? lastResponseTime;
  int? onValve;
  int? offValve;
  int? scheduleStatus;
  int? mode;
  int? alarmState;
  String? publishTopic;
  String? deviceType;
  String? fWVersion;
  double? designPressure;
  String? description;
  String? subArea;
  int? updateFreq;
  double? inLetPressure;
  int? areaId;
  int? distributroyId;
  int? valvePosition;
  bool? door1;
  bool? door2;
  double? batteryLevel;
  double? solarVoltage;
  int? cI;
  double? setFlow;
  double? sustainingPressure;
  double? reducingPressure;
  int? oMODE;
  int? sIRR;
  int? romsMode;
  double? flowratePerHa;
  int? alarmCount;
  int? gMSALM;
  int? lOWFLOW;
  int? hIGHFLOW;
  int? nOFLOW;
  int? lOWPRE;
  int? hIGHPRE;
  int? iNIRRI;
  int? nOTINIRRI;
  int? dOOR;
  int? lOWBAT;
  int? wEAKGSM;
  int? vOLUMESTATUS;
  int? wEAKSOLAR;
  int? devStatus;
  int? v1IsAvailable;
  int? vIsAvailable;
  int? v2IsAvailable;
  int? v3IsAvailable;
  int? v4IsAvailable;
  int? v5IsAvailable;
  int? v6IsAvailable;
  int? v7IsAvailable;
  int? v8IsAvailable;
  int? v1IsInIrr;
  int? v2IsInIrr;
  int? v3IsInIrr;
  int? v4IsInIrr;
  int? v5IsInIrr;
  int? v6IsInIrr;
  int? v7IsInIrr;
  int? v8IsInIrr;
  String? v1Name;
  String? v2Name;
  String? v3Name;
  String? v4Name;
  String? v5Name;
  String? v6Name;
  String? v7Name;
  String? v8Name;
  String? subTopic;
  int? Damage;
  int? batteryPercentage;
  String? areaName;
  String? distributoryName;
  String? lastRoutineDate;

  OutletManagerSystemDataModel(
      {this.omsId,
      this.flowRate,
      this.chakNo,
      this.chakArea,
      this.outLetPressure,
      this.calculatedVolume,
      this.onOffValvesQty,
      this.omsCoordinate,
      this.mACAddress,
      this.isConnected,
      this.lastResponseTime,
      this.onValve,
      this.offValve,
      this.scheduleStatus,
      this.mode,
      this.alarmState,
      this.publishTopic,
      this.deviceType,
      this.fWVersion,
      this.designPressure,
      this.description,
      this.subArea,
      this.updateFreq,
      this.inLetPressure,
      this.areaId,
      this.distributroyId,
      this.valvePosition,
      this.door1,
      this.door2,
      this.batteryLevel,
      this.solarVoltage,
      this.cI,
      this.setFlow,
      this.sustainingPressure,
      this.reducingPressure,
      this.oMODE,
      this.sIRR,
      this.romsMode,
      this.flowratePerHa,
      this.alarmCount,
      this.gMSALM,
      this.lOWFLOW,
      this.hIGHFLOW,
      this.nOFLOW,
      this.lOWPRE,
      this.hIGHPRE,
      this.iNIRRI,
      this.nOTINIRRI,
      this.dOOR,
      this.lOWBAT,
      this.wEAKGSM,
      this.vOLUMESTATUS,
      this.wEAKSOLAR,
      this.devStatus,
      this.v1IsAvailable,
      this.vIsAvailable,
      this.v2IsAvailable,
      this.v3IsAvailable,
      this.v4IsAvailable,
      this.v5IsAvailable,
      this.v6IsAvailable,
      this.v7IsAvailable,
      this.v8IsAvailable,
      this.v1IsInIrr,
      this.v2IsInIrr,
      this.v3IsInIrr,
      this.v4IsInIrr,
      this.v5IsInIrr,
      this.v6IsInIrr,
      this.v7IsInIrr,
      this.v8IsInIrr,
      this.v1Name,
      this.v2Name,
      this.v3Name,
      this.v4Name,
      this.v5Name,
      this.v6Name,
      this.v7Name,
      this.v8Name,
      this.subTopic,
      this.batteryPercentage,
      this.Damage,
      this.areaName,
      this.distributoryName,
      this.lastRoutineDate});

  OutletManagerSystemDataModel.fromJson(Map<String, dynamic> json) {
    omsId = json['OmsId'];
    flowRate = json['flowRate'];
    chakNo = json['ChakNo'];
    chakArea = json['ChakArea'];
    outLetPressure = json['OutLetPressure'];
    calculatedVolume = json['CalculatedVolume'];
    onOffValvesQty = json['OnOffValvesQty'];
    omsCoordinate = json['OmsCoordinate'];
    mACAddress = json['MACAddress'];
    isConnected = json['IsConnected'];
    lastResponseTime = json['LastResponseTime'];
    onValve = json['OnValve'];
    offValve = json['OffValve'];
    scheduleStatus = json['ScheduleStatus'];
    mode = json['mode'];
    alarmState = json['AlarmState'];
    publishTopic = json['PublishTopic'];
    deviceType = json['deviceType'];
    fWVersion = json['FWVersion'];
    designPressure = json['DesignPressure'];
    description = json['description'];
    subArea = json['SubArea'];
    updateFreq = json['UpdateFreq'];
    inLetPressure = json['InLetPressure'];
    areaId = json['AreaId'];
    distributroyId = json['DistributroyId'];
    valvePosition = json['ValvePosition'];
    door1 = json['Door1'];
    door2 = json['Door2'];
    batteryLevel = json['BatteryLevel'];
    solarVoltage = json['SolarVoltage'];
    cI = json['CI'];
    setFlow = json['setFlow'];
    sustainingPressure = json['sustainingPressure'];
    reducingPressure = json['reducingPressure'];
    oMODE = json['O_MODE'];
    sIRR = json['SIRR'];
    romsMode = json['RomsMode'];
    flowratePerHa = json['FlowratePerHa'];
    alarmCount = json['AlarmCount'];
    gMSALM = json['GMS_ALM'];
    lOWFLOW = json['LOW_FLOW'];
    hIGHFLOW = json['HIGH_FLOW'];
    nOFLOW = json['NO_FLOW'];
    lOWPRE = json['LOW_PRE'];
    hIGHPRE = json['HIGH_PRE'];
    iNIRRI = json['IN_IRRI'];
    nOTINIRRI = json['NOTIN_IRRI'];
    dOOR = json['DOOR'];
    lOWBAT = json['LOW_BAT'];
    wEAKGSM = json['WEAK_GSM'];
    vOLUMESTATUS = json['VOLUME_STATUS'];
    wEAKSOLAR = json['WEAK_SOLAR'];
    devStatus = json['devStatus'];
    v1IsAvailable = json['V1IsAvailable'];
    vIsAvailable = json['VIsAvailable'];
    v2IsAvailable = json['V2IsAvailable'];
    v3IsAvailable = json['V3IsAvailable'];
    v4IsAvailable = json['V4IsAvailable'];
    v5IsAvailable = json['V5IsAvailable'];
    v6IsAvailable = json['V6IsAvailable'];
    v7IsAvailable = json['V7IsAvailable'];
    v8IsAvailable = json['V8IsAvailable'];
    v1IsInIrr = json['V1IsInIrr'];
    v2IsInIrr = json['V2IsInIrr'];
    v3IsInIrr = json['V3IsInIrr'];
    v4IsInIrr = json['V4IsInIrr'];
    v5IsInIrr = json['V5IsInIrr'];
    v6IsInIrr = json['V6IsInIrr'];
    v7IsInIrr = json['V7IsInIrr'];
    v8IsInIrr = json['V8IsInIrr'];
    v1Name = json['V1Name'];
    v2Name = json['V2Name'];
    v3Name = json['V3Name'];
    v4Name = json['V4Name'];
    v5Name = json['V5Name'];
    v6Name = json['V6Name'];
    v7Name = json['V7Name'];
    v8Name = json['V8Name'];
    subTopic = json['SubTopic'];
    batteryPercentage = json['BatteryPercentage'];
    Damage = json['Damage'];
    areaName = json['AreaName'];
    distributoryName = json['DistributoryName'];
    lastRoutineDate = json['LastRoutineDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OmsId'] = this.omsId;
    data['flowRate'] = this.flowRate;
    data['ChakNo'] = this.chakNo;
    data['ChakArea'] = this.chakArea;
    data['OutLetPressure'] = this.outLetPressure;
    data['CalculatedVolume'] = this.calculatedVolume;
    data['OnOffValvesQty'] = this.onOffValvesQty;
    data['OmsCoordinate'] = this.omsCoordinate;
    data['MACAddress'] = this.mACAddress;
    data['IsConnected'] = this.isConnected;
    data['LastResponseTime'] = this.lastResponseTime;
    data['OnValve'] = this.onValve;
    data['OffValve'] = this.offValve;
    data['ScheduleStatus'] = this.scheduleStatus;
    data['mode'] = this.mode;
    data['AlarmState'] = this.alarmState;
    data['PublishTopic'] = this.publishTopic;
    data['deviceType'] = this.deviceType;
    data['FWVersion'] = this.fWVersion;
    data['DesignPressure'] = this.designPressure;
    data['description'] = this.description;
    data['SubArea'] = this.subArea;
    data['UpdateFreq'] = this.updateFreq;
    data['InLetPressure'] = this.inLetPressure;
    data['AreaId'] = this.areaId;
    data['DistributroyId'] = this.distributroyId;
    data['ValvePosition'] = this.valvePosition;
    data['Door1'] = this.door1;
    data['Door2'] = this.door2;
    data['BatteryLevel'] = this.batteryLevel;
    data['SolarVoltage'] = this.solarVoltage;
    data['CI'] = this.cI;
    data['setFlow'] = this.setFlow;
    data['sustainingPressure'] = this.sustainingPressure;
    data['reducingPressure'] = this.reducingPressure;
    data['O_MODE'] = this.oMODE;
    data['SIRR'] = this.sIRR;
    data['RomsMode'] = this.romsMode;
    data['FlowratePerHa'] = this.flowratePerHa;
    data['AlarmCount'] = this.alarmCount;
    data['GMS_ALM'] = this.gMSALM;
    data['LOW_FLOW'] = this.lOWFLOW;
    data['HIGH_FLOW'] = this.hIGHFLOW;
    data['NO_FLOW'] = this.nOFLOW;
    data['LOW_PRE'] = this.lOWPRE;
    data['HIGH_PRE'] = this.hIGHPRE;
    data['IN_IRRI'] = this.iNIRRI;
    data['NOTIN_IRRI'] = this.nOTINIRRI;
    data['DOOR'] = this.dOOR;
    data['LOW_BAT'] = this.lOWBAT;
    data['WEAK_GSM'] = this.wEAKGSM;
    data['VOLUME_STATUS'] = this.vOLUMESTATUS;
    data['WEAK_SOLAR'] = this.wEAKSOLAR;
    data['devStatus'] = this.devStatus;
    data['V1IsAvailable'] = this.v1IsAvailable;
    data['VIsAvailable'] = this.vIsAvailable;
    data['V2IsAvailable'] = this.v2IsAvailable;
    data['V3IsAvailable'] = this.v3IsAvailable;
    data['V4IsAvailable'] = this.v4IsAvailable;
    data['V5IsAvailable'] = this.v5IsAvailable;
    data['V6IsAvailable'] = this.v6IsAvailable;
    data['V7IsAvailable'] = this.v7IsAvailable;
    data['V8IsAvailable'] = this.v8IsAvailable;
    data['V1IsInIrr'] = this.v1IsInIrr;
    data['V2IsInIrr'] = this.v2IsInIrr;
    data['V3IsInIrr'] = this.v3IsInIrr;
    data['V4IsInIrr'] = this.v4IsInIrr;
    data['V5IsInIrr'] = this.v5IsInIrr;
    data['V6IsInIrr'] = this.v6IsInIrr;
    data['V7IsInIrr'] = this.v7IsInIrr;
    data['V8IsInIrr'] = this.v8IsInIrr;
    data['V1Name'] = this.v1Name;
    data['V2Name'] = this.v2Name;
    data['V3Name'] = this.v3Name;
    data['V4Name'] = this.v4Name;
    data['V5Name'] = this.v5Name;
    data['V6Name'] = this.v6Name;
    data['V7Name'] = this.v7Name;
    data['V8Name'] = this.v8Name;
    data['SubTopic'] = this.subTopic;
    data['BatteryPercentage'] = this.batteryPercentage;
    data['Damage'] = this.Damage;
    data['AreaName'] = this.areaName;
    data['DistributoryName'] = this.distributoryName;
    data['LastRoutineDate'] = this.lastRoutineDate;
    return data;
  }
}
