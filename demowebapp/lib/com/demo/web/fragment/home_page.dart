import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homePage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(child: Text("This is home page")));
  }
}
