import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';


class MyMessageCard extends StatelessWidget {
  final MessageModel message;
  const MyMessageCard({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: EdgeInsets.all(21),
      child: ChatBubble(
        clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
        alignment: Alignment.topRight,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Colors.yellow[700],
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            '${message.body}',
            style: TextStyle(color: Colors.black),
          ),
        ),
      )
    );
  }
}
