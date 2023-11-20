import 'package:chat_app/pages/home/homemobile.dart';
import 'package:flutter/material.dart';

import '../../models/userModel.dart';
import '../../provider/providerData.dart';
import 'homeweb.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return (size.width > 800) ? HomeWeb() : HomeMobile();
  }
}



