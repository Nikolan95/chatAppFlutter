import 'package:chat_app/models/conversation_model.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ConversationCard extends StatelessWidget {
  final ConversationModel conversation;
  final Function onTap;
  const ConversationCard({
    this.conversation,
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    var unread = [];
    for(var message in conversation.messages){
        // if((message.userId != provider.user.id)){
        //   print(message.toJson());
        // }
        //print(message.toJson());
    }
    return ListTile(
      onTap: onTap,
      leading: ClipOval(
        child: Image.network(conversation.user.imageUrl != null
            ? conversation.user.imageUrl
            : 'https://s3.amazonaws.com/37assets/svn/765-default-avatar.png'),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            conversation.user.name,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 18,
            ),
          ),
          Text(
            '${timeago.format(DateTime.parse(conversation.messages.last.createdAt))}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
      subtitle: Text(conversation.messages.last.body != null
                ? conversation.messages.last.body
                : 'document'),
    );
  }
}