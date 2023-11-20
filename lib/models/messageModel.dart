import 'package:flutter/material.dart';
class Message{
  late String id;
  late String txt;
  late String type;
  late String sender;
  late String reciever;

  Message({required this.id,required this.txt,required this.type,required this.sender,required this.reciever});

  Message.fromJson(Map<String, dynamic> json){
    id = json['id'];
    txt = json['txt'];
    type = json['typeMessage'];
    sender = json['sender'];
    reciever = json['reciever'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['txt'] = this.txt;
    data['typeMessage'] = this.type;
    data['sender'] = this.sender;
    data['reciever'] = this.reciever;

    return data;
  }

}