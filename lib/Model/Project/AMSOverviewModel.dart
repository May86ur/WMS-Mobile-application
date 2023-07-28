class Ams_Overview_Model {
  int? iD;
  String? dESCRIPTION;
  int? vALUE;
  String? subProcess;
  bool? isChecked;

  Ams_Overview_Model({this.iD, this.dESCRIPTION, this.vALUE, this.subProcess, this.isChecked});

  Ams_Overview_Model.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    dESCRIPTION = json['DESCRIPTION'];
    vALUE = json['VALUE'];
    subProcess = json['SubProcess'];
    isChecked = false;
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['DESCRIPTION'] = this.dESCRIPTION;
    data['VALUE'] = this.vALUE;
    data['SubProcess'] = this.subProcess;
    data['IsChecked'] = this.isChecked;
    return data;
  }
}
