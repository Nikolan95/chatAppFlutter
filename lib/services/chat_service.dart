//import 'dart:convert';

import 'dart:convert';

import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/services/base_api.dart';
import 'package:http/http.dart' as http;

class ChatService extends BaseApi {
  Future<http.Response> getChats() async {
    return await api.httpGet('conversations');
  }

  Future<http.Response> getLastChat() async {
    return await api.httpGet('lastconversation');
  }

  Future<http.Response> newChat(
      String userId, String message, String carId) async {
    return await api.httpPost('conversations',
        {'user_id': userId, 'message': message, 'car_id': carId});
  }

  Future<http.Response> messageSeen(conversationId) async {
    return await api.httpPost(
        'conversations/read', {'conversation_id': conversationId.toString()});
  }

  Future<http.Response> storeMessage(ChatMessage message) async {
    if (message.image == null) {
      message.image = " ";
    }
    return await api.httpPost('messages', {
      'body': message.body,
      'image': message.image,
      'conversation_id': message.chatId.toString()
    });
  }

  Future<http.Response> updateMessage(int id, String offer) async {
    return await api.httpPost('messages/update',
        {'id': json.encode(id), 'accept_offer': offer, '_method': 'PUT'});
  }
}
