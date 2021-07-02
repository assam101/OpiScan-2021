import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/contacts/contacted.dart';
import 'package:flutter_app/screens/home/contacts/contacter.dart';
import 'package:flutter_app/screens/home/drawer.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/databaseVar.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts>
    with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  TabController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: opi_cf_color_primary,
      drawer: CustomDrawer("Contacts"),
      appBar: AppBar(
        title: Text(
          'Contacts',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: opi_cf_color_primary,
        elevation: 10.0,
        iconTheme: IconThemeData(color: opi_cf_color_secondary),
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(
              text: 'Contacter',
            ),
            Tab(
              text: 'Etre contacté',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [Contacter(), Contacted()],
      ),
    );
  }
}
