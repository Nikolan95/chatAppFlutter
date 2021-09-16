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
    if (_chats.isNotEmpty) return sortChats(_chats);
    setBusy(true);
    var response = await _chatService.getChats();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data['data'].forEach((chat) => _chats.add(Chat.fromJson(chat)));
      print(response.body);
      notifyListeners();
      setBusy(false);
    }
    return sortChats(_chats);
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
      return sortChats(_chats);
    }
  }

  addMessageToChat(int chatId, ChatMessage message) {
    Chat chat = _chats.singleWhere((chat) => chat.id == chatId);
    chat.messages.add(message);
    sortChats(_chats);
    notifyListeners();
  }

  Future<List<Chat>> sortChats(List<Chat> chats) async {
    chats.sort((b, a) =>
        a.messages.last.createdAt.compareTo(b.messages.last.createdAt));
    return chats;
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
      return sortChats(_chats);
    }
    setBusy(false);
  }
}
