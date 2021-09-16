import 'package:chat_app/constants/size_config.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';
import 'user_edit_profile.dart';

class UserProfile extends StatelessWidget {
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
                  padding: EdgeInsets.only(bottom: 15),
                  child: Container(
                    height: 2.0,
                    width: 500.0,
                    color: Style.primaryColor,
                  ),
                ),
                Container(
                  height: 40,
                  child: Text(
                    'Meine Daten',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  child: Card(
                    color: Colors.transparent,
                    margin:
                        const EdgeInsets.only(bottom: 8, left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 30, top: 5),
                              child: Text(
                                'Name:',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 30, top: 5, bottom: 10),
                              child: Text(
                                provider.user.name,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Card(
                    margin:
                        const EdgeInsets.only(bottom: 8, left: 10, right: 10),
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 30, top: 5),
                              child: Text(
                                'Unternehmen:',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 30, top: 5, bottom: 10),
                              child: Text(
                                provider.user.company,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Card(
                    margin:
                        const EdgeInsets.only(bottom: 8, left: 10, right: 10),
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 30, top: 5),
                              child: Text(
                                'Adresse:',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 30, top: 5, bottom: 10),
                              child: Text(
                                provider.user.street,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Card(
                    margin:
                        const EdgeInsets.only(bottom: 8, left: 10, right: 10),
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 30, top: 5),
                              child: Text(
                                'PLZ und Stadt:',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 30, top: 5, bottom: 10),
                              child: Text(
                                provider.user.city,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Card(
                    margin:
                        const EdgeInsets.only(bottom: 8, left: 10, right: 10),
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 30, top: 5),
                              child: Text(
                                'Telefonnummer:',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 30, top: 5, bottom: 10),
                              child: Text(
                                provider.user.phoneNumber,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Card(
                    margin:
                        const EdgeInsets.only(bottom: 8, left: 10, right: 10),
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 30, top: 5),
                              child: Text(
                                'E-Mail:',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 30, top: 5, bottom: 10),
                              child: Text(
                                provider.user.email,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 15),
                    width: 200,
                    child: ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => UserEditProfile())),
                      child: Text('Bearbeiten'),
                    )),
              ],
            ),
          ),
        ));
  }
}
