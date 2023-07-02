import 'package:cloud_firestore/cloud_firestore.dart';

class HelpModel {
  String? uid;
  String? content;
  String? pdf;
  String? title;
  Timestamp? dateTime;
  String? nickName;
  String? dept;


  HelpModel({
    required this.uid,
    required this.content,
    required this.pdf,
    required this.title,
    required this.dateTime,
    required this.nickName,
    required this.dept,
  });

  HelpModel.fromJson(Map<String,dynamic>json){
    uid = json['uid'];
    content = json['content'];
    pdf = json['pdf'];
    title = json['title'];
    dateTime = json['dateTime'];
    nickName = json['nickName'];
    dept = json['dept'];
  }
  Map<String,dynamic>toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    uid = data['uid'];
    content = data['content'];
    pdf = data['pdf'];
    title = data['title'];
    dateTime = data['dateTime'];
    nickName = data['nickName'];
    dept = data['dept'];
    return data;
  }
}