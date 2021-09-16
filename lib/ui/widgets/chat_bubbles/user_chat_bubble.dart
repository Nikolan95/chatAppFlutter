import 'dart:convert';
import 'dart:typed_data';

import 'package:chat_app/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';

class UserChatBubble extends StatelessWidget {
  final ChatMessage message;
  const UserChatBubble({
    Key key,
    this.message,
  }) : super(key: key);

  Uint8List base64decode(String image) {
    //Codec<String, String> stringToBase64 = utf8.fuse(base64);
    //Uint8List _image =  base64Decode(image);
    //var blob = yourJSONMapHere[image];
    var _image = base64.decode(image);
    return _image;
  }

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
          child: message.body != null &&
                  (message.image == null || message.image.isEmpty)
              ? Container(
                  child: Text(
                    '${message.body}',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Image.memory(base64decode(message.image),
                                scale: 7)),
                    if (message.body != "just_img_no_text")
                      Text(
                        '${message.body}',
                        style: TextStyle(color: Colors.white),
                      )
                  ],
                ),
        ),
      ),
    );
  }
}
