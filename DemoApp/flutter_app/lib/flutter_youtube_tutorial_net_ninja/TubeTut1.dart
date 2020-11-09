import 'package:flutter/material.dart';

import 'custom_widgets/CustomWidgets.dart';

//Material App allows to design an app with material components
class TubeTutorial1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Example());
  }
}

//Scaffold allows to give a layout to the design
//State Less Widget cannot change over time
//State Ful can change over time layout or data inside it can be changed
class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Examples.textField('My First App', 20, Colors.white),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Examples.getExpanded(),
      floatingActionButton: FloatingActionButton(
        child: Examples.textField('Click Me', 10, Colors.white),
        onPressed: () {},
        backgroundColor: Colors.red[600],
      ),
    );
  }
}
