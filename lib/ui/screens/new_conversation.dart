import 'package:chat_app/models/car_model.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/providers/conversation_provider.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

class NewConversation extends StatefulWidget {

  final List<CarModel> cars;
  

  NewConversation(this.cars);
   @override
  _NewConversationState createState() => _NewConversationState(this.cars);
}

class _NewConversationState extends State<NewConversation>{
   List<CarModel> cars;
   
    int _value;
  _NewConversationState(
    this.cars
    );
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
      primary: Colors.yellow[700],
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

      if(enteredMessage.isEmpty || enteredCarId.isNaN){
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
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 35, bottom: 15),
                child: Image.asset(
                  'assets/logo-atev-white.png',
                )
              ),
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
                'Stratin conversation for',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              height: 50,
              child: DropdownButton(
            value: _value,
            items: cars.map((CarModel item) {
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
            hint:Text("Please select your car")
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
  