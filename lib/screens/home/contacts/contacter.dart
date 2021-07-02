import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/drawer.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/custom_button.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Contacter extends StatefulWidget {
  @override
  _ContacterState createState() => _ContacterState();
}

class _ContacterState extends State<Contacter> {
  String object = 'Demande d informations';
  final _formKey = GlobalKey<FormState>();
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 15,
            ),
            Text(
              'Objet : ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 15),
            DropdownButton<String>(
                value: object,
                focusColor: Color.fromRGBO(245, 246, 241, 1),
                items: <String>[
                  'Demande d informations',
                  'Produits',
                  'Collaboration',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String value) {
                  setState(() {
                    object = value;
                  });
                },
                icon:
                    Icon(Icons.arrow_drop_down_outlined, color: Colors.black)),
          ],
        ),
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: TextFormField(
            maxLines: null,
            decoration: textInputDecoration.copyWith(hintText: 'Message'),
            validator: (val) => val.isEmpty ? 'Entrer votre message' : null,
            onChanged: (val) {
              setState(() => message = val);
            },
          )),
          SizedBox(
            width: 15,
          ),
          SizedBox(height: 50),
        ]),
        SizedBox(height: 50),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: CustomButton(
            txt: 'Envoyer',
            onPressed: () {
              return message == null
                  ? Fluttertoast.showToast(
                      msg: "Veuillez remplir tous les champs",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey[200],
                      textColor: Colors.black,
                      fontSize: 16.0)
                  : _send(object, message);
            },
          ),
        )

        /*  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: TextFormField(
                  maxLines: null,
                  decoration: textInputDecoration.copyWith(hintText: 'Message'),
                  validator: (val) =>
                      val.isEmpty ? 'Entrer votre message' : null,
                  onChanged: (val) {
                    setState(() => message = val);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 8,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    primary: opi_cf_color_secondary,
                    textStyle: TextStyle(
                      foreground: Paint()..color = Colors.white,
                    )),
                onPressed: () {
                  if (_formKey.currentState.validate()) {}
                },
                child: Text('Envoyer'),
              ),
            )
          */
      ]),
    ));
  }

  void _send(String objet, String message) async {
    final String email = 'assamboudif@gmail.com';
    final url = 'mailto:$email?subject=$objet&body=$message';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Une erreur a été rencontrée';
    }
  }
}
