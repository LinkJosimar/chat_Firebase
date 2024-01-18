import 'package:cloud_firestore/cloud_firestore.dart';

class TextModel {
  String sala = '';
  DateTime dataHora = DateTime.now();
  String text = '';
  String userId = '';
  String nickName = '';

  TextModel(
      {required this.sala,
      required this.text,
      required this.userId,
      required this.nickName});

  TextModel.fromJson(Map<String, dynamic> json) {
    sala = json['sala'];
    dataHora = (json['data_hora'] as Timestamp).toDate();
    text = json['text'];
    userId = json['user_id'];
    nickName = json['nick_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sala'] = this.sala;
    data['data_hora'] = Timestamp.fromDate(this.dataHora);
    data['text'] = this.text;
    data['user_id'] = this.userId;
    data['nick_name'] = this.nickName;
    return data;
  }
}
