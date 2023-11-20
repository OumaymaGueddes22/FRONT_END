import 'dart:convert';

import 'package:chat_app/provider/providerData.dart';
import 'package:chat_app/services/messageService.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/messageModel.dart';
import '../../../models/userModel.dart';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'body.dart';



class ChatInputField extends StatefulWidget {
  final StompClient client;
  const ChatInputField( {
    required this.client,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  void initState() {

    super.initState();
  }
  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    MessageService messageService = new MessageService();
    User currentUser = getCurrentUser(context) as User;
    User otherUser = getOtherUser(context) as User;
    final tcontroller = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(Icons.mic, color: kPrimaryColor),
            const SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.64),
                    ),
                    const SizedBox(width: kDefaultPadding / 4),
                     Expanded(
                      child: TextField(
                        controller: tcontroller,
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.64),
                    ),
                    const SizedBox(width: kDefaultPadding / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.64),
                    ),
                    IconButton(onPressed: ()async{
                      if(tcontroller.text .toString().isNotEmpty){
                        Message message = new Message(id: '', txt: tcontroller.text.toString(), type: 'type', sender: currentUser.id!, reciever: otherUser.id!);

                        var responce = await messageService.createMessage(message);
                        if (responce.statusCode == 201){
                          widget.client.send(
                            destination: '/app/test.send',
                            body: json.encode(message.toJson()),
                          );
                          tcontroller.clear();
                        }
                      }


                    },
                        icon: Icon(Icons.send,color: Colors.green,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
