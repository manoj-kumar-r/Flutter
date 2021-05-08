import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardRoute extends CupertinoPageRoute {
  DashBoardRoute() : super(builder: (BuildContext context) => new DashBoard());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new DashBoard(),
    );
  }
}

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {},
          )
        ],
      ),
    );
  }
}
