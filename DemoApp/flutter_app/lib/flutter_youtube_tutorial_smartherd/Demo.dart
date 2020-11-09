import 'package:flutter/material.dart';

import 'first_screen.dart';

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App Screen'),
        ),
        body: FirstScreen(),
      ),
    );
  }
}
