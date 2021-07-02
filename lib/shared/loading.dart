import 'package:flutter/material.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/databaseVar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: opi_cf_color_primary,
      child: Center(
        child: SpinKitChasingDots(
          color: opi_cf_color_secondary,
          size: 50.0,
        ),
      ),
    );
  }
}
