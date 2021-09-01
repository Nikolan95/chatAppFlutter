import 'package:chat_app/models/car_model.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/ui/screens/car/new_car.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../style.dart';
import 'car_list.dart';

class CarScreen extends StatefulWidget  {
  //var _cars = List<CarList>();
  static final routeName = 'carscreen';

  @override
  _CarScreenPageState createState() => _CarScreenPageState();
}

class _CarScreenPageState extends State<CarScreen>{
  @override
    void initState() {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<UserProvider>(context, listen: false);
      });
    }

  void _addNewCar(String firstRegistration, String vehicleIdentificationNumber, String manufacturerAndBrand, String licenseNumber, String holderName, String holderCity, String holderPostcode, String holderStreet, String ownerName){
    final newCar = CarModel(firstRegistration: firstRegistration, vehicleIdentificationNumber: vehicleIdentificationNumber, manufacturerAndBrand: manufacturerAndBrand, licenseNumber: licenseNumber, holderName: holderName, holderCity: holderCity, holderPostcode: holderPostcode, holderStreet: holderStreet, ownerName: ownerName);
    //Provider.of<UserProvider>.storeCar(car);
    setState(() {
       Provider.of<UserProvider>(context, listen: false).user.cars.add(newCar);
       Provider.of<UserProvider>(context, listen: false).storeCar(newCar);
    });
  }

  
  void _startAddNewCar(BuildContext ctx){
    showModalBottomSheet(
      context: ctx, 
      builder: (_) {
      return GestureDetector(
        onTap: () {},
        child: NewCar(_addNewCar),
        behavior: HitTestBehavior.opaque,
      );
    },);
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
      body:SingleChildScrollView(
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 35, bottom: 15),
                  child: Image.asset(
                      'assets/logo-atev-white.png',
                  )
                ),
               Padding(
                    padding:EdgeInsets.only(bottom: 20),
                    child:Container(
                    height:2.0,
                    width:500.0,
                    color:Style.primaryColor),
                ),
                Container(
                  height: 50,
                  child: Text('Fahrzeuge', style: TextStyle(fontSize: 20),),
                ),
                Container(
                  child: 
                  ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () => _startAddNewCar(context),
                    child: Text('Neues Fahrung erstellen'),
                  )
                ),
                CarList(provider.user.cars),
              ],
            ),
        ),
    ),
    );     
    
  }
}


