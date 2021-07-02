import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/drawer.dart';
import 'package:flutter_app/screens/home/settings/cat_settings.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/custom_button.dart';
import 'package:flutter_app/shared/databaseVar.dart';

class Settings extends StatelessWidget {
  final AuthService _auth = AuthService();
  /* TextEditingController _passwordController = TextEditingController(); */
  TextEditingController _newpassController = TextEditingController();
  TextEditingController _renewpassController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: opi_cf_color_primary,
        drawer: CustomDrawer("Settings"),
        appBar: AppBar(
          title: Text(
            'Paramètres',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: opi_cf_color_primary,
          elevation: 10.0,
          iconTheme: IconThemeData(color: opi_cf_color_secondary),
        ),
        body: Center(
          child: Text('En cours de développement'),
        )
        /*Flexible(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /* TextFormField(
              decoration: 
                InputDecoration(hintText: 'Mot de passe'),
                controller: _passwordController,
            ), */
                    TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Nouveau Mot de passe'),
                      controller: _newpassController,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Confirmer le mot de passe'),
                      obscureText: true,
                      controller: _renewpassController,
                      validator: (value) {
                        _newpassController == value
                            ? null
                            : "mot de passe invalide";
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      txt: 'Enregistrer',
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                )))

         body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 50,
                width: 380,
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black)))),
                  onPressed: () {},
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Modifier les préférences d\'affichage',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 50,
                width: 380,
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black)))),
                  onPressed: () {},
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ajouter une liste',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 50,
                width: 380,
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black)))),
                  onPressed: () {},
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Supprimer la liste complète',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
            ],
          ),
        ),
      ), */
        );
  }
}
