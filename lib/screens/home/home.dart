import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/drawer.dart';
import 'package:flutter_app/screens/home/articles/articles.dart';
import 'package:flutter_app/screens/home/contacts/contacts.dart';
import 'package:flutter_app/screens/home/notifications/notifications.dart';
import 'package:flutter_app/screens/home/scanner/scanner.dart';
import 'package:flutter_app/screens/home/settings/settings.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/custom_button.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:flutter_app/shared/myTheme.dart';
import 'package:flutter_app/main.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = '';
  bool cat = false;

  /*  void showToast() {
      setState(() {
        _isVisible = !_isVisible;
      });
    } */
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserM>(context);
    /* print(mainC);
    print(secondC);
    print(thirdC); */
    /* MyTheme().callTxt(db); */
    setState(() {
      uid = FirebaseAuth.instance.currentUser.uid;
    });
    final AuthService _auth = AuthService(uid: uid);
    return Scaffold(
      backgroundColor: opi_cf_color_primary,
      drawer: CustomDrawer("Home"),
      appBar: AppBar(
        backgroundColor: opi_cf_color_primary,
        elevation: 10.0,
        iconTheme: IconThemeData(color: opi_cf_color_secondary),
      ),
      body: StreamBuilder<UserM>(
          stream: _auth.getUser(),
          builder: (context, snapshot) {
            return Center(
              child: Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: 95.0,
                    ),
                    Image.asset('assets/images/LogoOpiScan.png'),
                    SizedBox(
                      height: 65.0,
                    ),
                    CustomButton(
                      txt: '$rub2',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Scanner()));
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomButton(
                      txt: '$rub3',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Articles()));
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomButton(
                      txt: '$rub4',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Notifications()));
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomButton(
                      txt: '$rub5',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Contacts()));
                      },
                    ),
                    /*  SizedBox(
                      height: 20.0,
                    ),
                    CustomButton(
                      txt: '$rub6',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Settings()));
                      },
                    ), */
                  ],
                ),
              ),
            );
          }),
    );
  }
}
