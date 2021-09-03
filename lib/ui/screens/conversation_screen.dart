// import 'package:chat_app/providers/auth_provider.dart';
// import 'package:chat_app/ui/screens/welcome_screen.dart';
// import 'package:chat_app/ui/style.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/ui/style.dart';
import 'package:chat_app/ui/widgets/cards/conversation_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/providers/conversation_provider.dart';

import '../size_config.dart';
import 'chat_screen.dart';
import 'new_conversation.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ConversationProvider>(context, listen: false).getConversations();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var provider = Provider.of<ConversationProvider>(context);
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
      body:SingleChildScrollView(
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 35, bottom: 15),
                  child: Image.asset(
                      'assets/logo-atev-white.png',
                  )
                ),
               Padding(
                    padding:EdgeInsets.only(bottom: 20),
                    child:Container(
                    height:2.0,
                    width:500.0,
                    color:Style.primaryColor),
                ),
                Container(
                  child: provider.busy
                      ? CircularProgressIndicator()
                      : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                          itemCount: provider.conversations.length,
                          itemBuilder: (context, index) => ConversationCard(
                            conversation: provider.conversations[index],
                            onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ChatScreen(
                                        conversation: provider.conversations[index],
                                      )
                                    )
                                );
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
            MaterialPageRoute(builder: (context) => NewConversation(cars.cars)),
          );
          //print(cars.cars.first.toJson());
        },
        tooltip: 'New Conversation',
        child: const Icon(Icons.add),
        backgroundColor: Style.primaryColor,
      ), 
    ),
      );
  }
}
