import 'dart:convert';
import 'dart:typed_data';

import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/ui/screens/offer/offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminChatBubble extends StatelessWidget {
  final ChatMessage message;
  final String imageUrl;
  const AdminChatBubble({
    Key key,
    this.message,
    this.imageUrl,
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
            child: message.body != null &&
                    message.body != 'just_img_no_text' &&
                    message.body != 'just_pdf_no_text' &&
                    message.body != 'just_offer_no_text'
                ? Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: message.body == 'angebotNotification'
                      ? Container(
                          child: IconButton(
                              icon: new Icon(Icons.file_copy),
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OfferScreen(),
                                      settings: RouteSettings(
                                        arguments: message,
                                      ),
                                    ),
                                  )))
                      :message.body.split('.').last == 'pdf'
                      ?Container(
                                  child: IconButton(
                                  icon: new Icon(Icons.picture_as_pdf),
                                  onPressed: () async {
                                    var url =
                                        message.body;
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                ))
                      :message.body.split(':')[0] == 'http'
                      ?Image.network(message.body)
                      :Text(
                        '${message.body}',
                        style: TextStyle(color: Colors.white),
                      )
                    )
                  : message.offerItems.length > 0 && message.acceptOffer == null
                      ? Container(
                          child: IconButton(
                              icon: new Icon(Icons.file_copy),
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OfferScreen(),
                                      settings: RouteSettings(
                                        arguments: message,
                                      ),
                                    ),
                                  )))
                      : message.acceptOffer == 'accept'
                          ? Container(
                              child: IconButton(
                                  icon: new Icon(Icons.file_copy),
                                  onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OfferScreen(),
                                          settings: RouteSettings(
                                            arguments: message,
                                          ),
                                        ),
                                      )))
                          : message.body == 'just_pdf_no_text'
                              ? Container(
                                  child: IconButton(
                                  icon: new Icon(Icons.picture_as_pdf),
                                  onPressed: () async {
                                    var url =
                                        'http://192.168.0.21./atev-laravel-backend/public' +
                                            message.file.filePath;
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                ))
                
                              :Container(
                                  child:
                                    Image.memory(
                                      base64decode(message.image),
                                      scale: 5)
                                  ),
                                )
        ],
      ),
    );
  }
}
