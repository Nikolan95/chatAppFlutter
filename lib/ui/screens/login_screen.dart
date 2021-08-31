import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/screens/main_screen.dart';
import 'package:chat_app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';
import '../style.dart';



class LoginScreen extends StatefulWidget {
  static final routeName = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final _key = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
  @override
  Widget build(BuildContext context){
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
      key: _scafoldKey,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          Center(
              child: Image.asset(
                      'assets/logo-atev-white.png',
                  )),
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4),
            child: Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _email,
                      decoration: Style.inputDecoration('Email'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Email field is empty';
                        }else if(!isEmail(v)){
                          return 'invalid email form';
                        } else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: Style.inputDecoration('Password'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Password field is empty';
                        } else if (v.trim().length < 6) {
                          return 'Password requires at least 6 characters';
                        } else
                          return null;
                      },
                    ),
                  ],
                )),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: PrimaryButton(
          onTap: () async {
            if (_key.currentState.validate()) {
              _key.currentState.save();
              print('is validate');
              var login = await Provider.of<AuthProvider>(context, listen: false)
                .login(_email.text, _password.text);

                if(login){
                  Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
                }else{
                  _scafoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(Provider.of<AuthProvider>(context, listen: false).message),
                ));
                }
            } else
              print('not validated');
          },
          child: Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21),
          ),
        ),
      ),
    ),
    );
  }
}