import 'package:flutter/material.dart';

import 'com/demo/web/nav_drawer.dart';

void main() {
  runApp(const DemoWebApp());
}

class DemoWebApp extends StatelessWidget {
  const DemoWebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        primaryColorDark: Colors.blue,
        accentColor: Colors.white,
      ),
      home: NavDrawer(),
    );
  }
}
