import 'dart:async';
import 'dart:convert';

import 'package:chat_app/provider/providerData.dart';
import 'package:chat_app/services/userServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/userModel.dart';
import 'home/home.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _focusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {

    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    checkForCurrentUser(context);
    UserServices userServices = new UserServices();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.green.shade900,
                  Colors.green.shade800,
                  Colors.green.shade400
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),),
                  SizedBox(height: 10,),
                  Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10)
                            )]
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  focusNode: _focusNode,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    if(value.length < 8 ){
                                      return 'This number is too short ';
                                    }
                                    if(value.length >13){
                                      return 'This number is too long';
                                    }
                                    return null;
                                  },
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                      hintText: "Phone number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.phone,color: Colors.green,),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    if (value.length <= 6 ){
                                      return 'Password must contain more than 6 characters';
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.lock,color: Colors.green,)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),
                      Row(
                        children: [
                          Text("Dont have account? ", style: TextStyle(color: Colors.grey),),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushReplacementNamed('signUp');
                            },
                              child: Text("SignUp", style: TextStyle(color: Colors.green),
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 40,),
                      Container(
                        width: (size.width >500)? 500 : size.width*0.8,
                        child: MaterialButton(
                          onPressed: ()async{
                              if (_formKey.currentState!.validate()) {
                                var response= await userServices.Login(phoneController.text.toString(), passwordController.text.toString(),context);

                                if(response.statusCode == 200){

                                  showAwesomeDialog(context, DialogType.success, 'Login', 'Successful');
                                  final data=jsonDecode(response.body);
                                  User user = User.fromJson(data);
                                  setCurrentUser(context: context, val: user);
                                  final prefs = await SharedPreferences.getInstance();
                                  final userJson = json.encode(user.toJson());
                                  prefs.setString('currentUser', userJson);

                                  Future.delayed(Duration(seconds: 3), () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => const MyHomePage(),
                                      ),
                                    );
                                  });

                                }
                                else{
                                  showAwesomeDialog(context,DialogType.error,'Failed to connect','something wrong');
                                }
                              }
                          },
                          height: 50,
                          // margin: EdgeInsets.symmetric(horizontal: 50),
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),

                          ),
                          // decoration: BoxDecoration(
                          // ),
                          child: Center(
                            child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),

                      SizedBox(height: 30,),

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
void showAwesomeDialog(context,DialogType,String title,String text){
  AwesomeDialog(
      context: context,
      dialogType: DialogType,
      animType: AnimType.rightSlide,
      title: title,
      desc: text,

  )..show();
  Future.delayed(Duration(seconds: 3), () {
    Navigator.of(context).pop();
  });
}
void checkForCurrentUser(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final userJson = prefs.getString('currentUser');
  final otherJson = prefs.getString('otherUser');

  if (userJson != null) {
    // User data is available, navigate to the home page
    print(userJson);
    final data = jsonDecode(userJson);
    User user = User.fromJson(data);

    // Set the current user
    setCurrentUser(context: context, val: user);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      ),
    );
  }
  if (otherJson != null) {
    print(otherJson);
    final data = jsonDecode(otherJson);
    User user = User.fromJson(data);

    // Set the current user
    setOtherUser(context: context, val: user);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      ),
    );
  }
}

