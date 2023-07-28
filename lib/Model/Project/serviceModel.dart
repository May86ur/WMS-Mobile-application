class ServiceModel {
  int? id;
  String? description;
  String? process;
  int? value;
  bool? isChecked;

  ServiceModel(
      {this.id, this.description, this.process, this.value, this.isChecked});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    description = json['Description'];
    process = json['Process'];
    value = json['Value'];
    isChecked = json['IsChecked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Description'] = this.description;
    data['Process'] = this.process;
    data['Value'] = this.value;
    data['IsChecked'] = this.isChecked;
    return data;
  }
}
