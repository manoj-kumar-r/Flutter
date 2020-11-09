import 'package:flutter/material.dart';

class ExploringUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exploring UI Widgets',
      home: Home(),
    );
  }
}

//Container are like Div elements in the web
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exploring UI Widget'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
            left: 35,
            top: 50,
            right: 35,
          ),
          alignment: Alignment.center,
          color: Colors.deepPurple[200],
          child: Text(
            'Test',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}
