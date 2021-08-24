import 'package:flutter/material.dart';

class NewCar extends StatefulWidget {
  
  final Function addCar;
  

  NewCar(this.addCar);

  @override
  _NewCarState createState() => _NewCarState();
}
class _NewCarState extends State<NewCar>{

  final firstRegistrationController = TextEditingController();
  final vehicleIdentificationNumberController = TextEditingController();
  final manufacturerAndBrandController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final holderNameController = TextEditingController();
  final holderCityController = TextEditingController();
  final holderPostcodeController = TextEditingController();
  final holderStreetController = TextEditingController();
  final ownerNameController = TextEditingController();

  void submitData(){
    final enteredFirstregistration = firstRegistrationController.text;
    final enteredVehicleidentificationnumber = vehicleIdentificationNumberController.text;
    final enteredManufacturerandbrand = manufacturerAndBrandController.text;
    final enteredLicensenumber = licenseNumberController.text;
    final enteredHoldername = holderNameController.text;
    final enteredHoldercity = holderCityController.text;
    final enteredHolderpostcode= holderPostcodeController.text;
    final enteredHolderstreet = holderStreetController.text;
    final enteredOwnername = ownerNameController.text;

    if(enteredManufacturerandbrand.isEmpty || enteredVehicleidentificationnumber.isEmpty){
      return;
    }

    //widget.method is available in state class and can triger functions outside class
    widget.addCar(
      enteredFirstregistration, 
      enteredVehicleidentificationnumber,
      enteredManufacturerandbrand,
      enteredLicensenumber,
      enteredHoldername,
      enteredHoldercity,
      enteredHolderpostcode,
      enteredHolderstreet,
      enteredOwnername
    );

    Navigator.of(context).pop();
  }

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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'First Registration'),
              controller: firstRegistrationController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Registration plate'),
              controller: vehicleIdentificationNumberController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Brand and Model'),
              controller: manufacturerAndBrandController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Licence Number'),
              controller: licenseNumberController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Holder Name'),
              controller: holderNameController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Holder City'),
              controller: holderCityController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Holder Postcode'),
              controller: holderPostcodeController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Holder Street'),
              controller: holderStreetController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Owner Name'),
              controller: ownerNameController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submitData(),
            ),
            ElevatedButton(
              style: raisedButtonStyle,
              onPressed: submitData,
              child: Text('Add new car'),
              ),
          ],
        ),
      ),
    );
  }
}