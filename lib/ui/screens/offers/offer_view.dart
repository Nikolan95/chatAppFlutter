import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/offeritem_model.dart';
import 'package:chat_app/ui/size_config.dart';
import 'package:flutter/material.dart';


class OfferItemScreen extends StatelessWidget {
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
  final MessageModel message = ModalRoute.of(context).settings.arguments;
  final List <OfferItemModel> offerItems = message.offerItems;
   List<DataColumn> getColumns(List<String> columns) => columns
    .map((String column) => DataColumn(
      label: Text(column, style: TextStyle(fontWeight: FontWeight.bold),),
    ))  
    .toList();
    List<DataCell>getCells(List<dynamic> cells) => 
    cells.map((data) => DataCell(Text('$data'))).toList();
  List<DataRow> getRows(List<OfferItemModel> offerItems) => offerItems.map((OfferItemModel offerItem) {
    final cells = [
      offerItem.articleNumber,
      offerItem.name,
      offerItem.amount,
      offerItem.price,
      offerItem.total
    ];
    return DataRow(cells: getCells(cells));
  }).toList();
  Widget buildDataTable(){
    final columns = ['Artikel', 'name', 'qty', 'price', 'total'];

    return SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: DataTable(
             columns: 
             
             getColumns(columns),
              rows: getRows(message.offerItems)
           ),
         ),
    );
  }
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
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
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                height: 2.0,
                width: 500.0,
                color: Colors.yellow[700],
              ),
            ),
            buildDataTable(),
            SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                 icon: new Icon(Icons.check),
                 style: TextButton.styleFrom(
                   primary: Colors.green,
                   padding: EdgeInsets.only(top:30, right:20),
                 ),
                 label: Text('Ja', style: TextStyle(fontSize: 30),),
                onPressed: () {
                  print('da');
                },
                ),
              TextButton.icon(
                 icon: new Icon(Icons.close),
                 style: TextButton.styleFrom(
                   primary: Colors.red,
                   padding: EdgeInsets.only(top:30),
                 ),
                 label: Text('Nein', style: TextStyle(fontSize: 30),),
                onPressed: () {
                  print('ne');
                },
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}
