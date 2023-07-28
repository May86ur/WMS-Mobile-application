class ScheduleMasterModel {
  int? id;
  String? date;
  String? day;
  int? pFCMDNo;
  String? startTime;
  int? duration;
  String? endTime;

  ScheduleMasterModel(
      {this.id,
      this.date,
      this.day,
      this.pFCMDNo,
      this.startTime,
      this.duration,
      this.endTime});

  ScheduleMasterModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    date = json['Date'];
    day = json['Day'];
    pFCMDNo = json['PFCMDNo'];
    startTime = json['StartTime'];
    duration = json['Duration'];
    endTime = json['EndTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Date'] = this.date;
    data['Day'] = this.day;
    data['PFCMDNo'] = this.pFCMDNo;
    data['StartTime'] = this.startTime;
    data['Duration'] = this.duration;
    data['EndTime'] = this.endTime;
    return data;
  }
}
