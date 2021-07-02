import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/screens/home/articles/list_products.dart';
import 'package:flutter_app/screens/home/drawer.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/shared/databaseVar.dart';

class Articles extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
      initialData: [],
      value: DatabaseService().products,
      child: Scaffold(
        backgroundColor: opi_cf_color_primary,
        drawer: CustomDrawer("Articles"),
        appBar: AppBar(
          title: Text(
            'Produits scannés',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: opi_cf_color_primary,
          elevation: 10.0,
          iconTheme: IconThemeData(color: opi_cf_color_secondary),
        ),
        body: Center(
          child: Container(
            child: ListProducts(),
          ),
        ),
      ),
    );
  }
}
