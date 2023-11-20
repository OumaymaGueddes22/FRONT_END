import 'package:chat_app/models/messageModel.dart';
import 'package:chat_app/pages/messages/message_screen_mobile.dart';
import 'package:flutter/material.dart';

import '../../provider/providerData.dart';
import '../../services/messageService.dart';

class MessageScreenWeb extends StatefulWidget {
  const MessageScreenWeb({Key? key}) : super(key: key);

  @override
  State<MessageScreenWeb> createState() => _MessageScreenWebState();
}

class _MessageScreenWebState extends State<MessageScreenWeb> {
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
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width*0.3,
            color: Colors.black,
            child: Drawer(
              width: size.width*0.3,
              elevation: 30,
              backgroundColor: Color(0xF3393838),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(40))),
              child: Container(
                decoration: const BoxDecoration(

                    borderRadius: BorderRadius.horizontal(right: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x3D000000), spreadRadius: 30, blurRadius: 20)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: const [
                              SizedBox(),
                              SizedBox(
                                width: 56,
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: const [
                              UserAvatar(filename: 'img3.jpeg'),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Tom Brenan',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          const DrawerItem(
                            title: 'Account',
                            icon: Icons.key,
                          ),
                          const DrawerItem(title: 'Chats', icon: Icons.chat_bubble),
                          const DrawerItem(
                              title: 'Notifications', icon: Icons.notifications),
                          const DrawerItem(
                              title: 'Data and Storage', icon: Icons.storage),
                          const DrawerItem(title: 'Help', icon: Icons.help),
                          const Divider(
                            height: 35,
                            color: Colors.green,
                          ),
                          const DrawerItem(
                              title: 'Invite a friend', icon: Icons.people_outline),
                        ],
                      ),
                      const DrawerItem(title: 'Log out', icon: Icons.logout)
                    ],
                  ),
                ),
              ),
            ),
          ),

          Container(
            width: size.width*0.7,
            margin: EdgeInsets.only(left: size.width*0.3),
            child: MessagesScreenMobile(),
          ),

        ],
      ),
    );
  }
}

Padding buildContactAvatar(String name, String filename) {
  return Padding(
    padding: const EdgeInsets.only(right: 20.0),
    child: Column(
      children: [
        UserAvatar(
          filename: filename,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    ),
  );
}





class UserAvatar extends StatelessWidget {
  final String filename;
  const UserAvatar({
    super.key,
    required this.filename,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 32,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 29,
        backgroundImage: Image.asset('assets/images/$filename').image,
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

Column buildConversationRow(
    String name, String message, String filename, int msgCount) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UserAvatar(filename: filename),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25, top: 5),
            child: Column(
              children: [
                const Text(
                  '16:35',
                  style: TextStyle(fontSize: 10),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (msgCount > 0)
                  CircleAvatar(
                    radius: 7,
                    backgroundColor: const Color(0xFF27c1a9),
                    child: Text(
                      msgCount.toString(),
                      style:
                      const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    ],
  );
}



