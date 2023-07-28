class QRDataModel {
  int? id;
  String? mACAddress;
  String? type;
  String? subType;
  String? manufacturingDate;
  String? batchNo;
  String? firmwareVersion;
  int? qCDoneBy;
  String? qCDoneOn;
  String? factorySetting;
  dynamic siteInstallation;
  dynamic testCommission;

  QRDataModel(
      {this.id,
      this.mACAddress,
      this.type,
      this.subType,
      this.manufacturingDate,
      this.batchNo,
      this.firmwareVersion,
      this.qCDoneBy,
      this.qCDoneOn,
      this.factorySetting,
      this.siteInstallation,
      this.testCommission});

  QRDataModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    mACAddress = json['MACAddress'];
    type = json['Type'];
    subType = json['SubType'];
    manufacturingDate = json['ManufacturingDate'];
    batchNo = json['BatchNo'];
    firmwareVersion = json['FirmwareVersion'];
    qCDoneBy = json['QCDoneBy'];
    qCDoneOn = json['QCDoneOn'];
    factorySetting = json['FactorySetting'];
    siteInstallation = json['SiteInstallation'];
    testCommission = json['TestCommission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['MACAddress'] = this.mACAddress;
    data['Type'] = this.type;
    data['SubType'] = this.subType;
    data['ManufacturingDate'] = this.manufacturingDate;
    data['BatchNo'] = this.batchNo;
    data['FirmwareVersion'] = this.firmwareVersion;
    data['QCDoneBy'] = this.qCDoneBy;
    data['QCDoneOn'] = this.qCDoneOn;
    data['FactorySetting'] = this.factorySetting;
    data['SiteInstallation'] = this.siteInstallation;
    data['TestCommission'] = this.testCommission;
    return data;
  }
}

