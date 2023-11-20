import 'dart:convert';

import 'package:chat_app/models/messageModel.dart';
import 'package:chat_app/provider/providerData.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import '../constants.dart';
class MessageService{


  late WebSocketChannel _channel;

  void connectWebSocket() {
    _channel = IOWebSocketChannel.connect('ws://localhost:8080/mesg.sendMessage');
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  void closeWebSocket() {
    _channel.sink.close();
  }

  Stream<dynamic> get onMessage => _channel.stream;

  Future<http.Response> createMessage(Message message) async{

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json"
    };
    final response = await http.post(Uri.parse(baseUrl + '/createMsg' ),headers: headers,  body: jsonEncode(message.toJson())
    );
    print(response.statusCode);
    print(jsonDecode(response.body));
    return response;

  }
  Future<http.Response> getAllMessages(context) async {
    final response = await http.get(Uri.parse(baseUrl + '/allmesg'));
    print(response.statusCode);

    List messages = jsonDecode(response.body);
    List<Message> allMessages = messages.map((e) => Message.fromJson(e)).toList();
    setAllMessages(context: context, val: allMessages);


    return response;
  }
}