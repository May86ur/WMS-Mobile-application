class ScheduleSQLMasterModel {
  int? refId;
  int? day;
  String? irriDate;
  String? displayStr;
  String? startTime;
  String? endTime;
  int? valMin;

  ScheduleSQLMasterModel(
      {this.refId,
      this.day,
      this.irriDate,
      this.displayStr,
      this.startTime,
      this.endTime,
      this.valMin});

  ScheduleSQLMasterModel.fromJson(Map<String, dynamic> json) {
    refId = json['RefId'];
    day = json['Day'];
    irriDate = json['IrriDate'];
    displayStr = json['DisplayStr'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    valMin = json['Val_min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefId'] = this.refId;
    data['Day'] = this.day;
    data['IrriDate'] = this.irriDate;
    data['DisplayStr'] = this.displayStr;
    data['StartTime'] = this.startTime;
    data['EndTime'] = this.endTime;
    data['Val_min'] = this.valMin;
    return data;
  }
}
