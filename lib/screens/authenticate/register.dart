import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/custom_button.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:flutter_app/shared/loading.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String categorie = 'Professionnel';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: opi_cf_color_primary,
      appBar: AppBar(
        leading: BackButton(
          color: opi_cf_color_secondary,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: opi_cf_color_primary,
        elevation: 10.0,
        title: Text(
          '$insc',
          style: TextStyle(color: opi_cf_color_secondary),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) =>
                    val.isEmpty ? 'Entrez une adresse mail' : null,
                onChanged: (val) {
                  setState(() {
                    email = val.trim();
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 8
                    ? 'Entrez un mot de passe de plus de 8 caractères'
                    : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val.trim();
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton<String>(
                value: categorie,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24.0,
                elevation: 16,
                focusColor: Color.fromRGBO(245, 246, 241, 1),
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.black38,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    categorie = newValue;
                  });
                },
                items: <String>['Professionnel', 'Particulier']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              CustomButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result =
                        await _authService.registerWithEmailAndPassword(
                            email, password, categorie);
                    if (result == null) {
                      setState(() {
                        error = 'Veuillez renseigner une adresse mail valide';
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  }
                },
                txt: 'S\'inscrire',
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                error,
                style: TextStyle(color: opi_cf_color_secondary, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
