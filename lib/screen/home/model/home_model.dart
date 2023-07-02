import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {
  String? uid;
  String? content;
  String? title;
  Timestamp? dateTime;
  String? nickName;
  String? dept;
  Timestamp? endDate ;


  HomeModel({
    required this.uid,
    required this.content,
    required this.title,
    required this.dateTime,
    required this.nickName,
    required this.dept,
    required this.endDate,
  });

  HomeModel.fromJson(Map<String,dynamic>json){
    uid = json['uid'];
    content = json['content'];
    title = json['title'];
    dateTime = json['dateTime'];
    nickName = json['nickName'];
    dept = json['dept'];
    endDate = json['endDate'];
  }
  Map<String,dynamic>toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    uid = data['uid'];
    content = data['content'];
    title = data['title'];
    dateTime = data['dateTime'];
    nickName = data['nickName'];
    dept = data['dept'];
    endDate = data['endDate'];
    return data;
  }
}