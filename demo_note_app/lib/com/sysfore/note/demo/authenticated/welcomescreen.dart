import 'package:demo_note_app/com/sysfore/note/demo/authenticated/dashboard.dart';
import 'package:demo_note_app/com/sysfore/note/demo/customui/customuielements.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/constants.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/customcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreenRoute extends CupertinoPageRoute {
  WelcomeScreenRoute()
      : super(builder: (BuildContext context) => new WelcomeScreen());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 80),
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image(
                      height: 70,
                      width: 70,
                      image: AssetImage("assets/images/note.png"),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomUIElements.getTextColor(
                      CustomColors.colorPrimaryDark, 28, "Notely"),
                  SizedBox(height: 20),
                  Text(
                    "Notely is a note taking application which allows you to efficiently create, edit and manage notes.\n\nIt provides a number of user-friendly features that differentiates it from other note taking applications.",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: CustomColors.colorPrimary,
                      fontSize: 20,
                      fontFamily: 'OpenSansBold',
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  _goToDashboard();
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20, bottom: 50),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: CustomColors.colorPrimary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomUIElements.getTextColor(
                          Colors.white, 18, "Lets Start"),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Go to dashboard
  void _goToDashboard() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PreferenceHolders.welcomeShown, true);
    // Navigator.pushReplacement(context, new DashBoardRoute());
    Navigator.pushAndRemoveUntil(
        context, new DashBoardRoute(), (route) => false);
  }
}
