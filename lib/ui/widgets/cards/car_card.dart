import 'package:chat_app/constants/style.dart';
import 'package:chat_app/models/car.dart';
import 'package:chat_app/ui/screens/car/car_edit.dart';
//import 'package:chat_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class CarCard extends StatelessWidget {
  final List<Car> cars;

  CarCard(this.cars);

  Widget build(BuildContext context) {
    //var provider = Provider.of<UserProvider>(context);
    return Container(
      height: 420,
      padding: EdgeInsets.all(15),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.red[500],
      //   ),
      //   borderRadius: BorderRadius.all(Radius.circular(20))
      // ),
      child: ListView.builder(
        itemBuilder: (car, index) {
          return SizedBox(
            child: Card(
              color: Colors.transparent,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Style.primaryColor, width: 1),
                //side: BorderSide(width: 5, color: Colors.green)
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        padding: EdgeInsets.all(5),
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                child: IconButton(
                              icon: Image.asset('assets/car_side.png'),
                              iconSize: 25,
                            ))),
                      )),
                  Expanded(
                      flex: 5,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            Text(
                              cars[index].manufacturerAndBrand,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              cars[index].licenseNumber.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  child: IconButton(
                                icon: new Icon(Icons.edit),
                                onPressed: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (_) => CarEdit(),
                                  settings:
                                      RouteSettings(arguments: cars[index]),
                                )),
                              )))))
                ],
              ),
            ),
          );
        },
        itemCount: cars.length,
      ),
    );
  }
}
