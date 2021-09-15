// import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/constants/style.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/ui/screens/chat/chat_screen.dart';
import 'package:chat_app/ui/widgets/cards/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/size_config.dart';
import 'new_chat.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatProvider>(context, listen: false).getChats();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var provider = Provider.of<ChatProvider>(context);
    var cars = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset("assets/background.png").image,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 35, bottom: 15),
                  child: Image.asset(
                    'assets/logo-atev-white.png',
                  )),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                    height: 2.0, width: 500.0, color: Style.primaryColor),
              ),
              Container(
                child: provider.busy
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 2),
                        itemCount: provider.chats.length,
                        itemBuilder: (context, index) => ChatCard(
                            chat: provider.chats[index],
                            onTap: () {
                              provider.messageSeen(provider.chats[index].id);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ChatScreen(
                                        chat: provider.chats[index],
                                      )));
                            }),
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewChat(cars.cars)),
            );
            //print(cars.cars.first.toJson());
          },
          tooltip: 'New Chat',
          child: const Icon(Icons.add),
          backgroundColor: Style.primaryColor,
        ),
      ),
    );
  }
}
