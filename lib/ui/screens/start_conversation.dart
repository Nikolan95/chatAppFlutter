import 'package:chat_app/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/providers/conversation_provider.dart';
import 'package:provider/provider.dart';

import '../style.dart';
import 'main_screen.dart';

class StartConversation extends StatelessWidget {

  //final Function startConversation;
  

  //StartConversation(this.startConversation);


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
    final CarModel cars = ModalRoute.of(context).settings.arguments;
    //var provider = Provider.of<UserProvider>(context);
    final userId = 1;
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
          title: Text('Chat starten'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    ),);
  }
}
  