import 'package:chat_app/constants/size_config.dart';
import 'package:chat_app/models/car.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';
import 'car_list.dart';

class CarEdit extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    final Car car = ModalRoute.of(context).settings.arguments;

    final firstRegistrationController =
        TextEditingController(text: car.firstRegistration);
    final vehicleIdentificationNumberController =
        TextEditingController(text: car.vehicleIdentificationNumber);
    final manufacturerAndBrandController =
        TextEditingController(text: car.manufacturerAndBrand);
    final licenseNumberController =
        TextEditingController(text: car.licenseNumber);
    final holderNameController = TextEditingController(text: car.holderName);
    final holderCityController = TextEditingController(text: car.holderCity);
    final holderPostcodeController =
        TextEditingController(text: car.holderPostcode);
    final holderStreetController =
        TextEditingController(text: car.holderStreet);
    final ownerNameController = TextEditingController(text: car.ownerName);

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Style.primaryColor,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
    void submitData() {
      final enteredFirstregistration = firstRegistrationController.text;
      final enteredVehicleidentificationnumber =
          vehicleIdentificationNumberController.text;
      final enteredManufacturerandbrand = manufacturerAndBrandController.text;
      final enteredLicensenumber = licenseNumberController.text;
      final enteredHoldername = holderNameController.text;
      final enteredHoldercity = holderCityController.text;
      final enteredHolderpostcode = holderPostcodeController.text;
      final enteredHolderstreet = holderStreetController.text;
      final enteredOwnername = ownerNameController.text;

      Car editedCar = new Car();

      editedCar.id = car.id;
      editedCar.firstRegistration = enteredFirstregistration;
      editedCar.vehicleIdentificationNumber =
          enteredVehicleidentificationnumber;
      editedCar.manufacturerAndBrand = enteredManufacturerandbrand;
      editedCar.licenseNumber = enteredLicensenumber;
      editedCar.holderName = enteredHoldername;
      editedCar.holderCity = enteredHoldercity;
      editedCar.holderPostcode = enteredHolderpostcode;
      editedCar.holderStreet = enteredHolderstreet;
      editedCar.ownerName = enteredOwnername;
      editedCar.userId = car.userId;

      provider.updateCar(editedCar);

      Navigator.of(context).push(MaterialPageRoute(builder: (_) => CarList()));
    }

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
                    Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Container(
                        height: 2.0,
                        width: 500.0,
                        color: Style.primaryColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 15),
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 4),
                      child: Form(
                        key: _key,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration:
                                  Style.inputDecoration('First Registration'),
                              controller: firstRegistrationController,
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'input require';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal * 6,
                            ),
                            TextFormField(
                              decoration:
                                  Style.inputDecoration('Registration plate'),
                              controller: licenseNumberController,
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'input require';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal * 6,
                            ),
                            TextFormField(
                              decoration:
                                  Style.inputDecoration('Brand and Model'),
                              controller: manufacturerAndBrandController,
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'input require';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal * 6,
                            ),
                            TextFormField(
                              decoration:
                                  Style.inputDecoration('Licence Number'),
                              controller: licenseNumberController,
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'input require';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal * 6,
                            ),
                            TextFormField(
                              decoration: Style.inputDecoration('Holder Name'),
                              controller: holderNameController,
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'input require';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal * 6,
                            ),
                            TextFormField(
                              decoration: Style.inputDecoration('Holder City'),
                              controller: holderCityController,
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'input require';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal * 6,
                            ),
                            TextFormField(
                              decoration:
                                  Style.inputDecoration('Holder Postcode'),
                              controller: holderPostcodeController,
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'input require';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal * 6,
                            ),
                            TextFormField(
                              controller: holderCityController,
                              decoration:
                                  Style.inputDecoration('Holder Street'),
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'input require';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal * 6,
                            ),
                            TextFormField(
                              decoration: Style.inputDecoration('Owner Name'),
                              controller: ownerNameController,
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'input require';
                                } else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal * 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 30),
                        width: 200,
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () async {
                            submitData();
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => Home()));
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
