class PumpStationMasterModel {
  int? tagId;
  String? register;
  String? fieldDevice;
  int? deviceId;
  String? tagName;
  String? description;
  dynamic data;
  dynamic unit;
  String? deviceTimeStamp;
  String? serverTimeStamp;
  dynamic addToHistory;
  int? isScaled;
  int? multiplicationFactor;
  int? qId;
  String? dataType;
  int? address;
  int? bit;
  dynamic scadaAlarms;
  dynamic alarmHistoryOn;
  dynamic checkAlarms;
  dynamic updatesCustomTag;
  dynamic tagExpression;
  dynamic minRaw;
  dynamic maxRaw;
  dynamic minEng;
  dynamic maxEng;
  dynamic calibration;
  dynamic alarmLL;
  dynamic alarmL;
  dynamic alarmH;
  dynamic alarmHH;
  dynamic oPCServerId;
  dynamic oPCItemId;
  dynamic tagDatatype;
  dynamic isArrayTag;
  dynamic arrayIndex;
  dynamic alarmOn;
  dynamic alarmPriority;
  dynamic parameter;
  dynamic lastGoodValue;
  dynamic valueUpdateDelay;
  dynamic isPLCCounterTag;
  dynamic pLCCounterUpateDiff;
  dynamic pLCCommAlarmTag;
  dynamic historyFrequency;
  dynamic linkTag;
  dynamic runTags;
  dynamic pumpVolume;
  dynamic pumpReport;
  int? runHourTags;
  dynamic powerConsumption;
  int? pumpStationId;
  double? tankHeight;
  int? devStatus;

  PumpStationMasterModel(
      {this.tagId,
      this.register,
      this.fieldDevice,
      this.deviceId,
      this.tagName,
      this.description,
      this.data,
      this.unit,
      this.deviceTimeStamp,
      this.serverTimeStamp,
      this.addToHistory,
      this.isScaled,
      this.multiplicationFactor,
      this.qId,
      this.dataType,
      this.address,
      this.bit,
      this.scadaAlarms,
      this.alarmHistoryOn,
      this.checkAlarms,
      this.updatesCustomTag,
      this.tagExpression,
      this.minRaw,
      this.maxRaw,
      this.minEng,
      this.maxEng,
      this.calibration,
      this.alarmLL,
      this.alarmL,
      this.alarmH,
      this.alarmHH,
      this.oPCServerId,
      this.oPCItemId,
      this.tagDatatype,
      this.isArrayTag,
      this.arrayIndex,
      this.alarmOn,
      this.alarmPriority,
      this.parameter,
      this.lastGoodValue,
      this.valueUpdateDelay,
      this.isPLCCounterTag,
      this.pLCCounterUpateDiff,
      this.pLCCommAlarmTag,
      this.historyFrequency,
      this.linkTag,
      this.runTags,
      this.pumpVolume,
      this.pumpReport,
      this.runHourTags,
      this.powerConsumption,
      this.pumpStationId,
      this.tankHeight,
      this.devStatus});

  PumpStationMasterModel.fromJson(Map<String, dynamic> json) {
    tagId = json['tagId'];
    register = json['register'];
    fieldDevice = json['fieldDevice'];
    deviceId = json['deviceId'];
    tagName = json['tagName'];
    description = json['description'];
    data = json['data'] ?? '0';
    unit = json['unit'];
    deviceTimeStamp = json['deviceTimeStamp'];
    serverTimeStamp = json['serverTimeStamp'];
    addToHistory = json['addToHistory'];
    isScaled = json['isScaled'];
    multiplicationFactor = json['multiplicationFactor'];
    qId = json['qId'];
    dataType = json['dataType'];
    bit = json['bit'];
    scadaAlarms = json['scadaAlarms'];
    alarmHistoryOn = json['AlarmHistoryOn'];
    checkAlarms = json['checkAlarms'];
    updatesCustomTag = json['updatesCustomTag'];
    tagExpression = json['tagExpression'];
    minRaw = json['minRaw'];
    maxRaw = json['maxRaw'];
    minEng = json['minEng'];
    maxEng = json['maxEng'];
    calibration = json['calibration'];
    alarmLL = json['alarmLL'];
    alarmL = json['alarmL'];
    alarmH = json['alarmH'];
    alarmHH = json['alarmHH'];
    oPCServerId = json['OPCServerId'];
    oPCItemId = json['OPCItemId'];
    tagDatatype = json['tagDatatype'];
    isArrayTag = json['isArrayTag'];
    arrayIndex = json['arrayIndex'];
    alarmOn = json['alarmOn'];
    alarmPriority = json['alarmPriority'];
    parameter = json['parameter'];
    lastGoodValue = json['lastGoodValue'];
    valueUpdateDelay = json['valueUpdateDelay'];
    isPLCCounterTag = json['isPLCCounterTag'];
    pLCCounterUpateDiff = json['PLCCounterUpateDiff'];
    pLCCommAlarmTag = json['PLCCommAlarmTag'];
    historyFrequency = json['HistoryFrequency'];
    linkTag = json['linkTag'];
    runTags = json['RunTags'];
    pumpVolume = json['PumpVolume'];
    pumpReport = json['PumpReport'];
    runHourTags = json['RunHourTags'];
    powerConsumption = json['PowerConsumption'];
    pumpStationId = json['pumpStationId'];
    tankHeight = json['TankHeight'] ?? 0.0;
    devStatus = json['devStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagId'] = this.tagId;
    data['register'] = this.register;
    data['fieldDevice'] = this.fieldDevice;
    data['deviceId'] = this.deviceId;
    data['tagName'] = this.tagName;
    data['description'] = this.description;
    data['data'] = this.data;
    data['unit'] = this.unit;
    data['deviceTimeStamp'] = this.deviceTimeStamp;
    data['serverTimeStamp'] = this.serverTimeStamp;
    data['addToHistory'] = this.addToHistory;
    data['isScaled'] = this.isScaled;
    data['multiplicationFactor'] = this.multiplicationFactor;
    data['qId'] = this.qId;
    data['dataType'] = this.dataType;
    data['address'] = this.address;
    data['bit'] = this.bit;
    data['scadaAlarms'] = this.scadaAlarms;
    data['AlarmHistoryOn'] = this.alarmHistoryOn;
    data['checkAlarms'] = this.checkAlarms;
    data['updatesCustomTag'] = this.updatesCustomTag;
    data['tagExpression'] = this.tagExpression;
    data['minRaw'] = this.minRaw;
    data['maxRaw'] = this.maxRaw;
    data['minEng'] = this.minEng;
    data['maxEng'] = this.maxEng;
    data['calibration'] = this.calibration;
    data['alarmLL'] = this.alarmLL;
    data['alarmL'] = this.alarmL;
    data['alarmH'] = this.alarmH;
    data['alarmHH'] = this.alarmHH;
    data['OPCServerId'] = this.oPCServerId;
    data['OPCItemId'] = this.oPCItemId;
    data['tagDatatype'] = this.tagDatatype;
    data['isArrayTag'] = this.isArrayTag;
    data['arrayIndex'] = this.arrayIndex;
    data['alarmOn'] = this.alarmOn;
    data['alarmPriority'] = this.alarmPriority;
    data['parameter'] = this.parameter;
    data['lastGoodValue'] = this.lastGoodValue;
    data['valueUpdateDelay'] = this.valueUpdateDelay;
    data['isPLCCounterTag'] = this.isPLCCounterTag;
    data['PLCCounterUpateDiff'] = this.pLCCounterUpateDiff;
    data['PLCCommAlarmTag'] = this.pLCCommAlarmTag;
    data['HistoryFrequency'] = this.historyFrequency;
    data['linkTag'] = this.linkTag;
    data['RunTags'] = this.runTags;
    data['PumpVolume'] = this.pumpVolume;
    data['PumpReport'] = this.pumpReport;
    data['RunHourTags'] = this.runHourTags;
    data['PowerConsumption'] = this.powerConsumption;
    data['pumpStationId'] = this.pumpStationId;
    data['TankHeight'] = this.tankHeight;
    data['devStatus'] = this.devStatus;
    return data;
  }
}
