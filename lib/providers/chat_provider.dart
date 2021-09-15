import 'dart:convert';

import 'package:chat_app/models/chat.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/providers/base_provider.dart';
import 'package:chat_app/services/chat_service.dart';

class ChatProvider extends BaseProvider {
  ChatService _chatService = ChatService();
  List<Chat> _chats = [];
  List<Chat> get chats => _chats;

  Future<List<Chat>> getChats() async {
    if (_chats.isNotEmpty) return _chats;
    setBusy(true);
    var response = await _chatService.getChats();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data['data'].forEach((chat) => _chats.add(Chat.fromJson(chat)));
      print(response.body);
      notifyListeners();
      setBusy(false);
    }
    return _chats;
  }

  updateSeenedMessages(chatId) {
    for (var line in _chats) {
      if (line.id == chatId) {
        for (var messageLine in line.messages) {
          messageLine.read = 1;
          notifyListeners();
        }
      }
    }
  }

  Future<void> messageSeen(chatId) async {
    setBusy(true);
    var response = await _chatService.messageSeen(chatId);
    //print(response.body);
    if (response.statusCode == 200) {
      updateSeenedMessages(chatId);
      //print('fggfhf');
      setBusy(false);
    }
    setBusy(false);
  }

  Future<void> storeMessage(ChatMessage message) async {
    setBusy(true);
    var response = await _chatService.storeMessage(message);
    print(response.body);
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      setBusy(false);
      addMessageToChat(message.chatId, ChatMessage.fromJson(data['data']));
    }
    setBusy(false);
  }

  Future<void> updateMessage(int id, String offer) async {
    setBusy(true);
    var response = await _chatService.updateMessage(id, offer);
    print(response.body);
    if (response.statusCode == 200) {
      var response = await _chatService.getLastChat();
      var data = jsonDecode(response.body);

      print(response.body);
      notifyListeners();
      setBusy(false);
      return _chats;
    }
  }

  addMessageToChat(int chatId, ChatMessage message) {
    var chats = _chats.firstWhere((chat) => chat.id == chatId);
    chats.messages.add(message);
    //print(chats.id);
    toTheTop(chats);
    notifyListeners();
  }

  toTheTop(Chat chat) {
    var index = _chats.indexOf(chat);

    for (var i = index; i > 0; i--) {
      var x = _chats[i] = _chats[i - 1];
      _chats[i - 1] = x;
    }
  }

  Future<void> storeChat(String userId, String message, String carId) async {
    setBusy(true);
    var response = await _chatService.newChat(userId, message, carId);
    print(response.body);
    if (response.statusCode == 201) {
      var response = await _chatService.getLastChat();

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        data['data'].forEach((chat) => _chats.add(Chat.fromJson(chat)));
        print(response.body);
        notifyListeners();
        setBusy(false);
      }
      return _chats;
    }
    setBusy(false);
  }
}
