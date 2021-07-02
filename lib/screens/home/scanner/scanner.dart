import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/drawer.dart';
import 'package:flutter_app/screens/home/scanner/scanner_view.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/databaseVar.dart';

class Scanner extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: opi_cf_color_primary,
      drawer: CustomDrawer("Scanner"),
      appBar: AppBar(
        title: Text(
          'Scanner',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: opi_cf_color_primary,
        elevation: 10.0,
        iconTheme: IconThemeData(color: opi_cf_color_secondary),
      ),
      body: ScannerView(),
    );
  }
}
