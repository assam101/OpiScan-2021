import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/screens/home/articles/detail_product.dart';
import 'package:flutter_app/screens/home/articles/tile_product.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:provider/provider.dart';

class ListProducts extends StatefulWidget {
  ListProducts({Key key}) : super(key: key);

  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);

    return products == null
        ? Loading()
        : ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return TileProduct(product: products[index]);
            },
          );
  }
}
