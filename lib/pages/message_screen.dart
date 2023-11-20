import 'package:chat_app/pages/messages/message_screen_mobile.dart';
import 'package:chat_app/pages/messages/message_screen_web.dart';
import 'package:flutter/material.dart';

import '../provider/providerData.dart';
import '../services/messageService.dart';


class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  @override
  initState() {

    print(getOtherUser(context).toJson());
    MessageService messageServices =new MessageService();
    messageServices.getAllMessages(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (size.width > 1100)?MessageScreenWeb() : MessagesScreenMobile() ;
  }
}

