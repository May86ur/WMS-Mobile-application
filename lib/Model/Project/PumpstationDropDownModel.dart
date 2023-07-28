class PumpStationDropDownModel {
  dynamic pumpStationId;
  String? psName;
  dynamic psPumpDC;
  dynamic psPumpPT;
  dynamic psPumpPS;
  dynamic psPumpMBFV;
  dynamic psPumpPTVAL;
  dynamic psPumpFTVAL;
  dynamic psPumpFTVOL;
  dynamic psPumpHOPD;

  PumpStationDropDownModel(
      {this.pumpStationId,
      this.psName,
      this.psPumpDC,
      this.psPumpPT,
      this.psPumpPS,
      this.psPumpMBFV,
      this.psPumpPTVAL,
      this.psPumpFTVAL,
      this.psPumpFTVOL,
      this.psPumpHOPD});

  PumpStationDropDownModel.fromJson(Map<String, dynamic> json) {
    pumpStationId = json['pumpStationId'];
    psName = json['ps_name'];
    psPumpDC = json['ps_pumpDC'];
    psPumpPT = json['ps_pumpPT'];
    psPumpPS = json['ps_pumpPS'];
    psPumpMBFV = json['ps_pumpMBFV'];
    psPumpPTVAL = json['ps_pumpPTVAL'];
    psPumpFTVAL = json['ps_pumpFTVAL'];
    psPumpFTVOL = json['ps_pumpFTVOL'];
    psPumpHOPD = json['ps_pumpHOPD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pumpStationId'] = this.pumpStationId;
    data['ps_name'] = this.psName;
    data['ps_pumpDC'] = this.psPumpDC;
    data['ps_pumpPT'] = this.psPumpPT;
    data['ps_pumpPS'] = this.psPumpPS;
    data['ps_pumpMBFV'] = this.psPumpMBFV;
    data['ps_pumpPTVAL'] = this.psPumpPTVAL;
    data['ps_pumpFTVAL'] = this.psPumpFTVAL;
    data['ps_pumpFTVOL'] = this.psPumpFTVOL;
    data['ps_pumpHOPD'] = this.psPumpHOPD;
    return data;
  }
}
