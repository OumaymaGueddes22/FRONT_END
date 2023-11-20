import 'package:flutter/material.dart';

import 'messageModel.dart';
import 'userModel.dart';
class Conversation{
  late String id;
  late bool isGroup;
  late String typeConversation;
  late List<User> users;
  late List<Message> messages;
}