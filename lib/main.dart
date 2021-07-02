import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/wrapper.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/wrapper.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_app/shared/myTheme.dart';

final db = FirebaseDatabase.instance.reference();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MyTheme().callColor(db);
  MyTheme().callTxt(db);
  MyTheme().callFontSize(db);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserM>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [const Locale('en'), const Locale('fr')],
        home: Wrapper(),
        theme: ThemeData(
          // Define the default brightness and colors.
          primaryColor: Colors.white,
          accentColor: Colors.redAccent,
        ),
      ),
    );
  }
}
