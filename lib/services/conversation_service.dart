//import 'dart:convert';

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/services/base_api.dart';
import 'package:http/http.dart' as http;

class ConversationService  extends BaseApi{
  Future<http.Response> getConversations() async {
    return await api.httpGet('conversations');
  }
  Future<http.Response> getLastConversation() async {
    return await api.httpGet('lastconversation');
  }
  Future<http.Response> newConversation(String userId, String message, String carId) async {
    return await api.httpPost('conversations', {
      'user_id':userId,
      'message':message,
      'car_id':carId
    });
  }
  Future<http.Response> storeMessage(MessageModel message) async {
    return await api.httpPost('messages', {
      'body':message.body,
      'conversation_id': message.conversationId.toString()
      }
    );
  }
}