import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/screens/home/articles/articles.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/custom_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:image_picker/image_picker.dart';

class ScannerProduct extends StatefulWidget {
  final Barcode result;
  ScannerProduct(this.result);

  @override
  _ScannerProductState createState() => _ScannerProductState();
}

class _ScannerProductState extends State<ScannerProduct> {
  File image;
  bool justLoaded = true;
  String name = 'Produit inconnu';
  String expirationDate = 'Indisponible';
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  String category = 'Indéfini';
  String location;
  Position myPosition;
  List<Placemark> placemark;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerDate = TextEditingController();
  TextEditingController _controllerCat = TextEditingController();

  void initialisation() async {
    Position p = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      myPosition = p;
    });
    List<Placemark> place = await Geolocator()
        .placemarkFromCoordinates(myPosition.latitude, myPosition.longitude);

    setState(() {
      placemark = place;
    });
  }

  @override
  void initState() {
    super.initState();
    initialisation();
  }

  @override
  Widget build(BuildContext context) {
    print(myPosition.latitude);
    String scanDate = dateFormat.format(DateTime.now());
    if (justLoaded) {
      Future.delayed(
        Duration.zero,
        () => showAlertName(context, justLoaded),
      );
      justLoaded = !justLoaded;
    }
    return Container(
      padding: EdgeInsets.all(30.0),
      child: ListView(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Scanné le : $scanDate ',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Code référence : ${widget.result.code}',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            onTap: () async {
              PickedFile selected =
                  await ImagePicker().getImage(source: ImageSource.camera);
              setState(() {
                image = File(selected.path);
              });
            },
            child: Container(
              height: 250.0,
              width: 200.0,
              decoration: BoxDecoration(
                color: opi_cf_color_tertiary,
                image: DecorationImage(
                  image: image == null
                      ? AssetImage('assets/images/add.png')
                      : FileImage(image),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
                onPressed: () {
                  showAlertName(context, justLoaded);
                },
                child: Text(
                  name,
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                )),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Icon(Icons.category),
            SizedBox(
              width: 15.0,
            ),
            TextButton(
                onPressed: () {
                  showAlertCat(context);
                },
                child: Text(
                  category,
                  style: TextStyle(color: Colors.black),
                )),
          ]),
          SizedBox(
            height: 15.0,
          ),
          Row(children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Icon(Icons.calendar_today),
            SizedBox(
              width: 15.0,
            ),
            TextButton(
                onPressed: () {
                  showAlertDate(context, justLoaded);
                },
                child: Text(
                  expirationDate,
                  style: TextStyle(color: Colors.black),
                )),
          ]),
          SizedBox(
            height: 15.0,
          ),
          CustomButton(
            onPressed: () async {
              if (image != null &&
                  expirationDate.compareTo('Indisponible') != 0) {
                print('LATITUUUDE ${myPosition.latitude}');
                Placemark p = placemark.elementAt(0);
                setState(() {
                  location = p.locality +
                      ', ' +
                      p.subAdministrativeArea +
                      ', ' +
                      p.administrativeArea;
                });
                print(location);
                await DatabaseService().addProduct(widget.result.code, scanDate,
                    name, category, expirationDate, image, location);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Articles()));
              }
              if (expirationDate.compareTo('Indisponible') == 0) {
                Fluttertoast.showToast(
                    msg: "Veuillez ajouter une date d'expiration",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey[200],
                    textColor: Colors.black,
                    fontSize: 16.0);
              }
              if (image == null) {
                Fluttertoast.showToast(
                    msg: "Veuillez ajouter une image au produit",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey[200],
                    textColor: Colors.black,
                    fontSize: 16.0);
              }
            },
            txt: 'Ajouter le produit',
          ),
        ],
      ),
    );
  }

  void showAlertName(BuildContext context, bool justLoaded) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Saisir le nom',
                style: TextStyle(color: opi_cf_color_secondary),
              ),
              content: TextFormField(
                controller: _controllerName,
                onChanged: (String newValue) {
                  setState(() {
                    name = newValue;
                  });
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
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (justLoaded) showAlertDate(context, justLoaded);
                    },
                    child: Text(
                      'Valider',
                      style: TextStyle(color: opi_cf_color_secondary),
                    )),
              ],
            ));
  }

  void showAlertDate(BuildContext context, bool justLoaded) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Saisir la date de péremption',
                style: TextStyle(color: opi_cf_color_secondary),
              ),
              content: TextField(
                readOnly: true,
                controller: _controllerDate,
                onTap: () {
                  showDatePicker(
                    context: context,
                    locale: const Locale("fr", "FR"),
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 5, 1),
                    lastDate: DateTime(DateTime.now().year + 50, 12),
                  ).then((value) => {
                        if (value != null)
                          {_controllerDate.text = dateFormat.format(value)}
                      });
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
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        expirationDate = _controllerDate.text;
                      });
                      if (justLoaded) showAlertCat(context);
                    },
                    child: Text(
                      'Valider',
                      style: TextStyle(color: opi_cf_color_secondary),
                    )),
              ],
            ));
  }

  void showAlertCat(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Catégorie',
                style: TextStyle(color: opi_cf_color_secondary),
              ),
              content: DropdownButton<String>(
                value: category,
                elevation: 16,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24.0,
                style: TextStyle(color: opi_cf_color_secondary),
                underline: Container(
                  height: 2,
                  color: opi_cf_color_secondary,
                ),
                items: <String>[
                  'Indéfini',
                  'Alimentaire',
                  'Médicament',
                  'Hygiène'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    category = newValue;
                  });
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Valider',
                      style: TextStyle(color: opi_cf_color_secondary),
                    )),
              ],
            ));
  }

  Future<void> _pickImage(ImageSource source) async {
    //PickedFile selected = await ImagePicker().getImage(source: source);
    PickedFile selected = await ImagePicker().getImage(source: source);
    //File cropped = await _cropImage(selected.path);

    setState(() {
      image = File(selected.path);
    });
  }
}
