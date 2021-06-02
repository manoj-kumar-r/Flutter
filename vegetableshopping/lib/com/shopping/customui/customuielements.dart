import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

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

  static Widget getTextAC(
      TextAlign align, Color color, double fontSize, String text,
      {bool isBold = true}) {
    var fontFamily = (isBold) ? "OpenSansBold" : "OpenSansRegular";
    return Text(
      text,
      maxLines: 2,
      textAlign: align,
      style: TextStyle(
          decoration: TextDecoration.none,
          color: color,
          fontSize: fontSize,
          fontFamily: fontFamily,
          overflow: TextOverflow.ellipsis,
          fontWeight: (isBold) ? FontWeight.bold : FontWeight.normal),
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
      String text, String imagePath,
      {IconData icon = Icons.arrow_back_rounded}) {
    return InputDecoration(
      prefixIcon: (imagePath.isNotEmpty)
          ? Image(
              width: 25,
              height: 25,
              image: AssetImage(imagePath),
            )
          : Icon(icon),
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
      errorStyle: const TextStyle(
        color: Colors.redAccent,
        fontSize: 16,
      ),
    );
  }

  static void showLoadingAlertDialog(BuildContext context, String title) {
    AlertDialog alert = AlertDialog(
      content: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SpinKitCircle(
            color: CustomColors.colorPrimary,
            size: 50,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: getTextColor(CustomColors.colorPrimary, 15, title)),
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

  static void showSnackBar(BuildContext context, String message,
      {Color color = Colors.white}) {
    var snackBar = SnackBar(content: getTextColor(color, 15, message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget createDrawerBodyItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.black45,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
