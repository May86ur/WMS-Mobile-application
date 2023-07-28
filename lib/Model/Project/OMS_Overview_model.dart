class OMS_Overview_model {
  int? iD;
  String? dESCRIPTION;
  int? vALUE;
  String? subProcess;
  bool? isChecked;
  String? chkData;
  OMS_Overview_model(
      {this.iD,
      this.dESCRIPTION,
      this.vALUE,
      this.subProcess,
      this.isChecked,
      this.chkData});

  OMS_Overview_model.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    dESCRIPTION = json['DESCRIPTION'];
    vALUE = json['VALUE'];
    subProcess = json['SubProcess'];
    chkData = json['chkData'];
    isChecked = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['DESCRIPTION'] = this.dESCRIPTION;
    data['VALUE'] = this.vALUE;
    data['SubProcess'] = this.subProcess;
    data['chkData'] = this.chkData;
    data['IsChecked'] = this.isChecked;
    return data;
  }
}

 /* 
OMS_Overview_model
  Use private fields 
class OMS_Overview_model {
  int? id;
  String? description;
  String? process;
  int? value;

  OMS_Overview_model({this.id, this.description, this.process, this.value});

  OMS_Overview_model.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    description = json['Description'];
    process = json['Process'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Description'] = this.description;
    data['Process'] = this.process;
    data['Value'] = this.value;
    return data;
  }
}*/