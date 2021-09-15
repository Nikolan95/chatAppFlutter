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
        if((message.userId != provider.user.id && message.read == 0)){
          unread.add(message);
          //print(message.toJson());
        }
        //print(message.read);
    }
    int newMessages = unread.length;
    //print(newMessages);
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
          conversation.messages.last.read == 0 && conversation.messages.last.userId != provider.user.id
          ?
          Text(
            conversation.user.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
          :
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
      subtitle: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget>[ 
          conversation.messages.last.read == 0 && conversation.messages.last.userId != provider.user.id
          ?
          Text(
            conversation.messages.last.body == 'just_img_no_text'
            ? 'image'
            :conversation.messages.last.body.split(':')[0] == 'http'
            ? 'image'
            :conversation.messages.last.body == 'just_pdf_no_text'
            ? 'pdf'
            : conversation.messages.last.body == 'just_offer_no_text'
            ? 'offer'
            : conversation.messages.last.body != null && conversation.messages.last.body != 'just_img_no_text'
              && conversation.messages.last.body != 'just_pdf_no_text' && conversation.messages.last.body != 'just_offer_no_text'
            ? conversation.messages.last.body
            : 'document',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),)
          :
          Text(
            conversation.messages.last.body == 'just_img_no_text' 
            ? 'image'
            :conversation.messages.last.body.split(':')[0] == 'http'
            ? 'image'
            :conversation.messages.last.body == 'just_pdf_no_text'
            ? 'pdf'
            : conversation.messages.last.body == 'just_offer_no_text'
            ? 'offer'
            : conversation.messages.last.body != null && conversation.messages.last.body != 'just_img_no_text'
              && conversation.messages.last.body != 'just_pdf_no_text' && conversation.messages.last.body != 'just_offer_no_text'
            ? conversation.messages.last.body
            : 'document'),
          newMessages != 0
          ? Container(
            //margin: const EdgeInsets.all(30.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
              border: Border.all(
                
                color: Colors.yellow[700],
              ),
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: Text(
              '${newMessages}',
              style: TextStyle(
              color: Colors.yellow[700],
              fontWeight: FontWeight.bold,
              fontSize: 14,
              ),
            ),
          )
          : Text(''),
        ]
      ),
    );
  }
}