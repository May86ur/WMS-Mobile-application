class ProjectReportModel {
  int? id;
  String? projectName;
  String? state;
  String? project;
  int? areaId;
  String? conString;

  ProjectReportModel(
      {this.id,
      this.projectName,
      this.state,
      this.project,
      this.areaId,
      this.conString});

  ProjectReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['ProjectName'];
    state = json['State'];
    project = json['project'];
    areaId = json['areaId'];
    conString = json['conString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ProjectName'] = this.projectName;
    data['State'] = this.state;
    data['project'] = this.project;
    data['areaId'] = this.areaId;
    data['conString'] = this.conString;
    return data;
  }
}
