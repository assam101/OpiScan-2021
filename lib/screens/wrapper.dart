import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/authenticate/authenticate.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserM>(context);
    print(user);

    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      print(user.uid + ' ' + user.name + ' ' + user.email);
      return Home();
    }
  }
}
