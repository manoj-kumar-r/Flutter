import 'package:flutter/material.dart';

class MotorCycleHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCDNT',
      home: LaunchMainClass(),
      theme: ThemeData(primaryColor: Colors.blueAccent),
    );
  }
}

class LaunchMainClass extends StatefulWidget {
  @override
  _LaunchMainClassState createState() => _LaunchMainClassState();
}

class _LaunchMainClassState extends State<LaunchMainClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App Bar"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to MCDNT',
              ),
            ],
          ),
        ));
  }
}
