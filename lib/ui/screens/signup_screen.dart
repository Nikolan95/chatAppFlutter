import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/ui/size_config.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

class SignUpScreen extends StatefulWidget {
  static final routeName = 'sign-up';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _key = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  TextEditingController _password = new TextEditingController();

  @override
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
    var provider = Provider.of<AuthProvider>(context);
    SizeConfig().init(context);
    return Scaffold(
      key: _scafoldKey,
      backgroundColor: Style.darkColor,
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
                'Meine Daten',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
              child:  Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      //initialValue: '${provider.user.name}',
                      decoration: Style.inputDecoration('Vorename'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Vorename field is empty';
                        } else
                          return null;
                      },
                      onSaved: (v){
                        provider.user.name = v.trim();
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      //initialValue: '${provider.user.name}',
                      decoration: Style.inputDecoration('Nachername'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Nachername field is empty';
                        } else
                          return null;
                      },
                      onSaved: (v){
                        provider.user.surname = v.trim();
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      //initialValue: '${provider.user.name}',
                      decoration: Style.inputDecoration('Unternehmen'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Unternehmen field is empty';
                        } else
                          return null;
                      },
                      onSaved: (v){
                        provider.user.company = v.trim();
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      //initialValue: '${provider.user.name}',
                      decoration: Style.inputDecoration('Straße, Nr'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Straße, Nr field is empty';
                        } else
                          return null;
                      },
                      onSaved: (v){
                        provider.user.street = v.trim();
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      //initialValue: '${provider.user.name}',
                      decoration: Style.inputDecoration('PLZ / Ort'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'PLZ / Ort field is empty';
                        } else
                          return null;
                      },
                      onSaved: (v){
                        provider.user.city = v.trim();
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      //initialValue: '${provider.user.name}',
                      decoration: Style.inputDecoration('Telefon'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Telefon field is empty';
                        } else
                          return null;
                      },
                      onSaved: (v){
                        provider.user.telefon = v.trim();
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      //initialValue: '${provider.user.email}',
                      decoration: Style.inputDecoration('Email'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Email field is empty';
                        }else if(!isEmail(v)){
                          return 'invalid email form';
                        } else
                          return null;
                      },
                      onSaved: (v){
                        provider.user.email = v;
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _password,
                      decoration: Style.inputDecoration('Password'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Password field is empty';
                        } else if (v.trim().length < 6) {
                          return 'Password requires at least 6 characters';
                        } else
                          return null;
                      },
                      onSaved: (v){
                        provider.user.password = v;
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: Style.inputDecoration('Confirm Password'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Confirm Password field is empty';
                        }else if(v.trim()!= _password.text.trim()){
                          return 'passwords doesn\'t match';
                        } else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                  ],
                ),
              ),
            ),
           
            Container(
              margin: EdgeInsets.only(top: 15),
              width: 200,
                child: ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () async {
                if (_key.currentState.validate()) {
                  _key.currentState.save();
                  var result = await provider.register();
                  if(result){
                    print('done');
                    Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
                  } else{
                    _scafoldKey.currentState.showSnackBar(SnackBar(
                      content: Text(Provider.of<AuthProvider>(context, listen: false).message),
                    ));
                  }      
                } else
                  print('not validated');
              },
              child: Text('Speichern'),
            )),
          ],
        ),
      ),
        
    );
  }
}

// ListView(
//         children: <Widget>[
//           SizedBox(
//             height: SizeConfig.screenHeight * 0.1,
//           ),
//           Center(
//               child: Image.asset(
//                       'assets/logo-atev-white.png',
//                   )),
//           SizedBox(
//             height: SizeConfig.screenHeight * 0.1,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: SizeConfig.blockSizeHorizontal * 4),
//             child: Form(
//                 key: _key,
//                 child: Column(
//                   children: <Widget>[
//                     TextFormField(
//                       //initialValue: '${provider.user.name}',
//                       decoration: Style.inputDecoration('Name'),
//                       validator: (v) {
//                         if (v.isEmpty) {
//                           return 'Name field is empty';
//                         } else
//                           return null;
//                       },
//                       onSaved: (v){
//                         provider.user.name = v.trim();
//                       },
//                     ),
//                     SizedBox(
//                       height: SizeConfig.blockSizeHorizontal * 4,
//                     ),
//                     TextFormField(
//                       //initialValue: '${provider.user.name}',
//                       decoration: Style.inputDecoration('Surname'),
//                       validator: (v) {
//                         if (v.isEmpty) {
//                           return 'Surname field is empty';
//                         } else
//                           return null;
//                       },
//                       onSaved: (v){
//                         provider.user.surname = v.trim();
//                       },
//                     ),
//                     SizedBox(
//                       height: SizeConfig.blockSizeHorizontal * 4,
//                     ),
//                     TextFormField(
//                       //initialValue: '${provider.user.name}',
//                       decoration: Style.inputDecoration('Company'),
//                       validator: (v) {
//                         if (v.isEmpty) {
//                           return 'Company field is empty';
//                         } else
//                           return null;
//                       },
//                       onSaved: (v){
//                         provider.user.company = v.trim();
//                       },
//                     ),
//                     SizedBox(
//                       height: SizeConfig.blockSizeHorizontal * 4,
//                     ),
//                     TextFormField(
//                       //initialValue: '${provider.user.name}',
//                       decoration: Style.inputDecoration('Street'),
//                       validator: (v) {
//                         if (v.isEmpty) {
//                           return 'Street field is empty';
//                         } else
//                           return null;
//                       },
//                       onSaved: (v){
//                         provider.user.street = v.trim();
//                       },
//                     ),
//                     SizedBox(
//                       height: SizeConfig.blockSizeHorizontal * 4,
//                     ),
//                     TextFormField(
//                       //initialValue: '${provider.user.name}',
//                       decoration: Style.inputDecoration('City'),
//                       validator: (v) {
//                         if (v.isEmpty) {
//                           return 'City field is empty';
//                         } else
//                           return null;
//                       },
//                       onSaved: (v){
//                         provider.user.city = v.trim();
//                       },
//                     ),
//                     SizedBox(
//                       height: SizeConfig.blockSizeHorizontal * 4,
//                     ),
//                     TextFormField(
//                       //initialValue: '${provider.user.name}',
//                       decoration: Style.inputDecoration('Telefon'),
//                       validator: (v) {
//                         if (v.isEmpty) {
//                           return 'Telefon field is empty';
//                         } else
//                           return null;
//                       },
//                       onSaved: (v){
//                         provider.user.telefon = v.trim();
//                       },
//                     ),
//                     SizedBox(
//                       height: SizeConfig.blockSizeHorizontal * 4,
//                     ),
//                     TextFormField(
//                       //initialValue: '${provider.user.email}',
//                       decoration: Style.inputDecoration('Email'),
//                       validator: (v) {
//                         if (v.isEmpty) {
//                           return 'Email field is empty';
//                         }else if(!isEmail(v)){
//                           return 'invalid email form';
//                         } else
//                           return null;
//                       },
//                       onSaved: (v){
//                         provider.user.email = v;
//                       },
//                     ),
//                     SizedBox(
//                       height: SizeConfig.blockSizeHorizontal * 4,
//                     ),
//                     TextFormField(
//                       obscureText: true,
//                       controller: _password,
//                       decoration: Style.inputDecoration('Password'),
//                       validator: (v) {
//                         if (v.isEmpty) {
//                           return 'Password field is empty';
//                         } else if (v.trim().length < 6) {
//                           return 'Password requires at least 6 characters';
//                         } else
//                           return null;
//                       },
//                       onSaved: (v){
//                         provider.user.password = v;
//                       },
//                     ),
//                     SizedBox(
//                       height: SizeConfig.blockSizeHorizontal * 4,
//                     ),
//                     TextFormField(
//                       obscureText: true,
//                       decoration: Style.inputDecoration('Confirm Password'),
//                       validator: (v) {
//                         if (v.isEmpty) {
//                           return 'Confirm Password field is empty';
//                         }else if(v.trim()!= _password.text.trim()){
//                           return 'passwords doesn\'t match';
//                         } else
//                           return null;
//                       },
//                     ),
//                   ],
//                 )),
//           )
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.symmetric(vertical: 30),
//         child: PrimaryButton(
//           onTap: () async {
//             if (_key.currentState.validate()) {
//               _key.currentState.save();
//               var result = await provider.register();
//               if(result){
//                 print('done');
//                 Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
//               } else{
//                 _scafoldKey.currentState.showSnackBar(SnackBar(
//                   content: Text(Provider.of<AuthProvider>(context, listen: false).message),
//                 ));
//               }      
//             } else
//               print('not validated');
//           },
//           child: Text(
//             'Register',
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 21),
//           ),
//         ),
//       ),
