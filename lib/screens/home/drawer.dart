import 'package:flutter/material.dart';
import 'package:flutter_app/screens/authenticate/authenticate.dart';
import 'package:flutter_app/screens/home/articles/articles.dart';
import 'package:flutter_app/screens/home/contacts/contacts.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/home/notifications/notifications.dart';
import 'package:flutter_app/screens/home/scanner/scanner.dart';
import 'package:flutter_app/screens/home/settings/llistFav.dart';
import 'package:flutter_app/screens/home/settings/settings.dart';
import 'package:flutter_app/screens/wrapper.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/shared/databaseVar.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer(this.currentPage);
  final String currentPage;
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: opi_cf_color_secondary,
              ),
              child: Text(
                '$titre',
                style: TextStyle(fontSize: 20.0, color: opi_cf_color_primary),
              ),
            ),
          ),
          ListTile(
            leading: icon_home,
            title: Text('$rub1',
                style: this.currentPage == 'Home'
                    ? textFocusStyleDecoration
                    : textStyleDecoration),
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == 'Home') return;
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => Home()));
            },
          ),
          ListTile(
            leading: icon_scan,
            title: Text('$rub2',
                style: this.currentPage == 'Scanner'
                    ? textFocusStyleDecoration
                    : textStyleDecoration),
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == 'Scanner') return;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Scanner()));
            },
          ),
          ListTile(
            leading: icon_article,
            title: Text('$rub3',
                style: this.currentPage == 'Articles'
                    ? textFocusStyleDecoration
                    : textStyleDecoration),
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == 'Articles') return;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Articles()));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Mes favoris',
                style: this.currentPage == 'ListFav'
                    ? textFocusStyleDecoration
                    : textStyleDecoration),
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == 'ListFav') return;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => ListFav()));
            },
          ),
          ListTile(
            leading: icon_notifications,
            title: Text('$rub4',
                style: this.currentPage == 'Notifications'
                    ? textFocusStyleDecoration
                    : textStyleDecoration),
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == 'Notifications') return;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Notifications()));
            },
          ),
          ListTile(
            leading: icon_contacts,
            title: Text('$rub5',
                style: this.currentPage == 'Contacts'
                    ? textFocusStyleDecoration
                    : textStyleDecoration),
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == 'Contacts') return;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Contacts()));
            },
          ),
          ListTile(
            leading: icon_param,
            title: Text('$rub6',
                style: this.currentPage == 'Settings'
                    ? textFocusStyleDecoration
                    : textStyleDecoration),
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == 'Settings') return;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Settings()));
            },
          ),
          ListTile(
            leading: icon_disc,
            title: Text('$rub7', style: textStyleDecoration),
            onTap: () async {
              await _auth.signOut();
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Wrapper()));
            },
          ),
        ],
      ),
    );
  }
}
