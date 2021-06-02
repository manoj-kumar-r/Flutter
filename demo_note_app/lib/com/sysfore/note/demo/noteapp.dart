import 'package:flutter/material.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/customcolor.dart';
import 'package:demo_note_app/com/sysfore/note/demo/authenticate/splash.dart';

class NoteApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: CustomColors.colorPrimary,
        primaryColorDark: CustomColors.colorPrimaryDark,
        accentColor: CustomColors.colorAccent,
      ),
      home: SplashPage(),
    );
  }
}
