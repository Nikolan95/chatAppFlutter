import 'package:chat_app/models/car.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/size_config.dart';
import '../../../constants/style.dart';

class CarAdd extends StatefulWidget {
  @override
  _CarAddState createState() {
    return _CarAddState();
  }
}

class _CarAddState extends State<CarAdd> {
  Car _carModel = new Car();
  final _key = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

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
        ));

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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Text('Neues Fahrzeug anlegen'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Container(
                      height: 2.0,
                      width: 500.0,
                      color: Style.primaryColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 4),
                    child: Form(
                      key: _key,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: SizeConfig.blockSizeHorizontal * 6,
                          ),
                          TextFormField(
                            decoration:
                                Style.inputDecoration('Erstmals zugelassen'),
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Eingabe erforderlich';
                              } else
                                return null;
                            },
                            onSaved: (v) {
                              _carModel.firstRegistration = v.trim();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeHorizontal * 6,
                          ),
                          TextFormField(
                            decoration: Style.inputDecoration('Kennzeichen'),
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'input require';
                              } else
                                return null;
                            },
                            onSaved: (v) {
                              _carModel.vehicleIdentificationNumber = v.trim();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeHorizontal * 6,
                          ),
                          TextFormField(
                            decoration:
                                Style.inputDecoration('Marke und Modell'),
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Eingabe erforderlich';
                              } else
                                return null;
                            },
                            onSaved: (v) {
                              _carModel.manufacturerAndBrand = v.trim();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeHorizontal * 6,
                          ),
                          TextFormField(
                            decoration:
                                Style.inputDecoration('Zulassungsnummer'),
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Eingabe erforderlich';
                              } else
                                return null;
                            },
                            onSaved: (v) {
                              _carModel.licenseNumber = v.trim();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeHorizontal * 6,
                          ),
                          TextFormField(
                            decoration:
                                Style.inputDecoration('Name des Halters'),
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Eingabe erforderlich';
                              } else
                                return null;
                            },
                            onSaved: (v) {
                              _carModel.holderName = v.trim();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeHorizontal * 6,
                          ),
                          TextFormField(
                            decoration:
                                Style.inputDecoration('Stadt des Halters'),
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Eingabe erforderlich';
                              } else
                                return null;
                            },
                            onSaved: (v) {
                              _carModel.holderCity = v.trim();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeHorizontal * 6,
                          ),
                          TextFormField(
                            decoration:
                                Style.inputDecoration('PLZ des Halters'),
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Eingabe erforderlich';
                              } else
                                return null;
                            },
                            onSaved: (v) {
                              _carModel.holderPostcode = v.trim();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeHorizontal * 6,
                          ),
                          TextFormField(
                            decoration:
                                Style.inputDecoration('Adresse des Halters'),
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Eingabe erforderlich';
                              } else
                                return null;
                            },
                            onSaved: (v) {
                              _carModel.holderStreet = v.trim();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeHorizontal * 6,
                          ),
                          TextFormField(
                            decoration: Style.inputDecoration(
                                'Besitzer Vor- & Nachname'),
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Eingabe erforderlich';
                              } else
                                return null;
                            },
                            onSaved: (v) {
                              _carModel.ownerName = v.trim();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 30, top: 10),
                      width: 200,
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () async {
                          if (_key.currentState.validate()) {
                            _key.currentState.save();
                            // print(provider.user.toJson());
                            // return;
                            await provider.storeCar(_carModel);
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => Home()));
                          } else
                            print('is not validate');
                        },
                        child: Text('Fahrzeug hinzuf??gen'),
                      )),
                ],
              ),
            )));
  }
}
