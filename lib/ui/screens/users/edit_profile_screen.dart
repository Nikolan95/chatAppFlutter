import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../style.dart';

class EditProfileScreen extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Colors.yellow[700],
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
    return Scaffold(
        key: _scafoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('Profile'),
          centerTitle: true,
        ),
        body: provider.busy
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
                      initialValue: '${provider.user.name}',
                        decoration: Style.inputDecoration('Name'),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'input require';
                          } else
                            return null;
                        },
                        onSaved: (v) {
                          provider.user.name = v.trim();
                        },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      initialValue: '${provider.user.surname}',
                        decoration: Style.inputDecoration('Surname'),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'input require';
                          } else
                            return null;
                        },
                        onSaved: (v) {
                          provider.user.surname = v.trim();
                        },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      initialValue: '${provider.user.company}',
                        decoration: Style.inputDecoration('Company'),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'input require';
                          } else
                            return null;
                        },
                        onSaved: (v) {
                          provider.user.company = v.trim();
                        },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      initialValue: '${provider.user.street}',
                        decoration: Style.inputDecoration('Street'),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'input require';
                          } else
                            return null;
                        },
                        onSaved: (v) {
                          provider.user.street = v.trim();
                        },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      initialValue: '${provider.user.city}',
                        decoration: Style.inputDecoration('City'),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'input require';
                          } else
                            return null;
                        },
                        onSaved: (v) {
                          provider.user.city = v.trim();
                        },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    TextFormField(
                      initialValue: '${provider.user.telefon}',
                        decoration: Style.inputDecoration('Telefon'),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'input require';
                          } else
                            return null;
                        },
                        onSaved: (v) {
                          provider.user.telefon = v.trim();
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
                // print(provider.user.toJson());
                // return;
                var result = await provider.updateUser();
                if (!result) {
                  _scafoldKey.currentState.showSnackBar(SnackBar(
                    content: Text(Provider.of<UserProvider>(context).message),
                  )
                  );
                  print('error');
                }
              } else
                print('is not validate');
            },
              child: Text('Speichern'),
            )),
          ],
        ),
      ),
    );
  }
}


