import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/userModel.dart';
import '../../provider/providerData.dart';
import '../../services/messageService.dart';
import '../../services/userServices.dart';


class HomeMobile extends StatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    UserServices userServices = UserServices();
    await userServices.getAllUsers(context);

    MessageService messageServices = MessageService();
    await messageServices.getAllMessages(context);
    checkForotherUser(context);
    await messageServices.getAllMessages(context);


    // You may want to call setState here to trigger a rebuild of the widget
    if (mounted) {
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    List<User> allusers = getAllUsers(context);
    User user = getCurrentUser(context);
    final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
    return Scaffold(
      key: _globalKey,
      backgroundColor: const Color(0xFF171717),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          _globalKey.currentState!.openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        )),

                    Row(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            height: 30,
                            width: 200,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(bottom: 12,left: 20,),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                                contentPadding: EdgeInsets.only(bottom: 15),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Icon(Icons.search,color: Colors.white,),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 10),
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Messages",
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        )),
                    const SizedBox(
                      width: 35,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Online",
                          style: TextStyle(color: Colors.grey, fontSize: 26),
                        )),
                    const SizedBox(
                      width: 35,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Groups",
                          style: TextStyle(color: Colors.grey, fontSize: 26),
                        )),
                    const SizedBox(
                      width: 35,
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 190,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
              height: 220,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Users",
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      itemCount: allusers.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return GestureDetector(
                            onTap: () async {
                              final prefs = await SharedPreferences.getInstance();
                              final userJson = json.encode(allusers[index].toJson());
                              prefs.setString('otherUser', userJson);
                              setOtherUser(context: context, val: allusers[index]);
                              Navigator.of(context).pushNamed('Message_screen');
                            },
                            child: (allusers[index].id != getCurrentUser(context).id)?buildContactAvatar(allusers[index].fullName, 'img1.jpeg'):SizedBox()
                        );
                      },

                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 365,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Color(0xFFEFFFFC),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 25),
                  itemCount: 0,
                  itemBuilder: (context, index){
                    return buildConversationRow('Laura', 'Hello, how are you', 'img1.jpeg', 0);
                  },
                  // children: [
                  //   buildConversationRow(
                  //       'Laura', 'Hello, how are you', 'img1.jpeg', 0),
                  //   buildConversationRow(
                  //       'Kalya', 'Will you visit me', 'img2.jpeg', 2),
                  //   buildConversationRow(
                  //       'Mary', 'I ate your ...', 'img3.jpeg', 6),
                  //   buildConversationRow(
                  //       'Hellen', 'Are you with Kayla again', 'img5.jpeg', 0),
                  //   buildConversationRow(
                  //       'Louren', 'Barrow money please', 'img6.jpeg', 3),
                  //   buildConversationRow('Tom', 'Hey, whatsup', 'img7.jpeg', 0),
                  //   buildConversationRow(
                  //       'Laura', 'Helle, how are you', 'img1.jpeg', 0),
                  //   buildConversationRow(
                  //       'Laura', 'Helle, how are you', 'img1.jpeg', 0),
                  // ],
                ),
              ))
        ],
      ),

      drawer: Drawer(
        width: 275,
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
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          width: 56,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children:  [
                        UserAvatar(filename: 'img3.jpeg'),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (user.fullName != null)?Text(
                              user.fullName,
                              style: TextStyle(color: Colors.white),
                            ):SizedBox(),
                            (user.email != null)?Text(
                              user.email,
                              style: TextStyle(color: Colors.white),
                            ):SizedBox(),
                            (user.phoneNumber != null)?Text(
                              user.phoneNumber,
                              style: TextStyle(color: Colors.white),
                            ):SizedBox()
                          ],
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    DrawerItem(
                      title: 'Account',
                      icon: Icons.key,
                      onTap: (){},
                    ),
                    DrawerItem(title: 'Chats', icon: Icons.chat_bubble,onTap: (){},),
                    DrawerItem(
                      title: 'Notifications', icon: Icons.notifications,onTap: (){},),
                    DrawerItem(
                      title: 'Data and Storage', icon: Icons.storage,onTap: (){},),
                    DrawerItem(title: 'Help', icon: Icons.help,onTap: (){},),
                    const Divider(
                      height: 35,
                      color: Colors.green,
                    ),
                    DrawerItem(
                      title: 'Invite a friend', icon: Icons.people_outline,onTap: (){},),
                  ],
                ),
                DrawerItem(title: 'Log out', icon: Icons.logout,onTap: (){
                  Navigator.of(context).pushReplacementNamed('Login');
                },)
              ],
            ),
          ),
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
      const Divider(
        indent: 70,
        height: 20,
      )
    ],
  );
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
          style: const TextStyle(color: Colors.white, fontSize: 14),
        )
      ],
    ),
  );
}


class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
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

void checkForotherUser(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final userJson = prefs.getString('otherUser');

  if (userJson != null) {
    final data = jsonDecode(userJson);
    User user = User.fromJson(data);
    setOtherUser(context: context, val: user);

  }
}