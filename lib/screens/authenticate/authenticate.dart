import 'package:flutter/material.dart';
import 'package:flutter_app/screens/authenticate/register.dart';
import 'package:flutter_app/screens/authenticate/sign_in.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/custom_button.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:flutter_app/shared/myTheme.dart';
import 'package:flutter_app/main.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    /* initState() {
      super.initState();
      MyTheme().callTxt(db);
    }
 */
    return Scaffold(
      backgroundColor: opi_cf_color_primary,
      body: Center(
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: 180.0,
              ),
              Image.asset('assets/images/LogoOpiScan.png'),
              SizedBox(
                height: 180.0,
              ),
              CustomButton(
                txt: con == null ? 'Se connecter' : '$con',
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SignIn()));
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              CustomButton(
                txt: insc == null ? 'S\'inscrire' : '$insc',
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Register()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
