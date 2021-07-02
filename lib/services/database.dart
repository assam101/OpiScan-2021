import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/models/product.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('category');

  final storage = FirebaseStorage.instance;

  Future addProduct(
      String reference,
      String scanDate,
      String name,
      String category,
      String expirationDate,
      File image,
      String location) async {
    String filePath = 'products/${DateTime.now().toString() + reference}';
    storage.ref().child(filePath).putFile(image);
    return await productCollection.doc(reference).set({
      'reference': reference,
      'scanDate': scanDate,
      'name': name,
      'category': category,
      'expirationDate': expirationDate,
      'image': filePath,
      'location': location
    });
  }

  Future getImagePath(String pathImage) async {
    try {
      print('path : $pathImage');
      return await storage.ref().child(pathImage).getDownloadURL();
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteProduct(String reference) async {
    try {
      return await productCollection.doc(reference).delete();
    } catch (e) {
      return e.toString();
    }
  }

  // product list from snapshot
  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((p) => Product(
            reference: p['reference'] ?? '',
            scanDate: p['scanDate'] ?? '',
            name: p['name'] ?? '',
            category: p['category'] ?? '',
            image: p['image'] ?? '',
            expirationDate: p['expirationDate'] ?? '',
            location: p['location'] ?? ''))
        .toList();
  }

  // get products stream
  Stream<List<Product>> get products {
    return productCollection.snapshots().map(_productListFromSnapshot);
  }

  //favoris
  Stream<Product> get productsFavoris {
    return productCollection.doc(this.uid).snapshots().map(_productFavoris);
  }

  Product _productFavoris(DocumentSnapshot snapshot) {
    return Product(
      reference: snapshot['reference'] ?? '',
      scanDate: snapshot['scanDate'] ?? '',
      name: snapshot['name'] ?? '',
      category: snapshot['category'] ?? '',
      image: snapshot['image'] ?? '',
      expirationDate: snapshot['expirationDate'] ?? '',
    );
  }

  Future addCategory(String name) async {
    return await categoryCollection.doc(name).set({
      'name': name,
      'nbProducts': 0,
    });
  }

  List<Category> _categoryListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((c) => Category(
              name: c['name'] ?? '',
              nbProducts: c['nbProducts'] ?? 0,
            ))
        .toList();
  }

  Stream<List<Category>> get categories {
    return categoryCollection.snapshots().map(_categoryListFromSnapshot);
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
