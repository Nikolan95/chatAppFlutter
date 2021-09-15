import 'package:chat_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';
import '../../widgets/cards/car_card.dart';
import 'car_add.dart';

class CarList extends StatefulWidget {
  //var _cars = List<CarList>();
  static final routeName = 'carscreen';

  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Style.primaryColor,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
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
                padding: EdgeInsets.only(bottom: 25),
                child: Container(
                    height: 2.0, width: 500.0, color: Style.primaryColor),
              ),
              Container(
                height: 40,
                child: Text(
                  'Meine Fahrzeuge',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                  child: ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => CarAdd())),
                child: Text('Neues Fahrung hinzufügen'),
              )),
              CarCard(provider.user.cars),
            ],
          ),
        ),
      ),
    );
  }
}
