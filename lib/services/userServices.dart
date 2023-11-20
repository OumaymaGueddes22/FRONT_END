

import 'package:chat_app/models/userModel.dart';
import 'package:chat_app/provider/providerData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chat_app/constants.dart';



class UserServices{
  Future<http.Response> createUser(User user) async{
    final response = await http.post(Uri.parse(baseUrl + '/api/v1/auth/register' ),  body: user.toJson()
    );
    return response;

  }
  Future<http.Response> Login(String phonenum, String password,context) async{
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json"
    };
    final response = await http.post(Uri.parse(baseUrl + '/api/v1/auth/authenticate'),headers: headers,
        body: jsonEncode(new UserLogin(phoneNumber: phonenum,password: password).toJson()),
    );
    if(response.statusCode == 200){
      final data=jsonDecode(response.body);
      User user = User.fromJson(data);
      if(user.id != null){setUserId(context: context, val: user.id!);}
      if(user != null){setCurrentUser(context: context, val: user);}

      getAllUsers(context);
    }

    return response;

  }

  Future<http.Response> getAllUsers(context) async {
      final response = await http.get(Uri.parse(baseUrl + '/api/v1/users/allUsers'));
      List allUsers = jsonDecode(response.body);
      List<User> users = allUsers.map((e) => User.fromJson(e)).toList();
      setAllUsers(context: context, val: users);
      return response;
  }

}









