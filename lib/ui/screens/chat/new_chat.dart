import 'package:chat_app/models/car.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';
import '../home/home.dart';

class NewChat extends StatefulWidget {
  final List<Car> cars;

  NewChat(this.cars);
  @override
  _NewChatState createState() => _NewChatState(this.cars);
}

class _NewChatState extends State<NewChat> {
  List<Car> cars;

  int _value;
  _NewChatState(this.cars);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).user;
    });
  }

  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Style.primaryColor,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
    final userId = 1;
    final messageController = TextEditingController();
    void submitData() async {
      final enteredUserId = userId;
      final enteredMessage = messageController.text;
      final enteredCarId = _value;

      if (enteredMessage.isEmpty || enteredCarId.isNaN) {
        return;
      }

      await Provider.of<ChatProvider>(context, listen: false).storeChat(
          enteredUserId.toString(), enteredMessage, enteredCarId.toString());

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }

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
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('Neue Nachricht'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                    height: 2.0,
                    width: 500.0,
                    color: Style.primaryColor,
                  ),
                ),
                Container(
                  height: 50,
                  child: DropdownButton(
                      value: _value,
                      items: cars.map((Car item) {
                        return DropdownMenuItem(
                          child: Text(item.manufacturerAndBrand),
                          value: item.id,
                        );
                      }).toList(),
                      //       .forEach((conversation) =>
                      //   _conversations.add(ConversationModel.fromJson(conversation))
                      // );

                      onChanged: (int value) {
                        setState(() {
                          _value = value;
                          print(_value);
                        });
                      },
                      hint: Text("Fahrzeug auswählen")),
                ),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: TextField(
                    maxLines: 20,
                    decoration: InputDecoration.collapsed(
                        hintText: "Hier Nachricht eingeben"),
                    controller: messageController,
                  ),
                ),
                Container(
                    width: 200,
                    child: ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: submitData,
                      child: Text('Nachricht senden'),
                    )),
              ]),
        ),
      ),
    );
  }
}
