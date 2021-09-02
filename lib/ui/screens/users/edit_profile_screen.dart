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
          key: _scafoldKey,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text('Daten bearbeiten'),
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
                margin: EdgeInsets.only(top: 40, bottom: 15),
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
                        height: SizeConfig.blockSizeHorizontal * 6,
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
                        height: SizeConfig.blockSizeHorizontal * 6,
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
                        height: SizeConfig.blockSizeHorizontal * 6,
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
                        height: SizeConfig.blockSizeHorizontal * 6,
                      ),
                      TextFormField(
                        initialValue: '${provider.user.phoneNumber}',
                          decoration: Style.inputDecoration('Telefon'),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'input require';
                            } else
                              return null;
                          },
                          onSaved: (v) {
                            provider.user.phoneNumber = v.trim();
                          },
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
                      content: Text(Provider.of<UserProvider>(context, listen: false).message),
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
      ),
    );
  }
}



