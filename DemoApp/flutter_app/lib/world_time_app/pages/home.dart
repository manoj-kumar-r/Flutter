import 'package:flutter/material.dart';

import 'choose_location.dart';
import 'loading.dart';

class WorldTimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => WorldTimeHome(),
        '/location': (context) => ChooseLocation()
      },
    );
  }
}

class WorldTimeHome extends StatefulWidget {
  @override
  _WorldTimeHomeState createState() => _WorldTimeHomeState();
}

class _WorldTimeHomeState extends State<WorldTimeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Home'),
            FlatButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/location');
              },
              icon: Icon(Icons.edit_location),
              label: Text('Edit Location'),
            )
          ],
        ),
      ),
    );
  }
}
