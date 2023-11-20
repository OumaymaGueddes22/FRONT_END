import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/messageModel.dart';
import '../models/userModel.dart';

class ProviderData extends ChangeNotifier {
  late User currentUser;
  late User otherUser ;
  late List<User> allUsers = [];
  late List<Message> allMessages = [];
  String userId = '';

  ProviderData() {
    currentUser = User(id: '', fullName: '', phoneNumber: '', email: '', password: '', role: '', image: '', resetCode: '');
    otherUser = User(id: '', fullName: '', phoneNumber: '', email: '', password: '', role: '', image: '', resetCode: '');
    initializeFromSharedPreferences();
  }
  void addMessage(Message message) {
    allMessages.add(message);
    notifyListeners();
  }
  Future<void> initializeFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userJson = prefs.getString('currentUser');

    if (userJson != null) {
      try {
        final data = jsonDecode(userJson) as Map<String, dynamic>;
        User user = User.fromJson(data);
        setCurrentUser(val: user);
      } catch (e) {
        print('Error decoding user JSON: $e');
      }
    }
    String? otherUserJson = prefs.getString('otherUser');
    print(otherUserJson);

    if (otherUserJson != null) {
      try {
        final data = jsonDecode(otherUserJson) as Map<String, dynamic>;
        User otherUser = User.fromJson(data);
        setOtherUser(val: otherUser);
        notifyListeners();
      } catch (e) {
        print('Error decoding other user JSON: $e');
      }
    } else {
      print('otherUserJson is null');
    }

    notifyListeners();
  }


  void setUserID({required String val}) {
    userId = val;
    notifyListeners();
  }

  void setAllUsers({required List<User> val}) {
    allUsers = val;
    notifyListeners();
  }

  void setCurrentUser({required User val}) {
    currentUser = val;
    notifyListeners();
  }

  void setOtherUser({required User val}) {
    otherUser = val;
    notifyListeners();
  }

  void setAllMessages({required List<Message> val}) {
    allMessages = val;
    notifyListeners();
  }
}

// helpers.dart

setUserId({required context, required String val}) {
  Provider.of<ProviderData>(context, listen: false).setUserID(val: val);
}

String getUserId(context) {
  return Provider.of<ProviderData>(context, listen: false).userId;
}

setAllUsers({required context, required List<User> val}) {
  Provider.of<ProviderData>(context, listen: false).setAllUsers(val: val);
}

List<User> getAllUsers(context) {
  return Provider.of<ProviderData>(context, listen: false).allUsers;
}

setAllMessages({required context, required List<Message> val}) {
  Provider.of<ProviderData>(context, listen: false).setAllMessages(val: val);
}

List<Message> getAllMessages(context) {
  return Provider.of<ProviderData>(context, listen: false).allMessages;
}

setCurrentUser({required context, required User val}) {
  Provider.of<ProviderData>(context, listen: false).setCurrentUser(val: val);
}

User getCurrentUser(context) {
  return Provider.of<ProviderData>(context, listen: false).currentUser;
}

setOtherUser({required context, required User val}) {
  Provider.of<ProviderData>(context, listen: false).setOtherUser(val: val);
}

User getOtherUser(context) {
  return Provider.of<ProviderData>(context, listen: false).otherUser;
}
// Future<User> getOtherUser2(context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? otherUserJson = prefs.getString('otherUser');
//   if (otherUserJson != null) {
//     try {
//       final data = jsonDecode(otherUserJson) as Map<String, dynamic>;
//       User otherUser = User.fromJson(data);
//       return otherUser;
//     } catch (e) {
//       print('Error decoding other user JSON: $e');
//     }
//   }
//   return Provider.of<ProviderData>(context, listen: false).otherUser;
// }