import 'package:demo_note_app/com/sysfore/note/demo/utils/customcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomUIElements {
  static Decoration getBg() {
    return BoxDecoration(
      color: CustomColors.colorPrimary,
    );
  }

  static Widget getText(double fontSize, String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        decoration: TextDecoration.none,
        color: Colors.white,
        fontSize: fontSize,
        fontFamily: 'OpenSansBold',
      ),
      textDirection: TextDirection.ltr,
    );
  }

  static Widget getTextColor(Color color, double fontSize, String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        decoration: TextDecoration.none,
        color: color,
        fontSize: fontSize,
        fontFamily: 'OpenSansBold',
      ),
      textDirection: TextDirection.ltr,
    );
  }

  static Widget getImageContainer(String path, EdgeInsets edgeInsets) {
    return Container(
      margin: edgeInsets,
      child: Image(
        width: 120,
        height: 150,
        image: AssetImage(
          path,
        ),
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
        fontSize: 16,
        color: CustomColors.colorPrimary,
        fontFamily: 'OpenSansBold',
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.colorPrimary,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.colorPrimary,
        ),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.colorPrimary,
        ),
      ),
      errorStyle: TextStyle(
        color: Colors.redAccent,
        fontSize: 16,
      ),
    );
  }

  static void showLoadingAlertDialog(BuildContext context, String title) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SpinKitCircle(
            color: CustomColors.colorPrimary,
            size: 50,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(child: getTextColor(CustomColors.colorAccent, 15, title)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showSnackBar(BuildContext context, String message,{Color color = Colors.white}) {
    var snackBar = SnackBar(content: getTextColor(color, 15, message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
