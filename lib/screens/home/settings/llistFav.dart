import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/home/articles/articles.dart';
import 'package:flutter_app/screens/home/articles/detail_product.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:provider/provider.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class ListFav extends StatefulWidget {
  ListFav({this.product});
  final Product product;

  @override
  _ListFavState createState() => _ListFavState();
}

class _ListFavState extends State<ListFav> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserM>(context);
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => Home()));
            },
          ),
          title: Text('Mes favoris'),
          backgroundColor: opi_cf_color_primary,
          elevation: 10.0,
          iconTheme: IconThemeData(color: opi_cf_color_secondary),
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
                                return produit.hasData
                                    ? Card(
                                        shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                color: Colors.white24)),
                                        margin: EdgeInsets.fromLTRB(
                                            15.0, 2.0, 15.0, 0.0),
                                        child: ListTile(
                                          title: Text(produit.data.name),
                                          trailing: IconButton(
                                              icon: Icon(Icons.remove,
                                                  color: Colors.red[400]),
                                              onPressed: () {
                                                AuthService(uid: user.uid)
                                                    .removeList(
                                                        produit.data.reference);
                                              }),
                                        ))
                                    : Text('produit loading');
                              });
                        })
                    : Text('Loading');
              }),
        ));
  }
}
