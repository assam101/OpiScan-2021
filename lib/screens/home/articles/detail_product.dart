import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/left_right_align.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:provider/provider.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class DetailProduct extends StatefulWidget {
  final Product product;
  DetailProduct(this.product);

  @override
  _DetailProductState createState() => _DetailProductState(this.product);
}

class _DetailProductState extends State<DetailProduct> {
  final Product product;
  _DetailProductState(this.product);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserM>(context);

    return Scaffold(
        backgroundColor: opi_cf_color_primary,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('${product.name}'),
          backgroundColor: opi_cf_color_primary,
          elevation: 10.0,
          iconTheme: IconThemeData(color: opi_cf_color_secondary),
        ),
        body: Container(
          padding: EdgeInsets.all(30.0),
          child: ListView(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 240.0,
                width: 350.0,
                decoration: BoxDecoration(),
                child: FutureBuilder(
                    future: DatabaseService().getImagePath(product.image),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Image(
                              image: NetworkImage(snapshot.data),
                            )
                          : Image(
                              image: AssetImage('assets/images/NoImage.jpg'));
                    }),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.name,
                  style: TextStyle(fontSize: 30.0),
                ),
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
                    onPressed: null,
                    child: Text(
                      product.category,
                      style: TextStyle(color: Colors.black),
                    )),
              ]),
              Row(children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                Icon(Icons.warning_sharp),
                SizedBox(
                  width: 15.0,
                ),
                TextButton(
                    onPressed: null,
                    child: Text(
                      'Expire le: ${product.expirationDate}',
                      style: TextStyle(color: Colors.black),
                    )),
              ]),
              Row(children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                Icon(Icons.calendar_today),
                SizedBox(
                  width: 15.0,
                ),
                TextButton(
                    onPressed: null,
                    child: Text(
                      'Scanné le: ${product.scanDate}',
                      style: TextStyle(color: Colors.black),
                    )),
              ]),
              Row(children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                Icon(Icons.location_on),
                TextButton(
                    onPressed: null,
                    child: Text(
                      '${product.location}',
                      style: TextStyle(color: Colors.black),
                    ))
              ]),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(children: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                      Icon(Icons.confirmation_number),
                      SizedBox(
                        width: 15.0,
                      ),
                      TextButton(
                          onPressed: null,
                          child: Text(
                            'Réf: ${product.reference}',
                            style: TextStyle(color: Colors.black),
                          )),
                    ]),
                  ))
            ],
          ),
        ),
        floatingActionButton: StreamBuilder<List>(
            stream: AuthService(uid: user.uid).getListFavoris(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? !snapshot.data.contains(product.reference)
                      ? SpeedDial(
                          animatedIcon: AnimatedIcons.menu_close,
                          backgroundColor: opi_cf_color_secondary,
                          foregroundColor: opi_cf_color_primary,
                          children: [
                            SpeedDialChild(
                              child: Icon(Icons.favorite_border),
                              label: 'Ajouter à mes favoris',
                              foregroundColor: opi_cf_color_secondary,
                              onTap: () {
                                AuthService(uid: user.uid)
                                    .addList(product.reference);
                                Fluttertoast.showToast(
                                    msg: "Produit ajouté aux favoris",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                            ),
                            SpeedDialChild(
                                child: Icon(Icons.share),
                                label: 'Partager',
                                foregroundColor: Colors.lightBlue,
                                onTap: () async {
                                  try {
                                    final ByteData bytes = await rootBundle
                                        .load('assets/images/LogoOpiScan.png');
                                    await WcFlutterShare.share(
                                        sharePopupTitle: 'Partager',
                                        subject:
                                            'Partager ${widget.product.name} avec un ami',
                                        text:
                                            'Salut! \n Je te suggère de consulter ce produit sur Opiscan, tu ne seras pas déçu.',
                                        mimeType: 'image/png',
                                        fileName: 'share.png',
                                        bytesOfFile:
                                            bytes.buffer.asUint8List());
                                  } catch (e) {
                                    print('error: $e');
                                  }
                                })
                          ],
                          /* onPressed: () {},
              child: Icon(Icons.favorite_border), */
                        )
                      : SpeedDial(
                          animatedIcon: AnimatedIcons.menu_close,
                          backgroundColor: opi_cf_color_secondary,
                          foregroundColor: opi_cf_color_primary,
                          children: [
                            SpeedDialChild(
                              child: Icon(Icons.favorite),
                              label: 'Retirer de mes favoris',
                              foregroundColor: opi_cf_color_secondary,
                              onTap: () {
                                AuthService(uid: user.uid)
                                    .removeList(product.reference);
                              },
                            ),
                            SpeedDialChild(
                                child: Icon(Icons.share),
                                label: 'Partager',
                                foregroundColor: Colors.lightBlue,
                                onTap: () async {
                                  try {
                                    final ByteData bytes = await rootBundle
                                        .load('assets/images/LogoOpiScan.png');
                                    await WcFlutterShare.share(
                                        sharePopupTitle: 'Partager',
                                        subject:
                                            'Partager ${widget.product.name} avec un ami',
                                        text:
                                            'Salut! \n Je te suggère de consulter ce produit sur Opiscan, tu ne seras pas déçu.',
                                        mimeType: 'image/png',
                                        fileName: 'share.png',
                                        bytesOfFile:
                                            bytes.buffer.asUint8List());
                                  } catch (e) {
                                    print('error: $e');
                                  }
                                })
                          ],
                          /* onPressed: () {},
              child: Icon(Icons.favorite_border), */
                        )
                  : SpeedDial(
                      animatedIcon: AnimatedIcons.menu_close,
                      backgroundColor: opi_cf_color_secondary,
                      foregroundColor: opi_cf_color_primary,
                      children: [
                        SpeedDialChild(
                          child: Icon(Icons.favorite_border),
                          label: 'Ajouter à mes favoris',
                          foregroundColor: opi_cf_color_secondary,
                          onTap: () {
                            AuthService(uid: user.uid)
                                .addList(product.reference);
                          },
                        ),
                        SpeedDialChild(
                            child: Icon(Icons.share),
                            label: 'Partager',
                            foregroundColor: Colors.lightBlue,
                            onTap: () async {
                              try {
                                final ByteData bytes = await rootBundle
                                    .load('assets/images/LogoOpiScan.png');
                                await WcFlutterShare.share(
                                    sharePopupTitle: 'Partager',
                                    subject:
                                        'Partager ${widget.product.name} avec un ami',
                                    text:
                                        'Salut! \n Je te suggère de consulter ce produit sur Opiscan, tu ne seras pas déçu.',
                                    mimeType: 'image/png',
                                    fileName: 'share.png',
                                    bytesOfFile: bytes.buffer.asUint8List());
                              } catch (e) {
                                print('error: $e');
                              }
                            })
                      ],
                      /* onPressed: () {},
              child: Icon(Icons.favorite_border), */
                    );
            }));
  }
}
