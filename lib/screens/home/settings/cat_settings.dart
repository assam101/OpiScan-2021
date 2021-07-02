/* import 'package:flutter/material.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/screens/home/drawer.dart';
import 'package:flutter_app/screens/home/settings/list_settings.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/left_right_align.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:provider/provider.dart';

class CatSettings extends StatefulWidget {
  @override
  _CatSettingsState createState() => _CatSettingsState();
}

class _CatSettingsState extends State<CatSettings> {
  final AuthService _auth = AuthService();
  String catName;
  TextEditingController _controllerCat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Category>>.value(
      initialData: [],
      value: DatabaseService().categories,
      child: Scaffold(
        backgroundColor: opi_cf_color_primary,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Paramètres de catégorie',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: opi_cf_color_primary,
          elevation: 10.0,
          iconTheme: IconThemeData(color: opi_cf_color_secondary),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          showAlertCat(context);
                        },
                        child: Text(
                          '+ Ajouter',
                          style: TextStyle(color: opi_cf_color_secondary),
                        ))),
                SizedBox(
                  height: 20.0,
                ),
                ListCategories(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAlertCat(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Saisir le nom de la catégorie',
                style: TextStyle(color: opi_cf_color_secondary),
              ),
              content: TextFormField(
                controller: _controllerCat,
                onChanged: (val) {
                  catName = val;
                  print(catName);
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Annuler',
                      style: TextStyle(color: opi_cf_color_secondary),
                    )),
                TextButton(
                    onPressed: () async {
                      await DatabaseService().addCategory(catName);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Valider',
                      style: TextStyle(color: opi_cf_color_secondary),
                    )),
              ],
            ));
  }
}
 */
