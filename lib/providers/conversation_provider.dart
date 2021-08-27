import 'package:chat_app/models/conversation_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/providers/base_provider.dart';
import 'package:chat_app/services/conversation_service.dart';
import 'dart:convert';

class ConversationProvider extends BaseProvider{
  ConversationService _conversationService = ConversationService();
  List<ConversationModel> _conversations = [];
  List<ConversationModel> get conversations => _conversations;


  Future<List<ConversationModel>> getConversations() async {
    if(_conversations.isNotEmpty) return _conversations;
    setBusy(true);
    var response = await _conversationService.getConversations();

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      data['data'].forEach((conversation) =>
        _conversations.add(ConversationModel.fromJson(conversation))
      );
      print(response.body);
      notifyListeners();
      setBusy(false);
    }
    return _conversations;
  }

  Future<void> storeMessage(MessageModel message) async {
    setBusy(true);
    var response = await _conversationService.storeMessage(message);
    print(response.body);
    if(response.statusCode == 201){
      var data = jsonDecode(response.body);
      setBusy(false);
      addMessageToConversation(
        message.conversationId, MessageModel.fromJson(data['data'])
      );
    }
      setBusy(false);
  }

  addMessageToConversation(int conversationId, MessageModel message){
    var conversation = _conversations.firstWhere((conversation) => conversation.id == conversationId);
    conversation.messages.add(message);
    toTheTop(conversation);
    notifyListeners();
  }

  toTheTop(ConversationModel conversation){
    var index = _conversations.indexOf(conversation);

    for(var i = index; i>0; i--){
      var x = _conversations[i] = _conversations[i - 1];
      _conversations[i - 1] = x;
    }
  }

  Future<void> storeConversation(String userId, String message, String carId) async {
    setBusy(true);
    var response = await _conversationService.newConversation(userId, message, carId);
    print(response.body);
     if(response.statusCode == 201){
       var response = await _conversationService.getLastConversation();

      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        data['data'].forEach((conversation) =>
          _conversations.add(ConversationModel.fromJson(conversation))
        );
        print(response.body);
        notifyListeners();
        setBusy(false);
      }
      return _conversations;
     }
      setBusy(false);
  }
  // addConversation(int conversationId, ConversationModel conversation,  MessageModel message){
  //   var conversation = _conversations.firstWhere((conversation) => conversation.id == conversationId);
  //   conversation.messages.add(message);
  //   toTheTop(conversation);
  //   notifyListeners();
  // }

}

