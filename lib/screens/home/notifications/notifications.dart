import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/home/drawer.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  Notifications({this.product});
  final Product product;

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final AuthService _auth = AuthService();

  DateFormat format = DateFormat('DD/MM/yyyy');
  DateTime now = DateTime.now();

  int daysBetween(DateTime from, String tof) {
    DateTime to = format.parse(tof);
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    if (to.difference(from).inDays <= 0) {
      return 1;
    } else if (to.difference(from).inDays > 0 &&
        to.difference(from).inDays <= 10) {
      return 2;
    } else
      return 3;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserM>(context);
    return Scaffold(
      backgroundColor: opi_cf_color_primary,
      drawer: CustomDrawer("Notifications"),
      appBar: AppBar(
        leading: BackButton(
            color: opi_cf_color_secondary,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => Home()));
            }),
        title: Text(
          'Notifications',
        ),
        backgroundColor: opi_cf_color_primary,
        elevation: 10.0,
        iconTheme: IconThemeData(color: opi_cf_color_primary),
      ),
      body: Container(
          child: StreamBuilder<List>(
              stream: AuthService(uid: user.uid).getListFavoris(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder<Product>(
                              stream: DatabaseService(uid: snapshot.data[index])
                                  .productsFavoris,
                              builder: (context, produit) {
                                int i = daysBetween(
                                    now, produit.data.expirationDate);
                                print(i);
                                return produit.hasData
                                    ? i == 3
                                        ? SizedBox(
                                            height: 10,
                                          )
                                        : Card(
                                            shape: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                    color: Colors.white24)),
                                            margin: EdgeInsets.fromLTRB(
                                                8.0, 2.0, 8.0, 0.0),
                                            child: ListTile(
                                                leading: i == 2
                                                    ? Container(
                                                        height: 10.0,
                                                        width: 10.0,
                                                        decoration:
                                                            new BoxDecoration(
                                                                color: Colors
                                                                    .orange,
                                                                shape: BoxShape
                                                                    .circle),
                                                      )
                                                    : Container(
                                                        height: 10.0,
                                                        width: 10.0,
                                                        decoration:
                                                            new BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle),
                                                      ),
                                                title: i == 2
                                                    ? Text(
                                                        '${produit.data.name} arrive à expiration')
                                                    : i == 1
                                                        ? Text(
                                                            '${produit.data.name} est périmé')
                                                        : Text('')))
                                    : Text('loading');
                              });
                        })
                    : Center(
                        child: Text('Vous trouverez vos alertes'),
                      );
              })),
    );
  }
}
