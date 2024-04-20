class ActiveAlarmNotifyMasterModel {
  int? tagId;
  String? tagName;
  String? data;
  String? description;
  String? alarmStartDate;
  int? isSend;

  ActiveAlarmNotifyMasterModel(
      {this.tagId,
      this.tagName,
      this.data,
      this.description,
      this.alarmStartDate,
      this.isSend});

  ActiveAlarmNotifyMasterModel.fromJson(Map<String, dynamic> json) {
    tagId = json['tagId'];
    tagName = json['TagName'];
    data = json['data'];
    description = json['description'];
    alarmStartDate = json['AlarmStartDate'];
    isSend = json['isSend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagId'] = this.tagId;
    data['TagName'] = this.tagName;
    data['data'] = this.data;
    data['description'] = this.description;
    data['AlarmStartDate'] = this.alarmStartDate;
    data['isSend'] = this.isSend;
    return data;
  }
}
