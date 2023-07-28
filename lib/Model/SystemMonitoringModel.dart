class SystemMonitoringModel {
  int? id;
  String? description;
  String? value;
  String? process;
  String? lastResponseTime;
  String? projectName;
  int? id1;
  String? projectName1;
  String? state;
  int? totalArea;
  String? description1;
  String? project;
  String? hostIp;
  String? userName;
  String? password;
  String? conString;

  SystemMonitoringModel(
      {this.id,
      this.description,
      this.value,
      this.process,
      this.lastResponseTime,
      this.projectName,
      this.id1,
      this.projectName1,
      this.state,
      this.totalArea,
      this.description1,
      this.project,
      this.hostIp,
      this.userName,
      this.password,
      this.conString});

  SystemMonitoringModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    description = json['Description'];
    value = json['Value'];
    process = json['Process'];
    lastResponseTime = json['LastResponseTime'];
    projectName = json['ProjectName'];
    id1 = json['id1'];
    projectName1 = json['ProjectName1'];
    state = json['State'];
    totalArea = json['TotalArea'];
    description1 = json['Description1'];
    project = json['project'];
    hostIp = json['HostIp'];
    userName = json['userName'];
    password = json['Password'];
    conString = json['conString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Description'] = this.description;
    data['Value'] = this.value;
    data['Process'] = this.process;
    data['LastResponseTime'] = this.lastResponseTime;
    data['ProjectName'] = this.projectName;
    data['id1'] = this.id1;
    data['ProjectName1'] = this.projectName1;
    data['State'] = this.state;
    data['TotalArea'] = this.totalArea;
    data['Description1'] = this.description1;
    data['project'] = this.project;
    data['HostIp'] = this.hostIp;
    data['userName'] = this.userName;
    data['Password'] = this.password;
    data['conString'] = this.conString;
    return data;
  }
}
