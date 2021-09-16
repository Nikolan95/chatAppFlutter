import 'dart:convert';
import 'dart:io';

import 'package:chat_app/constants/size_config.dart';
import 'package:chat_app/constants/style.dart';
import 'package:chat_app/models/chat.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/ui/widgets/chat_bubbles/admin_chat_bubble.dart';
import 'package:chat_app/ui/widgets/chat_bubbles/user_chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;
  const ChatScreen({Key key, this.chat}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState(this.chat);
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageTextEditController = TextEditingController();

  final Chat chat;

  ChatMessage message;

  ScrollController _scrollController = ScrollController();

  _ChatScreenState(this.chat);

  File _image;

  final ImagePicker imagePicker = ImagePicker();

  Future<void> _showChoiceDialog(BuildContext context) async {
    BuildContext dialogContext;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          dialogContext = context;
          return AlertDialog(
            title: Center(child: Text('Auswählen')),
            content: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: MaterialButton(
                      child: new Row(
                        children: <Widget>[
                          new IconTheme(
                            data: new IconThemeData(color: Style.primaryColor),
                            child: new Icon(Icons.camera_alt_outlined),
                          ),
                          SizedBox(width: 3),
                          new Text('Kamera'),
                        ],
                      ),
                    ),
                    onTap: () {
                      getImage();
                      Navigator.pop(context);
                    },
                  ),
                  GestureDetector(
                    child: MaterialButton(
                      child: new Row(
                        children: <Widget>[
                          new IconTheme(
                            data: new IconThemeData(color: Style.primaryColor),
                            child: new Icon(Icons.add_photo_alternate_outlined),
                          ),
                          SizedBox(width: 3),
                          new Text('Galerie'),
                        ],
                      ),
                    ),
                    onTap: () {
                      _openGallery();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _openGallery() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
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

  _makingPhoneCall() async {
    const url = 'tel:52354353';
    //const url = 'https://www.google.com/maps';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openMaps() async {
    const url = 'https://www.google.com/maps/@48.301693,14.2987955,14.69z';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    message = ChatMessage();
    message.chatId = chat.id;
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
          title: Text('${chat.user.name}'),
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: _openMaps,
                  child: Icon(Icons.map),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: _makingPhoneCall,
                  child: Icon(Icons.phone),
                )),
          ],
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
                itemCount: chat.messages.length,
                itemBuilder: (context, index) =>
                    chat.messages[index].userId == chat.user.id
                        ? AdminChatBubble(
                            message: chat.messages[index],
                            imageUrl: chat.user.imageUrl,
                          )
                        : UserChatBubble(
                            message: chat.messages[index],
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
                  if (_image != null)
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _image = null;
                        message.image = null;
                        setState(() {});
                      },
                    ),
                  if (_image != null)
                    CircleAvatar(
                      backgroundColor: Style.primaryColor,
                      radius: 13,
                      child: CircleAvatar(
                        radius: 11,
                        backgroundImage: Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ).image,
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    tooltip: 'Foto',
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                  ),
                  Expanded(
                      child: TextField(
                    controller: messageTextEditController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nachricht ...',
                        hintStyle: TextStyle()),
                  )),
                  Provider.of<ChatProvider>(context).busy
                      ? CircularProgressIndicator()
                      : InkWell(
                          onTap: () async {
                            if (messageTextEditController.text.isEmpty &&
                                _image.path.isEmpty) return;
                            if (messageTextEditController.text.isEmpty &&
                                _image.path.isNotEmpty) {
                              messageTextEditController.text =
                                  "just_img_no_text";
                            }
                            message.body =
                                messageTextEditController.text.trim();
                            print(message.toJson());
                            await Provider.of<ChatProvider>(context,
                                    listen: false)
                                .storeMessage(message);
                            messageTextEditController.clear();
                            _image = null;
                            message.image = null;
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
