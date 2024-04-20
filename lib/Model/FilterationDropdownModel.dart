class FiltrationDropDownModel {
  int? filterStationId;
  String? fsName;
  int? fsPumpDPS;
  int? psPumpInletValve;

  FiltrationDropDownModel(
      {this.filterStationId,
      this.fsName,
      this.fsPumpDPS,
      this.psPumpInletValve});

  FiltrationDropDownModel.fromJson(Map<String, dynamic> json) {
    filterStationId = json['filterStationId'];
    fsName = json['fs_name'];
    fsPumpDPS = json['fs_pumpDPS'];
    psPumpInletValve = json['ps_pumpInletValve'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filterStationId'] = this.filterStationId;
    data['fs_name'] = this.fsName;
    data['fs_pumpDPS'] = this.fsPumpDPS;
    data['ps_pumpInletValve'] = this.psPumpInletValve;
    return data;
  }
}
