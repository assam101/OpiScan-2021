import 'package:flutter/material.dart';
import 'package:flutter_app/shared/databaseVar.dart';

final textInputDecoration = InputDecoration(
    fillColor: opi_cf_color_primary,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: opi_cf_color_tertiary, width: 2.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: opi_cf_color_secondary, width: 2.0)));

/* const opi_cf_color_primary = const Color(0xffffffff);
const opi_cf_color_secondary = const Color(0xffD53722);
const opi_cf_color_tertiary = const Color(0xffE5E5E5); */
const textStyleDecoration = TextStyle(fontSize: 18);
final textFocusStyleDecoration = TextStyle(
    fontSize: 18, fontWeight: FontWeight.bold, color: opi_cf_color_secondary);
