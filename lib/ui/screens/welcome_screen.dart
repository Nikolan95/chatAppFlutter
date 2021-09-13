//import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/screens/login_screen.dart';
import 'package:chat_app/ui/screens/signup_screen.dart';
import 'package:chat_app/ui/size_Config.dart';
import 'package:chat_app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static final routeName = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var userExists =
          await Provider.of<AuthProvider>(context, listen: false).getUser();
      if (userExists) {
        Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset("assets/background.png").image,
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                    child: Image.asset(
                  'assets/logo-atev-white.png',
                )),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PrimaryButton(
                    onTap: () =>
                        Navigator.of(context).pushNamed(LoginScreen.routeName),
                    child: Text(
                      'Anmelden',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  PrimaryButton(
                    onTap: () =>
                        Navigator.of(context).pushNamed(SignUpScreen.routeName),
                    child: Text(
                      'Registrieren',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ));
  }
}
