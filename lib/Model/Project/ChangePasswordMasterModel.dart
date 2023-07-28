class ChangePasswordMasterModel {
  String? response;
  String? status;
  Null? message;

  ChangePasswordMasterModel({this.response, this.status, this.message});

  ChangePasswordMasterModel.fromJson(Map<String, dynamic> json) {
    response = json['Response'];
    status = json['Status'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Response'] = this.response;
    data['Status'] = this.status;
    data['Message'] = this.message;
    return data;
  }
}
