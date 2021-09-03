import 'package:chat_app/models/car_model.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/ui/screens/car/car_screen.dart';
import 'package:chat_app/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';
import '../../style.dart';

class CarAdd extends StatefulWidget {

  @override
  CarAddState createState() {
    return CarAddState();
  }
}

class CarAddState extends State<CarAdd> {

  CarModel _carModel = new CarModel();
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
              title: Text('Neues Fahrzeug'),
              centerTitle: true,
            ),

            body: SingleChildScrollView(child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 2.0,
                    width: 500.0,
                    color: Style.primaryColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
                  child:  Form(
                    key: _key,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: SizeConfig.blockSizeHorizontal * 6,
                        ),
                        TextFormField(
                          decoration: Style.inputDecoration('First Registration'),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'input require';
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
                          decoration: Style.inputDecoration('Registration plate'),
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
                          decoration: Style.inputDecoration('Brand and Model'),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'input require';
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
                          decoration: Style.inputDecoration('Licence Number'),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'input require';
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
                          decoration: Style.inputDecoration('Holder Name'),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'input require';
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
                          decoration: Style.inputDecoration('Holder City'),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'input require';
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
                          decoration: Style.inputDecoration('Holder Postcode'),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'input require';
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
                          decoration: Style.inputDecoration('Holder Street'),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'input require';
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
                          decoration: Style.inputDecoration('Owner Name'),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'input require';
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
                              MaterialPageRoute(builder: (_) => MainScreen()));
                        } else
                          print('is not validate');
                      },
                      child: Text('Fahrzeug hinzufügen'),
                    )),
              ],
            ),
            )
        )
    );
  }

}
