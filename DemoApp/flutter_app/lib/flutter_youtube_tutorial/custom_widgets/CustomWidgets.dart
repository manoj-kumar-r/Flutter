import 'package:flutter/material.dart';

class CustomWidgets {
  static Widget getContainer() {
    return Container(
      color: Colors.grey[400],
      child: CustomWidgets.textField('Hello', 20, Colors.white),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
    );
  }

  static Widget getIconButton() {
    return IconButton(
      onPressed: () {
        print('You CLicked Me');
      },
      icon: Icon(
        Icons.mail,
        size: 50,
      ),
      color: Colors.lightBlue,
    );
  }

  static Widget getRaisedButtonWithIcon() {
    return RaisedButton.icon(
      onPressed: () {
        print('You CLicked Me');
      },
      icon: Icon(
        Icons.mail,
        color: Colors.white,
        size: 50,
      ),
      label: textField('Click Me ', 10, Colors.white),
      color: Colors.lightBlue,
    );
  }

  static Widget getFlatButton() {
    return RaisedButton(
      onPressed: () {
        print('You CLicked Me');
      },
      child: textField("Click Me", 20, Colors.white),
      color: Colors.lightBlue,
    );
  }

  static Widget getRaisedButton() {
    return RaisedButton(
      onPressed: () {
        print('You CLicked Me');
      },
      child: textField("Click Me", 20, Colors.white),
      color: Colors.lightBlue,
    );
  }

  static Widget getIcon() {
    return Icon(
      Icons.airport_shuttle,
      color: Colors.lightBlue,
      size: 50,
    );
  }

  //assets/images/test.jpg
  //'https://media.wired.com/photos/5a593a7ff11e325008172bc2/master/w_2560%2Cc_limit/pulsar-831502910.jpg'
  static Widget getImage(String url) {
    if (url.contains("assets")) {
      return Image.asset(url);
    } else {
      return Image.network(
          'https://media.wired.com/photos/5a593a7ff11e325008172bc2/master/w_2560%2Cc_limit/pulsar-831502910.jpg');
    }
  }

  //Text field with font as a widget
  static Widget textField(String text, double fontSize, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        color: color,
        fontFamily: 'IndieFlowerRegular',
      ),
    );
  }
}
