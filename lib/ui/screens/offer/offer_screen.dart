import 'package:chat_app/constants/size_config.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/models/offer_item.dart';
import 'package:chat_app/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../home/home.dart';

class OfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String bullet = "\u2022 ";
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Colors.yellow[700],
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
    final ChatMessage message = ModalRoute.of(context).settings.arguments;
    final List<OfferItem> offerItems = message.offerItems;
    var sum = 0;
    offerItems.forEach((element) {
      sum += element.total;
    });
    List<DataColumn> getColumns(List<String> columns) => columns
        .map((String column) => DataColumn(
              label: Text(
                column,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ))
        .toList();
    List<DataCell> getCells(List<dynamic> cells) =>
        cells.map((data) => DataCell(Text('$data'))).toList();
    List<DataRow> getRows(List<OfferItem> offerItems) =>
        offerItems.map((OfferItem offerItem) {
          final cells = [
            offerItem.name,
            offerItem.amount,
            NumberFormat.simpleCurrency(locale: 'eu').format(offerItem.price),
            NumberFormat.simpleCurrency(locale: 'eu').format(offerItem.total)
          ];
          return DataRow(cells: getCells(cells));
        }).toList();
    Widget buildDataTable() {
      final columns = ['Name', 'Stk', 'Preis', 'Gesamt'];

      return Container(
        height: 225,
        padding: EdgeInsets.only(right: 20, left: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columns: getColumns(columns),
                rows: getRows(message.offerItems)),
          ),
        ),
      );
    }

    void accept() async {
      final id = message.id;
      final offer = 'accept';

      await Provider.of<ChatProvider>(context, listen: false)
          .updateMessage(id, offer);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }

    void decline() async {
      final id = message.id;
      final offer = 'decline';

      await Provider.of<ChatProvider>(context, listen: false)
          .updateMessage(id, offer);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
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
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text('Liefer- & Zahlungsbedingungen:'),
              ),
              Container(
                height: 200,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 30),
                child:
                    // Text(
                    //    //message.termsAndConditions.first.body.toString()
                    //   'Terms and Conditions:'
                    // ),
                    ListView.builder(
                  itemBuilder: (term, index) {
                    return SizedBox(
                      child: Text(bullet +
                          message.termsAndConditions[index].body.toString()),
                    );
                  },
                  itemCount: message.termsAndConditions.length,
                ),
                // ],
                // ),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(top: 10, right: 30),
                child: Text(
                  'Gesamtsumme ' +
                      NumberFormat.simpleCurrency(locale: 'eu').format(sum),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  TextButton.icon(
                    icon: new Icon(Icons.check),
                    style: TextButton.styleFrom(
                      primary: Colors.green,
                      padding: EdgeInsets.only(top: 30, right: 20),
                    ),
                    label: Text(
                      'JA',
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: accept,
                  ),
                  TextButton.icon(
                    icon: new Icon(Icons.close),
                    style: TextButton.styleFrom(
                      primary: Colors.red,
                      padding: EdgeInsets.only(top: 30),
                    ),
                    label: Text(
                      'NEIN',
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: decline,
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
