class PumpStationResponse {
  int? deviceId;
  String? deviceName;
  int? commStatus;
  String? sUMPLEVELVAL;
  String? pump1OnStatus;
  String? pump2OnStatus;
  String? pump3OnStatus;
  String? pump4OnStatus;
  String? pump5OnStatus;
  String? pump6OnStatus;
  String? pump7OnStatus;
  String? pump1OffStatus;
  String? pump2OffStatus;
  String? pump3OffStatus;
  String? pump4OffStatus;
  String? pump5OffStatus;
  String? pump6OffStatus;
  String? pump7OffStatus;
  String? pump1FaultStatus;
  String? pump2FaultStatus;
  String? pump3FaultStatus;
  String? pump4FaultStatus;
  String? pump5FaultStatus;
  String? pump6FaultStatus;
  String? pump7FaultStatus;
  String? hOPD1OnStatus;
  String? hOPD2OnStatus;
  String? hOPD3OnStatus;
  String? hOPD4OnStatus;
  String? hOPD5OnStatus;
  String? hOPD6OnStatus;
  String? hOPD7OnStatus;
  String? hOPD1OffStatus;
  String? hOPD2OffStatus;
  String? hOPD3OffStatus;
  String? hOPD4OffStatus;
  String? hOPD5OffStatus;
  String? hOPD6OffStatus;
  String? hOPD7OffStatus;
  String? hOPD1FaultStatus;
  String? hOPD2FaultStatus;
  String? hOPD3FaultStatus;
  String? hOPD4FaultStatus;
  String? hOPD5FaultStatus;
  String? hOPD6FaultStatus;
  String? hOPD7FaultStatus;
  String? valve1OnStatus;
  String? valve2OnStatus;
  String? valve3OnStatus;
  String? valve4OnStatus;
  String? valve5OnStatus;
  String? valve6OnStatus;
  String? valve7OnStatus;
  String? valve1OffStatus;
  String? valve2OffStatus;
  String? valve3OffStatus;
  String? valve4OffStatus;
  String? valve5OffStatus;
  String? valve6OffStatus;
  String? valve7OffStatus;
  String? valve1FaultStatus;
  String? valve2FaultStatus;
  String? valve3FaultStatus;
  String? valve4FaultStatus;
  String? valve5FaultStatus;
  String? valve6FaultStatus;
  String? valve7FaultStatus;
  String? valve1PosValue;
  String? valve2PosValue;
  String? valve3PosValue;
  String? valve4PosValue;
  String? valve5PosValue;
  String? valve6PosValue;
  String? valve7PosValue;
  String? pS1;
  String? pS2;
  String? pS3;
  String? pS4;
  String? pS5;
  String? pS6;
  String? pS7;
  String? flowValue1;
  String? flowValue2;
  String? flowValue3;
  String? flowValue4;
  String? flowValue5;
  String? volume1;
  String? volume2;
  String? volume3;
  String? volume4;
  String? volume5;
  String? headerPressure1;
  String? headerPressure2;
  String? pump1OnOffStatus;
  String? pump2OnOffStatus;
  String? pump3OnOffStatus;
  String? pump4OnOffStatus;
  String? pump5OnOffStatus;
  String? pump1InOnStatus;
  String? pump2InOnStatus;
  String? pump3InOnStatus;
  String? pump4InOnStatus;
  String? pump5InOnStatus;
  String? pump1InFaultStatus;
  String? pump2InFaultStatus;
  String? pump3InFaultStatus;
  String? pump4InFaultStatus;
  String? pump5InFaultStatus;
  String? pump1PT;
  String? pump2PT;
  String? pump3PT;
  String? pump4PT;
  String? pump5PT;
  String? pump6PT;
  String? pump7PT;
  String? outletPT1;
  String? outletPT2;
  String? outletPT3;
  String? lastResponseTime;

  PumpStationResponse(
      {this.deviceId,
      this.deviceName,
      this.commStatus,
      this.sUMPLEVELVAL,
      this.pump1OnStatus,
      this.pump2OnStatus,
      this.pump3OnStatus,
      this.pump4OnStatus,
      this.pump5OnStatus,
      this.pump6OnStatus,
      this.pump7OnStatus,
      this.pump1OffStatus,
      this.pump2OffStatus,
      this.pump3OffStatus,
      this.pump4OffStatus,
      this.pump5OffStatus,
      this.pump6OffStatus,
      this.pump7OffStatus,
      this.pump1FaultStatus,
      this.pump2FaultStatus,
      this.pump3FaultStatus,
      this.pump4FaultStatus,
      this.pump5FaultStatus,
      this.pump6FaultStatus,
      this.pump7FaultStatus,
      this.hOPD1OnStatus,
      this.hOPD2OnStatus,
      this.hOPD3OnStatus,
      this.hOPD4OnStatus,
      this.hOPD5OnStatus,
      this.hOPD6OnStatus,
      this.hOPD7OnStatus,
      this.hOPD1OffStatus,
      this.hOPD2OffStatus,
      this.hOPD3OffStatus,
      this.hOPD4OffStatus,
      this.hOPD5OffStatus,
      this.hOPD6OffStatus,
      this.hOPD7OffStatus,
      this.hOPD1FaultStatus,
      this.hOPD2FaultStatus,
      this.hOPD3FaultStatus,
      this.hOPD4FaultStatus,
      this.hOPD5FaultStatus,
      this.hOPD6FaultStatus,
      this.hOPD7FaultStatus,
      this.valve1OnStatus,
      this.valve2OnStatus,
      this.valve3OnStatus,
      this.valve4OnStatus,
      this.valve5OnStatus,
      this.valve6OnStatus,
      this.valve7OnStatus,
      this.valve1OffStatus,
      this.valve2OffStatus,
      this.valve3OffStatus,
      this.valve4OffStatus,
      this.valve5OffStatus,
      this.valve6OffStatus,
      this.valve7OffStatus,
      this.valve1FaultStatus,
      this.valve2FaultStatus,
      this.valve3FaultStatus,
      this.valve4FaultStatus,
      this.valve5FaultStatus,
      this.valve6FaultStatus,
      this.valve7FaultStatus,
      this.valve1PosValue,
      this.valve2PosValue,
      this.valve3PosValue,
      this.valve4PosValue,
      this.valve5PosValue,
      this.valve6PosValue,
      this.valve7PosValue,
      this.pS1,
      this.pS2,
      this.pS3,
      this.pS4,
      this.pS5,
      this.pS6,
      this.pS7,
      this.flowValue1,
      this.flowValue2,
      this.flowValue3,
      this.flowValue4,
      this.flowValue5,
      this.volume1,
      this.volume2,
      this.volume3,
      this.volume4,
      this.volume5,
      this.headerPressure1,
      this.headerPressure2,
      this.pump1OnOffStatus,
      this.pump2OnOffStatus,
      this.pump3OnOffStatus,
      this.pump4OnOffStatus,
      this.pump5OnOffStatus,
      this.pump1InOnStatus,
      this.pump2InOnStatus,
      this.pump3InOnStatus,
      this.pump4InOnStatus,
      this.pump5InOnStatus,
      this.pump1InFaultStatus,
      this.pump2InFaultStatus,
      this.pump3InFaultStatus,
      this.pump4InFaultStatus,
      this.pump5InFaultStatus,
      this.pump1PT,
      this.pump2PT,
      this.pump3PT,
      this.pump4PT,
      this.pump5PT,
      this.pump6PT,
      this.pump7PT,
      this.outletPT1,
      this.outletPT2,
      this.outletPT3,
      this.lastResponseTime});

  PumpStationResponse.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    commStatus = json['CommStatus'];
    sUMPLEVELVAL = json['SUMP_LEVEL_VAL'];
    pump1OnStatus = json['Pump1OnStatus'];
    pump2OnStatus = json['Pump2OnStatus'];
    pump3OnStatus = json['Pump3OnStatus'];
    pump4OnStatus = json['Pump4OnStatus'];
    pump5OnStatus = json['Pump5OnStatus'];
    pump6OnStatus = json['Pump6OnStatus'];
    pump7OnStatus = json['Pump7OnStatus'];
    pump1OffStatus = json['Pump1OffStatus'];
    pump2OffStatus = json['Pump2OffStatus'];
    pump3OffStatus = json['Pump3OffStatus'];
    pump4OffStatus = json['Pump4OffStatus'];
    pump5OffStatus = json['Pump5OffStatus'];
    pump6OffStatus = json['Pump6OffStatus'];
    pump7OffStatus = json['Pump7OffStatus'];
    pump1FaultStatus = json['Pump1FaultStatus'];
    pump2FaultStatus = json['Pump2FaultStatus'];
    pump3FaultStatus = json['Pump3FaultStatus'];
    pump4FaultStatus = json['Pump4FaultStatus'];
    pump5FaultStatus = json['Pump5FaultStatus'];
    pump6FaultStatus = json['Pump6FaultStatus'];
    pump7FaultStatus = json['Pump7FaultStatus'];
    hOPD1OnStatus = json['HOPD1OnStatus'];
    hOPD2OnStatus = json['HOPD2OnStatus'];
    hOPD3OnStatus = json['HOPD3OnStatus'];
    hOPD4OnStatus = json['HOPD4OnStatus'];
    hOPD5OnStatus = json['HOPD5OnStatus'];
    hOPD6OnStatus = json['HOPD6OnStatus'];
    hOPD7OnStatus = json['HOPD7OnStatus'];
    hOPD1OffStatus = json['HOPD1OffStatus'];
    hOPD2OffStatus = json['HOPD2OffStatus'];
    hOPD3OffStatus = json['HOPD3OffStatus'];
    hOPD4OffStatus = json['HOPD4OffStatus'];
    hOPD5OffStatus = json['HOPD5OffStatus'];
    hOPD6OffStatus = json['HOPD6OffStatus'];
    hOPD7OffStatus = json['HOPD7OffStatus'];
    hOPD1FaultStatus = json['HOPD1FaultStatus'];
    hOPD2FaultStatus = json['HOPD2FaultStatus'];
    hOPD3FaultStatus = json['HOPD3FaultStatus'];
    hOPD4FaultStatus = json['HOPD4FaultStatus'];
    hOPD5FaultStatus = json['HOPD5FaultStatus'];
    hOPD6FaultStatus = json['HOPD6FaultStatus'];
    hOPD7FaultStatus = json['HOPD7FaultStatus'];
    valve1OnStatus = json['Valve1OnStatus'];
    valve2OnStatus = json['Valve2OnStatus'];
    valve3OnStatus = json['Valve3OnStatus'];
    valve4OnStatus = json['Valve4OnStatus'];
    valve5OnStatus = json['Valve5OnStatus'];
    valve6OnStatus = json['Valve6OnStatus'];
    valve7OnStatus = json['Valve7OnStatus'];
    valve1OffStatus = json['Valve1OffStatus'];
    valve2OffStatus = json['Valve2OffStatus'];
    valve3OffStatus = json['Valve3OffStatus'];
    valve4OffStatus = json['Valve4OffStatus'];
    valve5OffStatus = json['Valve5OffStatus'];
    valve6OffStatus = json['Valve6OffStatus'];
    valve7OffStatus = json['Valve7OffStatus'];
    valve1FaultStatus = json['Valve1FaultStatus'];
    valve2FaultStatus = json['Valve2FaultStatus'];
    valve3FaultStatus = json['Valve3FaultStatus'];
    valve4FaultStatus = json['Valve4FaultStatus'];
    valve5FaultStatus = json['Valve5FaultStatus'];
    valve6FaultStatus = json['Valve6FaultStatus'];
    valve7FaultStatus = json['Valve7FaultStatus'];
    valve1PosValue = json['Valve1PosValue'];
    valve2PosValue = json['Valve2PosValue'];
    valve3PosValue = json['Valve3PosValue'];
    valve4PosValue = json['Valve4PosValue'];
    valve5PosValue = json['Valve5PosValue'];
    valve6PosValue = json['Valve6PosValue'];
    valve7PosValue = json['Valve7PosValue'];
    pS1 = json['PS1'];
    pS2 = json['PS2'];
    pS3 = json['PS3'];
    pS4 = json['PS4'];
    pS5 = json['PS5'];
    pS6 = json['PS6'];
    pS7 = json['PS7'];
    flowValue1 = json['FlowValue1'];
    flowValue2 = json['FlowValue2'];
    flowValue3 = json['FlowValue3'];
    flowValue4 = json['FlowValue4'];
    flowValue5 = json['FlowValue5'];
    volume1 = json['Volume1'];
    volume2 = json['Volume2'];
    volume3 = json['Volume3'];
    volume4 = json['Volume4'];
    volume5 = json['Volume5'];
    headerPressure1 = json['HeaderPressure1'];
    headerPressure2 = json['HeaderPressure2'];
    pump1OnOffStatus = json['Pump1OnOffStatus'];
    pump2OnOffStatus = json['Pump2OnOffStatus'];
    pump3OnOffStatus = json['Pump3OnOffStatus'];
    pump4OnOffStatus = json['Pump4OnOffStatus'];
    pump5OnOffStatus = json['Pump5OnOffStatus'];
    pump1InOnStatus = json['Pump1InOnStatus'];
    pump2InOnStatus = json['Pump2InOnStatus'];
    pump3InOnStatus = json['Pump3InOnStatus'];
    pump4InOnStatus = json['Pump4InOnStatus'];
    pump5InOnStatus = json['Pump5InOnStatus'];
    pump1InFaultStatus = json['Pump1InFaultStatus'];
    pump2InFaultStatus = json['Pump2InFaultStatus'];
    pump3InFaultStatus = json['Pump3InFaultStatus'];
    pump4InFaultStatus = json['Pump4InFaultStatus'];
    pump5InFaultStatus = json['Pump5InFaultStatus'];
    pump1PT = json['Pump1PT'];
    pump2PT = json['Pump2PT'];
    pump3PT = json['Pump3PT'];
    pump4PT = json['Pump4PT'];
    pump5PT = json['Pump5PT'];
    pump6PT = json['Pump6PT'];
    pump7PT = json['Pump7PT'];
    outletPT1 = json['OutletPT1'];
    outletPT2 = json['OutletPT2'];
    outletPT3 = json['OutletPT3'];
    lastResponseTime = json['LastResponseTime'];
  }

  // get state => null;

  // get projectName => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceId'] = this.deviceId;
    data['deviceName'] = this.deviceName;
    data['CommStatus'] = this.commStatus;
    data['SUMP_LEVEL_VAL'] = this.sUMPLEVELVAL;
    data['Pump1OnStatus'] = this.pump1OnStatus;
    data['Pump2OnStatus'] = this.pump2OnStatus;
    data['Pump3OnStatus'] = this.pump3OnStatus;
    data['Pump4OnStatus'] = this.pump4OnStatus;
    data['Pump5OnStatus'] = this.pump5OnStatus;
    data['Pump6OnStatus'] = this.pump6OnStatus;
    data['Pump7OnStatus'] = this.pump7OnStatus;
    data['Pump1OffStatus'] = this.pump1OffStatus;
    data['Pump2OffStatus'] = this.pump2OffStatus;
    data['Pump3OffStatus'] = this.pump3OffStatus;
    data['Pump4OffStatus'] = this.pump4OffStatus;
    data['Pump5OffStatus'] = this.pump5OffStatus;
    data['Pump6OffStatus'] = this.pump6OffStatus;
    data['Pump7OffStatus'] = this.pump7OffStatus;
    data['Pump1FaultStatus'] = this.pump1FaultStatus;
    data['Pump2FaultStatus'] = this.pump2FaultStatus;
    data['Pump3FaultStatus'] = this.pump3FaultStatus;
    data['Pump4FaultStatus'] = this.pump4FaultStatus;
    data['Pump5FaultStatus'] = this.pump5FaultStatus;
    data['Pump6FaultStatus'] = this.pump6FaultStatus;
    data['Pump7FaultStatus'] = this.pump7FaultStatus;
    data['HOPD1OnStatus'] = this.hOPD1OnStatus;
    data['HOPD2OnStatus'] = this.hOPD2OnStatus;
    data['HOPD3OnStatus'] = this.hOPD3OnStatus;
    data['HOPD4OnStatus'] = this.hOPD4OnStatus;
    data['HOPD5OnStatus'] = this.hOPD5OnStatus;
    data['HOPD6OnStatus'] = this.hOPD6OnStatus;
    data['HOPD7OnStatus'] = this.hOPD7OnStatus;
    data['HOPD1OffStatus'] = this.hOPD1OffStatus;
    data['HOPD2OffStatus'] = this.hOPD2OffStatus;
    data['HOPD3OffStatus'] = this.hOPD3OffStatus;
    data['HOPD4OffStatus'] = this.hOPD4OffStatus;
    data['HOPD5OffStatus'] = this.hOPD5OffStatus;
    data['HOPD6OffStatus'] = this.hOPD6OffStatus;
    data['HOPD7OffStatus'] = this.hOPD7OffStatus;
    data['HOPD1FaultStatus'] = this.hOPD1FaultStatus;
    data['HOPD2FaultStatus'] = this.hOPD2FaultStatus;
    data['HOPD3FaultStatus'] = this.hOPD3FaultStatus;
    data['HOPD4FaultStatus'] = this.hOPD4FaultStatus;
    data['HOPD5FaultStatus'] = this.hOPD5FaultStatus;
    data['HOPD6FaultStatus'] = this.hOPD6FaultStatus;
    data['HOPD7FaultStatus'] = this.hOPD7FaultStatus;
    data['Valve1OnStatus'] = this.valve1OnStatus;
    data['Valve2OnStatus'] = this.valve2OnStatus;
    data['Valve3OnStatus'] = this.valve3OnStatus;
    data['Valve4OnStatus'] = this.valve4OnStatus;
    data['Valve5OnStatus'] = this.valve5OnStatus;
    data['Valve6OnStatus'] = this.valve6OnStatus;
    data['Valve7OnStatus'] = this.valve7OnStatus;
    data['Valve1OffStatus'] = this.valve1OffStatus;
    data['Valve2OffStatus'] = this.valve2OffStatus;
    data['Valve3OffStatus'] = this.valve3OffStatus;
    data['Valve4OffStatus'] = this.valve4OffStatus;
    data['Valve5OffStatus'] = this.valve5OffStatus;
    data['Valve6OffStatus'] = this.valve6OffStatus;
    data['Valve7OffStatus'] = this.valve7OffStatus;
    data['Valve1FaultStatus'] = this.valve1FaultStatus;
    data['Valve2FaultStatus'] = this.valve2FaultStatus;
    data['Valve3FaultStatus'] = this.valve3FaultStatus;
    data['Valve4FaultStatus'] = this.valve4FaultStatus;
    data['Valve5FaultStatus'] = this.valve5FaultStatus;
    data['Valve6FaultStatus'] = this.valve6FaultStatus;
    data['Valve7FaultStatus'] = this.valve7FaultStatus;
    data['Valve1PosValue'] = this.valve1PosValue;
    data['Valve2PosValue'] = this.valve2PosValue;
    data['Valve3PosValue'] = this.valve3PosValue;
    data['Valve4PosValue'] = this.valve4PosValue;
    data['Valve5PosValue'] = this.valve5PosValue;
    data['Valve6PosValue'] = this.valve6PosValue;
    data['Valve7PosValue'] = this.valve7PosValue;
    data['PS1'] = this.pS1;
    data['PS2'] = this.pS2;
    data['PS3'] = this.pS3;
    data['PS4'] = this.pS4;
    data['PS5'] = this.pS5;
    data['PS6'] = this.pS6;
    data['PS7'] = this.pS7;
    data['FlowValue1'] = this.flowValue1;
    data['FlowValue2'] = this.flowValue2;
    data['FlowValue3'] = this.flowValue3;
    data['FlowValue4'] = this.flowValue4;
    data['FlowValue5'] = this.flowValue5;
    data['Volume1'] = this.volume1;
    data['Volume2'] = this.volume2;
    data['Volume3'] = this.volume3;
    data['Volume4'] = this.volume4;
    data['Volume5'] = this.volume5;
    data['HeaderPressure1'] = this.headerPressure1;
    data['HeaderPressure2'] = this.headerPressure2;
    data['Pump1OnOffStatus'] = this.pump1OnOffStatus;
    data['Pump2OnOffStatus'] = this.pump2OnOffStatus;
    data['Pump3OnOffStatus'] = this.pump3OnOffStatus;
    data['Pump4OnOffStatus'] = this.pump4OnOffStatus;
    data['Pump5OnOffStatus'] = this.pump5OnOffStatus;
    data['Pump1InOnStatus'] = this.pump1InOnStatus;
    data['Pump2InOnStatus'] = this.pump2InOnStatus;
    data['Pump3InOnStatus'] = this.pump3InOnStatus;
    data['Pump4InOnStatus'] = this.pump4InOnStatus;
    data['Pump5InOnStatus'] = this.pump5InOnStatus;
    data['Pump1InFaultStatus'] = this.pump1InFaultStatus;
    data['Pump2InFaultStatus'] = this.pump2InFaultStatus;
    data['Pump3InFaultStatus'] = this.pump3InFaultStatus;
    data['Pump4InFaultStatus'] = this.pump4InFaultStatus;
    data['Pump5InFaultStatus'] = this.pump5InFaultStatus;
    data['Pump1PT'] = this.pump1PT;
    data['Pump2PT'] = this.pump2PT;
    data['Pump3PT'] = this.pump3PT;
    data['Pump4PT'] = this.pump4PT;
    data['Pump5PT'] = this.pump5PT;
    data['Pump6PT'] = this.pump6PT;
    data['Pump7PT'] = this.pump7PT;
    data['OutletPT1'] = this.outletPT1;
    data['OutletPT2'] = this.outletPT2;
    data['OutletPT3'] = this.outletPT3;
    data['LastResponseTime'] = this.lastResponseTime;
    return data;
  }
}
