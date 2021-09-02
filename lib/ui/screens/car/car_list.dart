import 'package:chat_app/models/car_model.dart';
import 'package:chat_app/ui/screens/start_conversation.dart';
//import 'package:chat_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';


class CarList extends StatelessWidget {
  final List<CarModel> cars;

  CarList(this.cars);

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
          
          itemBuilder: (car, index){
            return SizedBox(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                  //side: BorderSide(width: 5, color: Colors.green)
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10, 
                        horizontal: 10
                      ),
                      
                      padding: EdgeInsets.all(5),
                      child: Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StartConversation(),
                                  settings: RouteSettings(
                                    arguments: cars[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              child: ClipRRect(
                                child: Image.asset('assets/car.png',
                                  ),
                              ),),
                          )
                      )
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    )
                ],),
              ),
            );
          },
          itemCount: cars.length,
         
        ),
    );
  }
}