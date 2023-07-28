class ProjectModel {
  int? id;
  String? projectName;
  String? state;

  ProjectModel({this.id, this.projectName, this.state});

  ProjectModel.fromJson(Map<String, dynamic> json) {
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