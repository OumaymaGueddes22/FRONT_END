import 'dart:async';
import 'dart:convert';

import 'package:chat_app/pages/home/home.dart';
import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/message_screen.dart';
import 'package:chat_app/pages/signUp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/provider/providerData.dart';



void main() async {
  // client.activate();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProviderData(),
      child: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        drawerTheme: const DrawerThemeData(scrimColor: Colors.transparent),
      ),
      title: 'Chat Box',
      home: LoginPage(),
      routes: {
        'signUp': (context) => SignUpPage(),
        'Login': (context) => const LoginPage(),
        'Home': (context) => const MyHomePage(),
        'Message_screen': (context) => const MessageScreen(),
      },
    );
  }
}
// // final stompClient = StompClient(
// //   config: StompConfig(
// //     url: 'ws://localhost:8080/ws',
// //     onConnect: onConnect,
// //     onWebSocketError: (dynamic error) {
// //       print('WebSocket Error: $error');
// //     },
// //   ),
// // );
// //
// // void onConnect(StompFrame frame) {
// //   print('WebSocket connected');
// //
// //   if (frame.body != null) {
// //     // Decode the JSON directly from the frame body
// //     Map<String, dynamic> result = json.decode(frame.body!);
// //     print(result);
// //   } else {
// //     print('Received frame with no body');
// //   }
// //
// //   // Uncomment this if you want to send a message immediately upon connection
// //   // sendChatMessage();
// //
// //   // Uncomment this if you want to send periodic messages
// //   // Timer.periodic(const Duration(seconds: 10), (_) {
// //   //   sendChatMessage();
// //   // });
// // }
//
// void sendChatMessage() {
//   Map<String, dynamic> messageData = {
//
//   };
//   stompClient.send(
//     destination: '/app/mesg.sendMessage',
//     body: json.encode({'txt': 'test'}),
//   );
//
//   print('Message sent successfully: $messageData');
// }
