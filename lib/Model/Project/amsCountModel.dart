class amsCountModel {
  int? scount;

  amsCountModel({this.scount});

  amsCountModel.fromJson(Map<String, dynamic> json) {
    scount = json['Scount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Scount'] = this.scount;
    return data;
  }
}
