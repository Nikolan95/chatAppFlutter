//import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/constants/size_config.dart';
import 'package:chat_app/constants/style.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/screens/auth/entry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Launching extends StatefulWidget {
  static final routeName = 'start';

  @override
  _LaunchingState createState() => _LaunchingState();
}

class _LaunchingState extends State<Launching> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var userExists =
          await Provider.of<AuthProvider>(context, listen: false).getUser();
      if (userExists) {
        Navigator.of(context).pushReplacementNamed(Home.routeName);
      }
    });
  }

  @override
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
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Style.darkColor,
      body: Provider.of<AuthProvider>(context, listen: false).busy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                      color: Style.primaryColor,
                    ),
                  ),
                  Container(
                    height: 80,
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      'Hallo !',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Willkomen in der modernesten',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      'Autoteile-App',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Keine Wartezeiten -',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      'immer der beste Service!',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Einfach und unkompliziert eine',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Anfrage an den Autoteile-Händler',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    child: Text(
                      'senden und innerhalb kürzerster',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Zeit das gewünschte Autoteil',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    child: Text(
                      'geliefert bekommen!',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 50),
                      width: 200,
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () =>
                            Navigator.of(context).pushNamed(Entry.routeName),
                        child: Text('Speichern'),
                      )),
                ],
              ),
            ),
    );
  }
}
