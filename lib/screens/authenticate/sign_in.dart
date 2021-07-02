import 'package:flutter/material.dart';
import 'package:flutter_app/screens/authenticate/register.dart';
import 'package:flutter_app/screens/home/drawer.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/custom_button.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:flutter_app/shared/databaseVar.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
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
          'Se connecter',
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
              CustomButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _authService
                        .signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error =
                            'L\'adresse mail et/ou le mot de passe est invalide';
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  }
                },
                txt: '$con',
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
