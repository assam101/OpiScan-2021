import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/main.dart';

/// ******* DATABSE FIREBASE CHEMIN *********/
const String opi_dbName = 'Mobile_Assam_BOUDIF';
const String opi_config = 'Config';
const String opi_drawerItems = 'items';
const String opi_dt_tableUser = 'Users';

const String opi_cf_tableTheme = 'Theme';
const String opi_cf_colorLight = 'colors';
const String opi_cf_size = 'sizes';
const String opi_cf_radius = 'radius';
const String opi_cf_fontSize = 'fontSizes';
const String opi_cf_fontWeight = 'fontWeights';
const String opi_cf_textes = 'Textes';

/// ********* DATABASE THEME *********///

///COLOR
var opi_cf_color_primary;
var opi_cf_color_secondary;
var opi_cf_color_tertiary;

///SIZE
var opi_cf_size_sm;
var opi_cf_size_md;
var opi_cf_size_lg;
var opi_cf_size_xl;
var opi_cf_size_xxl;

///TEXTES
///String titre;
String titre;
String rub1;
String rub2;
String rub3;
String rub4;
String rub5;
String rub6;
String rub7;
String insc;
String con;

///RADIUS
var opi_cf_radius_sm;
var opi_cf_radius_md;
var opi_cf_radius_lg;

/// MARGIN / PADDING
var opi_cf_marge_null;
var opi_cf_marge_xxsm;
var opi_cf_marge_xsm;
var opi_cf_marge_sm;
var opi_cf_marge_med;
var opi_cf_marge_lg;
var opi_cf_marge_xl;

/// FONTSIZE
var opi_cf_fsize_xsm;
var opi_cf_fsize_sm;
var opi_cf_fsize_med;
var opi_cf_fsize_lg;
var opi_cf_fsize_xl;
var opi_cf_fsize_customL;

///ICONS
final Icon icon_home = Icon(Icons.home);
final Icon icon_scan = Icon(Icons.qr_code_scanner);
final Icon icon_article = Icon(Icons.article);
final Icon icon_notifications = Icon(Icons.notifications);
final Icon icon_contacts = Icon(Icons.contacts);
final Icon icon_param = Icon(Icons.settings);
final Icon icon_disc = Icon(Icons.exit_to_app);
