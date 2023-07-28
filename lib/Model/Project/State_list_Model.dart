/*
class State_list_Model {
  int? id;
  String? projectName;
  String? state;

  State_list_Model({this.id, this.projectName, this.state});

  State_list_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['ProjectName'];
    state = json['State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ProjectName'] = this.projectName;
    data['State'] = this.state;
    return data;
  }
}
*/

class State_list_Model {
  int? id;
  String? projectName;
  String? state;
  int? totalArea;
  String? description;
  String? project;
  dynamic clientLogo;
  dynamic contractorLogo;
  String? userType;
  String? hostIp;
  String? userName;
  String? password;
  String? conString;

  State_list_Model(
      {this.id,
      this.projectName,
      this.state,
      this.totalArea,
      this.description,
      this.project,
      this.clientLogo,
      this.contractorLogo,
      this.userType,
      this.hostIp,
      this.userName,
      this.password,
      this.conString});

  State_list_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['ProjectName'];
    state = json['State'];
    totalArea = json['TotalArea'];
    description = json['Description'];
    project = json['project'];
    clientLogo = json['clientLogo'];
    contractorLogo = json['contractorLogo'];
    userType = json['User_Type'];
    hostIp = json['HostIp'];
    userName = json['userName'];
    password = json['Password'];
    conString = json['conString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ProjectName'] = this.projectName;
    data['State'] = this.state;
    data['TotalArea'] = this.totalArea;
    data['Description'] = this.description;
    data['project'] = this.project;
    data['clientLogo'] = this.clientLogo;
    data['contractorLogo'] = this.contractorLogo;
    data['User_Type'] = this.userType;
    data['HostIp'] = this.hostIp;
    data['userName'] = this.userName;
    data['Password'] = this.password;
    data['conString'] = this.conString;
    return data;
  }
}
