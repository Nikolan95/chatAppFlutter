//import 'dart:convert';

import 'dart:convert';

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/services/base_api.dart';
import 'package:http/http.dart' as http;

class ConversationService extends BaseApi {
  Future<http.Response> getConversations() async {
    return await api.httpGet('conversations');
  }

  Future<http.Response> getLastConversation() async {
    return await api.httpGet('lastconversation');
  }

  Future<http.Response> newConversation(
      String userId, String message, String carId) async {
    return await api.httpPost('conversations',
        {'user_id': userId, 'message': message, 'car_id': carId});
  }

  Future<http.Response> messageSeen(conversationId) async {
    return await api.httpPost(
        'conversations/read', {'conversation_id': conversationId.toString()});
  }

  Future<http.Response> storeMessage(MessageModel message) async {
    if (message.image == null) {
      message.image = " ";
    }
    return await api.httpPost('messages', {
      'body': message.body,
      'image': message.image,
      'conversation_id': message.conversationId.toString()
    });
  }

  Future<http.Response> updateMessage(int id, String offer) async {
    return await api.httpPost('messages/update',
        {'id': json.encode(id), 'accept_offer': offer, '_method': 'PUT'});
  }
}
