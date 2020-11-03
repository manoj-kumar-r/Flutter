import 'package:flutter/material.dart';

class TubeTutorial1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TubeTutorial1',
      home: TubeTutorial1LaunchMainClass(),
      theme: ThemeData(primaryColor: Colors.blueAccent),
    );
  }
}

class TubeTutorial1LaunchMainClass extends StatefulWidget {
  @override
  _TubeTutorial1LaunchMainClassLaunchMainClassState createState() => _TubeTutorial1LaunchMainClassLaunchMainClassState();
}

class _TubeTutorial1LaunchMainClassLaunchMainClassState extends State<TubeTutorial1LaunchMainClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TubeTutorial1"),
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
