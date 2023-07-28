class ProjectOverviewModel {
  int? totalOms;
  int? onlineOms;
  int? offlineOms;
  int? damageOms;
  int? totalAms;
  int? onlineAms;
  int? offlineAms;
  int? damageAms;
  int? noOfPS;
  int? pS1Status;
  int? pS2Status;
  int? pS3Status;
  int? pS4Status;
  int? pS5Status;
  int? pS6Status;
  int? pS7Status;
  int? pS8Status;
  int? pS9Status;
  int? pS10Status;
  int? pS11Status;
  int? pS12Status;
  int? pS13Status;
  int? pS14Status;
  int? pS15Status;
  int? pS16Status;
  int? pS17Status;
  int? pS18Status;
  int? ps19Status;
  int? ps20Status;
  int? ps21Status;
  int? ps22Status;
  int? ps23Status;
  dynamic? totalRms;
  dynamic? onlineRms;
  dynamic? offlineRms;
  dynamic? damageRms;
  dynamic? noOfLoRaGateway;
  dynamic? damageLoRaGateway;
  int? noOfDC;
  int? dC1AStatus;
  int? dC1Btatus;
  int? dC1Status;
  int? dC2Status;
  int? dc3Status;
  dynamic? activeAlarms;
  String? canalStatus;

  ProjectOverviewModel(
      {this.totalOms,
      this.onlineOms,
      this.offlineOms,
      this.damageOms,
      this.totalAms,
      this.onlineAms,
      this.offlineAms,
      this.damageAms,
      this.noOfPS,
      this.pS1Status,
      this.pS2Status,
      this.pS3Status,
      this.pS4Status,
      this.pS5Status,
      this.pS6Status,
      this.pS7Status,
      this.pS8Status,
      this.pS9Status,
      this.pS10Status,
      this.pS11Status,
      this.pS12Status,
      this.pS13Status,
      this.pS14Status,
      this.pS15Status,
      this.pS16Status,
      this.pS17Status,
      this.pS18Status,
      this.ps19Status,
      this.ps20Status,
      this.ps21Status,
      this.ps22Status,
      this.ps23Status,
      this.totalRms,
      this.onlineRms,
      this.offlineRms,
      this.damageRms,
      this.noOfLoRaGateway,
      this.damageLoRaGateway,
      this.noOfDC,
      this.dC1AStatus,
      this.dC1Btatus,
      this.dC1Status,
      this.dC2Status,
      this.dc3Status,
      this.activeAlarms,
      this.canalStatus});

  ProjectOverviewModel.fromJson(Map<String, dynamic> json) {
    totalOms = json['TotalOms'] ?? 0;
    onlineOms = json['OnlineOms'] ?? 0;
    offlineOms = json['OfflineOms'] ?? 0;
    damageOms = json['DamageOms'] ?? 0;
    totalAms = json['TotalAms'] ?? 0;
    onlineAms = json['OnlineAms'] ?? 0;
    offlineAms = json['OfflineAms'] ?? 0;
    damageAms = json['DamageAms'] ?? 0;
    noOfPS = json['NoOfPS'] ?? 0;
    pS1Status = json['PS1Status'];
    pS2Status = json['PS2Status'];
    pS3Status = json['PS3Status'];
    pS4Status = json['PS4Status'];
    pS5Status = json['PS5Status'];
    pS6Status = json['PS6Status'];
    pS7Status = json['PS7Status'];
    pS8Status = json['PS8Status'];
    pS9Status = json['PS9Status'];
    pS10Status = json['PS10Status'];
    pS11Status = json['PS11Status'];
    pS12Status = json['PS12Status'];
    pS13Status = json['PS13Status'];
    pS14Status = json['PS14Status'];
    pS15Status = json['PS15Status'];
    pS16Status = json['PS16Status'];
    pS17Status = json['PS17Status'];
    pS18Status = json['PS18Status'];
    ps19Status = json['PS19Status'];
    ps20Status = json['PS20Status'];
    ps21Status = json['PS21Status'];
    ps22Status = json['PS22Status'];
    ps23Status = json['PS23Status'];

    totalRms = json['TotalRms'] ?? 0.0;
    onlineRms = json['OnlineRms'] ?? 0.0;
    offlineRms = json['OfflineRms'] ?? 0.0;
    damageRms = json['DamageRms'] ?? 0;
    noOfLoRaGateway = json['NoOfLoRaGateway'] ?? 0.0;
    damageLoRaGateway = json['DamageLoRaGateway'] ?? 0;
    noOfDC = json['NoOfDC'] ?? 0;
    dC1AStatus = json['DC1AStatus'] ?? 0;
    dC1Btatus = json['DC1Btatus'] ?? 0;
    dC1Status = json['DC1Status'] ?? 0;
    dC2Status = json['DC2Status'] ?? 0;
    dc3Status = json['DC3Status'] ?? 0;
    activeAlarms = json['ActiveAlarms'] ?? 0;
    canalStatus = json['CanalStatus'];
  }
/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalOms'] = this.totalOms;
    data['OnlineOms'] = this.onlineOms;
    data['OfflineOms'] = this.offlineOms;
    data['DamageOms'] = this.damageOms;
    data['TotalAms'] = this.totalAms;
    data['OnlineAms'] = this.onlineAms;
    data['OfflineAms'] = this.offlineAms;
    data['DamageAms'] = this.damageAms;
    data['NoOfPS'] = this.noOfPS;
    data['PS1Status'] = this.pS1Status;
    data['PS2Status'] = this.pS2Status;
    data['PS3Status'] = this.pS3Status;
    data['NoOfDC'] = this.noOfDC;
    data['DC1Status'] = this.dC1Status;
    data['DC2Status'] = this.dC2Status;
    data['ActiveAlarms'] = this.activeAlarms;
    return data;
  }
  */
}
