class countModel {
  int? scount;

  countModel({this.scount});

  countModel.fromJson(Map<String, dynamic> json) {
    scount = json['Scount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Scount'] = this.scount;
    return data;
  }
}
