import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';


class FriendMessageCard extends StatelessWidget {
  final MessageModel message;
  final String imageUrl;
  const FriendMessageCard({
    Key key,
    this.message,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl != null
            ? imageUrl
            : 'https://s3.amazonaws.com/37assets/svn/765-default-avatar.png'),
          ),
          SizedBox(
            width: 12,
          ),
          ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            backGroundColor: Color(343438),
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(15),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Text(
                '${message.body}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
