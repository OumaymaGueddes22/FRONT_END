import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class User{
  late String? id;
  late String fullName;
  late String phoneNumber;
  late String email;
  late String image;
  late String? password;
  late String? role;
  late String? resetCode;




  User({required this.id,required this.fullName,required this.phoneNumber,required this.email,required this.password,required this.role,required this.image,required this.resetCode});

   User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    password = json['password'] ?? '';
    role = json['role'] ?? ''; // Provide a default value if it's null
    image = json['image'] ?? ''; // Provide a default value if it's null
    resetCode = json['resetCode'] ?? '';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    data['image'] = this.role;
    data['resetCode'] = this.resetCode;

    return data;
  }
}
class UserLogin{
  String? phoneNumber;
  String? password;
  UserLogin({required this.phoneNumber,this.password});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    return data;
  }

}
