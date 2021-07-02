import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/drawer.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/custom_button.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Contacted extends StatefulWidget {
  @override
  _ContactedState createState() => _ContactedState();
}

class _ContactedState extends State<Contacted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Text(
          'Vous voulez être contactés ?',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 40,
        ),
        Center(
          child: CustomButton(
            txt: 'Etre contacté',
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "Demande envoyée",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red[400],
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
          ),
        )
      ],
    ));
  }
}
