import 'package:flutter/material.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/databaseVar.dart';

class CustomButton extends StatelessWidget {
  Function onPressed = () {};
  String txt = '';
  CustomButton({this.onPressed, this.txt});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xffD53722)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.black)))),
        child: Text(
          txt,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 24.0,
              color: Color(0xffffffff)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
