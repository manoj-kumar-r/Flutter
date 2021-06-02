import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vegetableshopping/com/shopping/activation/login.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

import 'activated/dashboard.dart';
import 'customui/customuielements.dart';

class SplashRoute extends CupertinoPageRoute {
  SplashRoute() : super(builder: (BuildContext context) => const SplashPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var _visible = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      _validateAccount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _getUi(),
      ),
    );
  }

  Widget _getUi() {
    var imageHeight = MediaQuery.of(context).size.height / 2.2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image(
          height: imageHeight,
          fit: BoxFit.contain,
          image: const AssetImage("assets/images/farmer.jpg"),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: CustomUIElements.getTextAC(
              TextAlign.start,
              CustomColors.titleDarkColor,
              30,
              "Order your favorites vegetable."),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: CustomUIElements.getTextAC(
                TextAlign.start,
                CustomColors.titleLightColor,
                15,
                "Eat fresh vegetables and be healthy...")),
        const SizedBox(
          height: 10,
        ),
        if (!_visible)
          SpinKitCircle(
            color: CustomColors.titleDarkColor,
            size: 50,
          ),
        const SizedBox(
          height: 15,
        ),
        if (_visible)
          Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: _nextButton(),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: _loginButton(),
              ),
            ],
          ),
      ],
    );
  }

  _nextButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 100,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: CustomColors.colorPrimary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
            ),
          ),
          child: TextButton(
            onPressed: _nextButtonClick,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: CustomColors.titleDarkColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomUIElements.getTextColor(
                    CustomColors.titleDarkColor, 18, "Skip"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _loginButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: CustomColors.colorPrimary,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),
          child: TextButton(
            onPressed: _loginButtonClick,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: CustomColors.titleDarkColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                CustomUIElements.getTextColor(
                    CustomColors.titleDarkColor, 18, "Login"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _nextButtonClick() {
    Navigator.pushAndRemoveUntil(context, DashBoardRoute(), (route) => false);
  }

  _loginButtonClick() {
    Navigator.push(context, LoginRoute());
  }

  _validateAccount() {
    setState(() {
      _visible = true;
    });
  }
}
