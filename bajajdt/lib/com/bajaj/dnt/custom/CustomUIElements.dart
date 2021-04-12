import 'package:bajajdt/com/bajaj/dnt/utils/CustomColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomUIElements {
  static Decoration getBg() {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/bgs_login.9.png"),
        fit: BoxFit.fill,
      ),
    );
  }

  static InputDecoration getEditTextInputDecoration(
      String text, String imagePath) {
    return InputDecoration(
      prefixIcon: Image(
        width: 25,
        height: 25,
        image: AssetImage(
          imagePath,
        ),
      ),
      labelText: text,
      labelStyle: TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontFamily: 'OpenSans',
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.colorAccent,
        ),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      errorStyle: TextStyle(
        color: Colors.redAccent,
        fontSize: 15,
      ),
    );
  }

  static Widget getText15(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        decoration: TextDecoration.none,
        color: Colors.white,
        fontSize: 15,
        fontFamily: 'OpenSans',
      ),
      textDirection: TextDirection.ltr,
    );
  }

  static Widget getText13(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        decoration: TextDecoration.none,
        color: Colors.white,
        fontSize: 13,
        fontFamily: 'OpenSans',
      ),
      textDirection: TextDirection.ltr,
    );
  }

  static void showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
