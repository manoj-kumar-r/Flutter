import 'package:flutter/material.dart';

class Examples {
  static Widget getExpanded() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: Image.asset("assets/images/test.jpg")),
        Expanded(
          flex: 6,
          child: Container(
            color: Colors.cyan,
            padding: EdgeInsets.all(20),
            child: textField("1", 10, Colors.white),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.pinkAccent,
            padding: EdgeInsets.all(20),
            child: textField("2", 10, Colors.white),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.amber,
            padding: EdgeInsets.all(20),
            child: textField("3", 10, Colors.white),
          ),
        )
      ],
    );
  }

  static Widget getColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getRow(),
        Container(
          color: Colors.amber,
          padding: EdgeInsets.all(40),
          child: textField("Three Column", 10, Colors.white),
        ),
        Container(
          color: Colors.pinkAccent,
          padding: EdgeInsets.all(30),
          child: textField("Two Column", 10, Colors.white),
        ),
        Container(
          color: Colors.cyan,
          padding: EdgeInsets.all(20),
          child: textField("One Column", 10, Colors.white),
        )
      ],
    );
  }

  static Widget getRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textField("Hello World Row", 10, Colors.grey),
        FlatButton(
          onPressed: () {},
          color: Colors.amber,
          child: textField('Click me Row', 10, Colors.white),
        ),
        Container(
          color: Colors.cyan,
          padding: EdgeInsets.all(20),
          child: textField("Inside Container Row", 10, Colors.white),
        )
      ],
    );
  }

  static Widget getContainer() {
    return Container(
      color: Colors.grey[400],
      child: textField('Hello', 20, Colors.white),
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
