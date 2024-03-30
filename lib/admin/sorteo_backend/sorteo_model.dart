class SorteoModel {
  int? limiteParticipantes;
  String? uid;

  SorteoModel({this.limiteParticipantes, this.uid});

  SorteoModel.fromJson(Map<String, dynamic> json) {
    limiteParticipantes = json['limite_participantes'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limite_participantes'] = this.limiteParticipantes;
    data['uid'] = this.uid;
    return data;
  }
}