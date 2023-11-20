import 'dart:convert';

import 'package:chat_app/constants.dart';
import 'package:chat_app/provider/providerData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/userModel.dart';
import '../../services/messageService.dart';
import 'components/body.dart';

class MessagesScreenMobile extends StatefulWidget {
  const MessagesScreenMobile({Key? key}) : super(key: key);

  @override
  State<MessagesScreenMobile> createState() => _MessagesScreenMobileState();
}

class _MessagesScreenMobileState extends State<MessagesScreenMobile> {
  @override
  initState() {
    super.initState();
    checkForotherUser(context);
    MessageService messageServices = MessageService();
    messageServices.getAllMessages(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(onPressed: (){Navigator.of(context).pushReplacementNamed('Login');}, icon: Icon(Icons.arrow_back,color: Colors.white,)),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (getOtherUser(context).fullName != null)
                  ? Text(
                getOtherUser(context).fullName,
                style: TextStyle(fontSize: 16),
              )
                  : SizedBox(),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [],
    );
  }
}

void checkForotherUser(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final userJson = prefs.getString('otherUser');

  if (userJson != null) {
    final data = jsonDecode(userJson);
    User user = User.fromJson(data);
    setOtherUser(context: context, val: user);
  }
}