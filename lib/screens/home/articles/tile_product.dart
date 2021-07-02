import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/home/articles/articles.dart';
import 'package:flutter_app/screens/home/articles/detail_product.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:provider/provider.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class TileProduct extends StatefulWidget {
  final Product product;
  TileProduct({this.product});

  @override
  _TileProductState createState() => _TileProductState();
}

class _TileProductState extends State<TileProduct> {
  bool _visible;
  @override
  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('DD/MM/yyyy');
    DateTime expDate = format.parse(widget.product.expirationDate);
    DateTime now = DateTime.now();
    int nbDays = daysBetween(now, expDate);
    final user = Provider.of<UserM>(context);
    AuthService auth = new AuthService();

    if (user.categorie != 'Professionnel') {
      setState(() {
        _visible = false;
      });
    } else {
      setState(() {
        _visible = true;
      });
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                if (nbDays > 15)
                  Container(
                    height: 10.0,
                    width: 10.0,
                    decoration: new BoxDecoration(
                        color: Colors.lightGreen, shape: BoxShape.circle),
                  )
                else if (nbDays > 0)
                  Container(
                    height: 10.0,
                    width: 10.0,
                    decoration: new BoxDecoration(
                        color: Colors.orange, shape: BoxShape.circle),
                  )
                else
                  Container(
                    height: 10.0,
                    width: 10.0,
                    decoration: new BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ),
                SizedBox(
                  width: 5.0,
                ),
                if (nbDays > 0)
                  Text('Il reste $nbDays jours')
                else
                  Text('Périmé'),
              ],
            ),
          ),
          Card(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white24)),
            margin: EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 0.0),
            child: ListTile(
              leading: FutureBuilder(
                  future: DatabaseService().getImagePath(widget.product.image),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Image(
                            image: NetworkImage(snapshot.data),
                          )
                        : Image(image: AssetImage('assets/images/NoImage.jpg'));
                  }),
              title: Text(widget.product.name),
              subtitle: Text(widget.product.expirationDate),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                StreamBuilder<List>(
                    stream: AuthService(uid: user.uid).getListFavoris(),
                    builder: (context, snapshot) {
                      // if (!snapshot.hasData) return Text('Loading');
                      return snapshot.hasData
                          ? !snapshot.data.contains(widget.product.reference)
                              ? IconButton(
                                  icon: Icon(Icons.favorite_border,
                                      color: Colors.red),
                                  onPressed: () {
                                    AuthService(uid: user.uid)
                                        .addList(widget.product.reference);
                                  })
                              : IconButton(
                                  icon: Icon(Icons.favorite,
                                      color: Colors.red[400]),
                                  onPressed: () {
                                    AuthService(uid: user.uid)
                                        .removeList(widget.product.reference);
                                  })
                          : IconButton(
                              icon: Icon(Icons.favorite_border,
                                  color: Colors.red),
                              onPressed: () {
                                AuthService(uid: user.uid)
                                    .addList(widget.product.reference);
                              });
                    }),
                IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.lightBlue[700],
                    ),
                    onPressed: () async {
                      try {
                        final ByteData bytes = await rootBundle
                            .load('assets/images/LogoOpiScan.png');
                        await WcFlutterShare.share(
                            sharePopupTitle:
                                'Partager ${widget.product.name} avec un ami',
                            subject:
                                'Partager ${widget.product.name} avec un ami',
                            text:
                                'Salut! \n Je te suggère de consulter ce produit sur Opiscan, tu ne seras pas déçu!',
                            mimeType: 'image/png',
                            fileName: 'share.png',
                            bytesOfFile: bytes.buffer.asUint8List());
                      } catch (e) {
                        print('error: $e');
                      }
                    }),
                Visibility(
                  visible: _visible,
                  child: IconButton(
                      icon: Icon(Icons.delete),
                      color: opi_cf_color_secondary,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                    title: Text('Supprimer le produit'),
                                    content: Text(
                                        'Voulez-vous vraiment supprimer ${widget.product.name} ?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Non')),
                                      TextButton(
                                          onPressed: () async {
                                            await DatabaseService()
                                                .deleteProduct(
                                                    widget.product.name);
                                            if (widget.product != null) {
                                              print('produit non supprimé');
                                            } else {
                                              print('supprimé');
                                            }
                                            Navigator.of(context).pop();
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            Articles()));
                                          },
                                          child: Text('Oui'))
                                    ]));
                      }),
                ),
              ]),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailProduct(widget.product)));
              },
            ),
          ),
        ],
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return to.difference(from).inDays;
  }
}
