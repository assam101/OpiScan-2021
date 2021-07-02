/* import 'package:flutter/material.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/screens/home/articles/detail_product.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/left_right_align.dart';
import 'package:flutter_app/shared/databaseVar.dart';

class TileCategory extends StatelessWidget {
  final Category category;
  TileCategory({this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ListTile(
        title: LeftRightAlign(
          left: Text(
            category.name,
            style: TextStyle(color: Colors.black),
          ),
          right: Text(
            '(${category.nbProducts})',
            style: TextStyle(color: opi_cf_color_tertiary),
          ),
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text(category.name),
                    content: Text('${category.nbProducts} produits'),
                    actions: [
                      TextButton(onPressed: () {}, child: Text('Modifier')),
                      TextButton(onPressed: () {}, child: Text('Supprimer')),
                    ],
                  ));
        },
      ),
    );
  }
}
 */
