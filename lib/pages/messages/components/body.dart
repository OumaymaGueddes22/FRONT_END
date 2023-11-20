
import 'dart:convert';

import 'package:chat_app/services/messageService.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../../constants.dart';
import '../../../models/ChatMessage.dart';
import '../../../models/messageModel.dart';
import '../../../provider/providerData.dart';
import 'chat_input_field.dart';
import 'message.dart';

// Import statements



class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late StompClient client;
  @override
  void initState() {

    super.initState();
    _loadMessages();
     client = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/ws',
        onConnect: onConnectCallback,
      ),
    );
    client.activate();

  }
  void onConnectCallback(StompFrame frame){
    print('connected');
    Future.delayed(Duration(seconds: 1), () async {
      try {
        await client.subscribe(
          destination: '/topic/public',
          headers: {},
          callback: (frame) {

              Message receivedMessage = Message.fromJson(jsonDecode(frame.body!));
              List<Message> all = getAllMessages(context);
              all.add(receivedMessage);
              print(getAllMessages(context).length);
              setAllMessages(context: context, val: all);
              setState(() {

              });


            print('Received message: ${frame.body}');
          },
        );
        print('Subscription successful');
      } catch (e) {
        print('Error subscribing: $e');
      }

    });
  }

  // void onConnectCallback(StompFrame connectFrame) {
  //
  // }

  Future<void> _loadMessages() async {
    MessageService messageServices = MessageService();
    await messageServices.getAllMessages(context);
    setState(() {}); // Trigger a rebuild after loading messages
  }
  @override
  Widget build(BuildContext context) {
    MessageService messageServices = MessageService();
    List<Message> allMessages = getAllMessages(context);
    List<Message> userMessages = [];

    allMessages.forEach((message) {
      if (getCurrentUser(context).id == message.sender) {
        if (getOtherUser(context).id == message.reciever) {
          userMessages.add(message);
        }
      }
      if (getCurrentUser(context).id == message.reciever) {
        if (getOtherUser(context).id == message.sender) {
          userMessages.add(message);
        }
      }
    });

    List<ChatMessage> chatMessages = userMessages.map((e) => ChatMessage(
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: e.sender == getCurrentUser(context).id,
      text: e.txt,
    )).toList();

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: userMessages.length,
              itemBuilder: (context, index) {
                return MessageWidget(message: chatMessages[index]);
              },
            ),
          ),
        ),
         ChatInputField(client: client,),
      ],
    );
  }
}
