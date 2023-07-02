import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? uid;
  String? content;
  String? image;
  String? title;
  Timestamp? dateTime;
  String? nickName;
  String? dept;

  EventModel({
    required this.uid,
    required this.content,
    required this.image,
    required this.title,
    required this.dateTime,
    required this.nickName,
    required this.dept,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    content = json['content'];
    image = json['image'];
    title = json['title'];
    dateTime = json['dateTime'];
    nickName = json['nickName'];
    dept = json['dept'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    uid = data['uid'];
    content = data['content'];
    image = data['image'];
    title = data['title'];
    dateTime = data['dateTime'];
    nickName = data['nickName'];
    dept = data['dept'];
    return data;
  }
}
