class KOMSdataModel {
  int? all;
  int? tOTALOMS;
  int? oNLINEOMS;
  int? oFFLINEOMS;
  int? dAMAGEOMS;

  KOMSdataModel(
      {this.all,
      this.tOTALOMS,
      this.oNLINEOMS,
      this.oFFLINEOMS,
      this.dAMAGEOMS});

  KOMSdataModel.fromJson(Map<String, dynamic> json) {
    all = json['All'];
    tOTALOMS = json['TOTAL_OMS'];
    oNLINEOMS = json['ONLINE_OMS'];
    oFFLINEOMS = json['OFFLINE_OMS'];
    dAMAGEOMS = json['DAMAGE_OMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['All'] = this.all;
    data['TOTAL_OMS'] = this.tOTALOMS;
    data['ONLINE_OMS'] = this.oNLINEOMS;
    data['OFFLINE_OMS'] = this.oFFLINEOMS;
    data['DAMAGE_OMS'] = this.dAMAGEOMS;
    return data;
  }
}
