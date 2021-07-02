import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'databaseVar.dart';

class MyTheme {
  /// ********** CALL DATABASE TO GET THEME ELEMENTS ************ ///
  void callColor(DatabaseReference db) {
    db
        .child(opi_dbName)
        .child(opi_config)
        .child(opi_cf_tableTheme)
        .child(opi_cf_colorLight)
        .once()
        .then((DataSnapshot items) {
      Map<dynamic, dynamic> colors = items.value;
      opi_cf_color_primary = Color(int.parse(colors['primaryColor']));
      opi_cf_color_secondary = Color(int.parse(colors['secondaryColor']));
      opi_cf_color_tertiary = Color(int.parse(colors['tertiaryColor']));
      print(opi_cf_color_primary);
    });
  }

  void callSize(DatabaseReference db) {
    db.child(opi_dbName)
      ..child(opi_config)
          .child(opi_cf_tableTheme)
          .child(opi_cf_size)
          .once()
          .then((DataSnapshot items) {
        Map<dynamic, dynamic> sizes = items.value;
        opi_cf_size_sm = sizes['sm'];
        opi_cf_size_md = sizes['md'];
        opi_cf_size_lg = sizes['lg'];
        opi_cf_size_xl = sizes['xl'];
        opi_cf_size_xxl = sizes['xxl'];
      });
  }

  void callRadius(DatabaseReference db) {
    db
        .child(opi_dbName)
        .child(opi_config)
        .child(opi_cf_tableTheme)
        .child(opi_cf_radius)
        .once()
        .then((DataSnapshot items) {
      Map<dynamic, dynamic> radius = items.value;
      opi_cf_radius_sm = radius['sm'];
      opi_cf_radius_md = radius['md'];
      opi_cf_radius_lg = radius['lg'];
    });
  }

  void callMarginPadding(DatabaseReference db) {
    db
        .child(opi_dbName)
        .child(opi_config)
        .child(opi_cf_tableTheme)
        .child(opi_cf_radius)
        .once()
        .then((DataSnapshot items) {
      Map<dynamic, dynamic> marg = items.value;
      opi_cf_marge_null = marg['null'];
      opi_cf_marge_xxsm = marg['xxsm'];
      opi_cf_marge_xsm = marg['xsm'];
      opi_cf_marge_sm = marg['sm'];
      opi_cf_marge_med = marg['med'];
      opi_cf_marge_lg = marg['lg'];
      opi_cf_marge_xl = marg['xl'];
    });
  }

  void callFontSize(DatabaseReference db) {
    db
        .child(opi_dbName)
        .child(opi_config)
        .child(opi_cf_tableTheme)
        .child(opi_cf_fontSize)
        .once()
        .then((DataSnapshot items) {
      Map<dynamic, dynamic> fSize = items.value;
      opi_cf_fsize_xsm = double.parse(fSize['xsm']);
      opi_cf_fsize_sm = double.parse(fSize['sm']);
      opi_cf_fsize_med = double.parse(fSize['med']);
      opi_cf_fsize_lg = double.parse(fSize['lg']);
      opi_cf_fsize_xl = double.parse(fSize['xl']);
    });
  }

  void callTxt(DatabaseReference db) {
    db
        .child(opi_dbName)
        .child(opi_config)
        .child(opi_cf_textes)
        .once()
        .then((DataSnapshot items) {
      Map<dynamic, dynamic> texts = items.value;
      titre = texts['launch'];
      rub1 = texts['favoris'];
      rub2 = texts['addProduct'];
      rub3 = texts['article'];
      rub4 = texts['notifications'];
      rub5 = texts['pseudo'];
      rub6 = texts['param'];
      rub7 = texts['logout'];
      insc = texts['inscirption'];
      con = texts['log'];
      print(titre);
    });
  }

  // fonctions non fonctionnel
  /*void callImage(DatabaseReference db){
    db.child(opi_dbName).child(opi_config).child(opi_cf_textes).once().then((DataSnapshot items){
      Map<dynamic, dynamic> image = items.value;
      opi_cf_path_logoviolet = image['logoViolet'];
      opi_cf_path_logoblc = image['logoBlanc'];
    });
  }*/
  /*void callFontWeight(DatabaseReference db){
    db.child(opi_dbName).child(opi_config).child(opi_cf_tableTheme).child(opi_cf_fontWeight).once().then((DataSnapshot items){
      Map<dynamic, dynamic> fweight = items.value;
      opi_cf_fweight_light = fweight['light'];
      opi_cf_fweight_normal = fweight['normal'];
      opi_cf_fweight_heading = fweight['heading'];
      opi_cf_fweight_bold = fweight['bold'];
      print(opi_cf_fweight_bold.runtimeType);
    });
  }*/
}
