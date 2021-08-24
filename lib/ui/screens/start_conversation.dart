import 'package:chat_app/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/providers/conversation_provider.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

class StartConversation extends StatelessWidget {

  //final Function startConversation;
  

  //StartConversation(this.startConversation);


  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Colors.yellow[700],
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
    final CarModel cars = ModalRoute.of(context).settings.arguments;
    //var provider = Provider.of<UserProvider>(context);
    final userId = 7;
    final messageController = TextEditingController();
    final carId = cars.id;
     void submitData() async {
      final enteredUserId = userId;
      final enteredMessage = messageController.text;
      final enteredCarId = carId;

      if(enteredMessage.isEmpty){
        return;
      }

      await Provider.of<ConversationProvider>(context, listen: false)
                    .storeConversation(enteredUserId.toString(), enteredMessage, enteredCarId.toString());

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );

    }
    return Scaffold(
      backgroundColor: Colors.black,
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
                height: 2.0,
                width: 500.0,
                color: Colors.yellow[700],
              ),
            ),
            Container(
              height: 50,
              child: Text(
                'Starting conversation for ' + cars.manufacturerAndBrand.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 20),
              child: TextField(
                maxLines: 10,
                decoration: InputDecoration.collapsed(hintText: "Enter your message here"),
                controller: messageController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              width: 200,
                child: ElevatedButton(
              style: raisedButtonStyle,
              onPressed: submitData,
              child: Text('Send'),
            )),
          ]
        ),
    ),
    );
  }
}
  