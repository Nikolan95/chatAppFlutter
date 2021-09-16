import 'package:chat_app/models/chat.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_ago_provider/time_ago_provider.dart' as timeAgo;

class ChatCard extends StatelessWidget {
  final Chat chat;
  final Function onTap;
  const ChatCard({
    this.chat,
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    var unread = [];
    for (var message in chat.messages) {
      if ((message.userId != provider.user.id && message.read == 0)) {
        unread.add(message);
        //print(message.toJson());
      }
      //print(message.read);
    }
    int newMessages = unread.length;
    //print(newMessages);
    return SingleChildScrollView(
        child: ListTile(
      onTap: onTap,
      leading: ClipOval(
        child: Image.network(chat.user.imageUrl != null
            ? chat.user.imageUrl
            : 'https://s3.amazonaws.com/37assets/svn/765-default-avatar.png'),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          chat.messages.last.read == 0 &&
                  chat.messages.last.userId != provider.user.id
              ? Text(
                  chat.user.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  chat.user.name,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 18,
                  ),
                ),
          Text(
            '${timeAgo.format(DateTime.parse(chat.messages.last.createdAt), locale: 'de')}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
      subtitle:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
              Widget>[
        chat.messages.last.read == 0 &&
                chat.messages.last.userId != provider.user.id
            ? Text(
                chat.messages.last.body == 'angebotNotification'
                    ? 'Angebot'
                    : chat.messages.last.body.split('.').last == 'pdf'
                        ? 'PDF'
                        : chat.messages.last.body == 'just_img_no_text'
                            ? 'Bild'
                            : chat.messages.last.body.split(':')[0] == 'http'
                                ? 'Bild'
                                : chat.messages.last.body == 'just_pdf_no_text'
                                    ? 'PDF'
                                    : chat.messages.last.body ==
                                            'just_offer_no_text'
                                        ? 'Angebot'
                                        : chat.messages.last.body != null &&
                                                chat.messages.last.body !=
                                                    'just_img_no_text' &&
                                                chat.messages.last.body !=
                                                    'just_pdf_no_text' &&
                                                chat.messages.last.body !=
                                                    'just_offer_no_text'
                                            ? chat.messages.last.body
                                            : 'Dokument',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Expanded(
                child: new Container(
                margin: EdgeInsets.only(top: 5),
                child: new Text(
                    chat.messages.last.body == 'angebotNotification'
                        ? 'Angebot'
                        : chat.messages.last.body.split('.').last == 'pdf'
                            ? 'PDF'
                            : chat.messages.last.body == 'just_img_no_text'
                                ? 'Bild'
                                : chat.messages.last.body.split(':')[0] ==
                                        'http'
                                    ? 'Bild'
                                    : chat.messages.last.body ==
                                            'just_pdf_no_text'
                                        ? 'PDF'
                                        : chat.messages.last.body ==
                                                'just_offer_no_text'
                                            ? 'angebot'
                                            : chat.messages.last.body != null &&
                                                    chat.messages.last.body !=
                                                        'just_img_no_text' &&
                                                    chat.messages.last.body !=
                                                        'just_pdf_no_text' &&
                                                    chat.messages.last.body !=
                                                        'just_offer_no_text'
                                                ? chat.messages.last.body
                                                : 'Dokument',
                    overflow: TextOverflow.ellipsis),
              )),
        newMessages != 0
            ? Container(
                //margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.yellow[700],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
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
      ]),
    ));
  }
}
