import 'dart:convert';
import 'dart:io';

import 'package:chat_app/models/conversation_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/providers/conversation_provider.dart';
import 'package:chat_app/ui/size_config.dart';
import 'package:chat_app/ui/style.dart';
import 'package:chat_app/ui/widgets/cards/firend_message_card.dart';
import 'package:chat_app/ui/widgets/cards/my_message_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final ConversationModel conversation;
  const ChatScreen({Key key, this.conversation}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState(this.conversation);
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageTextEditController = TextEditingController();

  final ConversationModel conversation;
  MessageModel message;

  ScrollController _scrollController = ScrollController();

  _ChatScreenState(this.conversation);

  File _image;

  final ImagePicker imagePicker = ImagePicker();

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
      if (_image != null) {
        List<int> fileInByte = image.readAsBytesSync();
        String fileInBase64 = base64Encode(fileInByte);
        print("Image" + fileInBase64);
        message.image = fileInBase64;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    message = MessageModel();
    message.conversationId = conversation.id;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset("assets/background.png").image,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('${conversation.user.name}'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 4,
                  vertical: SizeConfig.safeBlockVertical * 3,
                ),
                itemCount: conversation.messages.length,
                itemBuilder: (context, index) =>
                    conversation.messages[index].userId == conversation.user.id
                        ? FriendMessageCard(
                            message: conversation.messages[index],
                            imageUrl: conversation.user.imageUrl,
                          )
                        : MyMessageCard(
                            message: conversation.messages[index],
                          ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Style.darkColor, // Box Decoration Andrej is
                  borderRadius: BorderRadius.circular(32)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    tooltip: 'Increase volume by 10',
                    onPressed: () {
                      getImage();
                    },
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: TextField(
                    controller: messageTextEditController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nachricht verfassen ...',
                        hintStyle: TextStyle()),
                  )),
                  Provider.of<ConversationProvider>(context).busy
                      ? CircularProgressIndicator()
                      : InkWell(
                          onTap: () async {
                            if (messageTextEditController.text.isEmpty &&
                                _image.path.isEmpty) return;
                            message.body =
                                messageTextEditController.text.trim();
                            print(message.toJson());
                            await Provider.of<ConversationProvider>(context,
                                    listen: false)
                                .storeMessage(message);
                            messageTextEditController.clear();
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent +
                                    23);
                          },
                          child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                      colors: [
                                        Style.primaryColor,
                                        Style.secondaryColor,
                                        Style.secondaryColor,
                                        Style.secondaryColor,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                              child: Icon(Icons.send)),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
