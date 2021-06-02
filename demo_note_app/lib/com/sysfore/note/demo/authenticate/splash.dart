import 'dart:async';
import 'dart:developer';

import 'package:demo_note_app/com/sysfore/note/demo/authenticate/register.dart';
import 'package:demo_note_app/com/sysfore/note/demo/authenticated/dashboard.dart';
import 'package:demo_note_app/com/sysfore/note/demo/authenticated/welcomescreen.dart';
import 'package:demo_note_app/com/sysfore/note/demo/customui/customuielements.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/constants.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/customcolor.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/fireauth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class SplashRoute extends CupertinoPageRoute {
  SplashRoute() : super(builder: (BuildContext context) => new SplashPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  var _visible = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    log("&&&&&&&&&&&&&&&&");
    Timer(Duration(seconds: 4), () {
      _validateAccount();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.colorPrimary,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: getUi(),
      ),
    );
  }

  Widget getUi() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Image(
                height: 100,
                width: 100,
                image: AssetImage("assets/images/note.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 20, right: 15),
              child: CustomUIElements.getText(30, "Note App"),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 20, right: 15),
              child:
                  CustomUIElements.getText(20, "Never Forget Anything Again."),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomUIElements.getImageContainer(
                "assets/images/people.jpg", EdgeInsets.all(30)),
          ],
        ),
        if (!_visible)
          SpinKitCircle(
            color: Colors.white,
            size: 50,
          ),
        if (_visible)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 40, top: 20, right: 40),
                padding: EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    _goToLogin();
                  },
                  child: CustomUIElements.getTextColor(
                      CustomColors.colorPrimaryDark, 18, "Sign In"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),
                padding: EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    _goToRegister();
                  },
                  child: CustomUIElements.getTextColor(
                      CustomColors.colorPrimary, 18, "Sign Up"),
                ),
              ),
            ],
          ),
      ],
    );
  }

  void _validateAccount() async {
    var prefs = await SharedPreferences.getInstance();
    var loggedIn = prefs.getBool(PreferenceHolders.loggedId);
    var welcomeShown = prefs.getBool(PreferenceHolders.welcomeShown);
    if (loggedIn != null && loggedIn) {
      if (welcomeShown != null && welcomeShown) {
        _goToDashBoard();
      } else {
        _goToWelcome();
      }
    } else {
      await AuthenticationService.shared
          .signOut(onStatusChanged: (status, message) {});
      setState(() {
        _visible = true;
      });
    }
  }

  void _goToWelcome() async {
    Navigator.pushAndRemoveUntil(
        context, new WelcomeScreenRoute(), (route) => false);
    // Navigator.popUntil(context, (_) => !Navigator.canPop(context));
    // Navigator.pushReplacement(context, new WelcomeScreenRoute());
  }

  void _goToDashBoard() async {
    // Navigator.pushReplacement(context, new DashBoardRoute());
    Navigator.pushAndRemoveUntil(
        context, new DashBoardRoute(), (route) => false);
  }

  void _goToLogin() async {
    Navigator.push(context, new LoginRoute());
  }

  void _goToRegister() async {
    Navigator.push(context, new RegisterRoute());
  }
}
