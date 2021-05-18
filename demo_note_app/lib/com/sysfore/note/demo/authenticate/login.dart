import 'package:demo_note_app/com/sysfore/note/demo/authenticate/forgot.dart';
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

class LoginRoute extends CupertinoPageRoute {
  LoginRoute() : super(builder: (BuildContext context) => new Login());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();

  var _userName = "";
  var _password = "";

  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();

  var _fieldsEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.colorPrimary,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: _getUi(),
        ),
      ),
    );
  }

  Widget _getUi() {
    return Container(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
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
                child: CustomUIElements.getText(
                    20, "Login to ur Account"),
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    enabled: _fieldsEnabled,
                    keyboardType: TextInputType.text,
                    validator: (String userInput) {
                      if (userInput.isEmpty) {
                        return 'Please enter email';
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: CustomColors.colorPrimary,
                      fontSize: 16,
                    ),
                    controller: _userNameController,
                    onChanged: (value) => _updateUserName(value),
                    decoration: CustomUIElements.getEditTextInputDecoration(
                        "EmailId", "assets/images/email.png"),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    enabled: _fieldsEnabled,
                    obscureText: true,
                    obscuringCharacter: "*",
                    keyboardType: TextInputType.text,
                    validator: (String userInput) {
                      if (userInput.isEmpty) {
                        return 'Please enter password';
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: CustomColors.colorPrimary,
                      fontSize: 16,
                    ),
                    controller: _passwordController,
                    onChanged: (value) => _updatePassword(value),
                    decoration: CustomUIElements.getEditTextInputDecoration(
                        "Password", "assets/images/pass.png"),
                  ),
                  SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (_fieldsEnabled) {
                            _goToForGotPassword();
                          }
                        },
                        child: CustomUIElements.getTextColor(
                            CustomColors.colorPrimary, 14, "Forgot password?"),
                      ),
                    ],
                  ),
                  if (!_fieldsEnabled)
                    SpinKitCircle(
                      color: CustomColors.colorPrimary,
                      size: 50,
                    ),
                  if (_fieldsEnabled)
                    Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: CustomColors.colorPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _signInButtonClick();
                        },
                        child: CustomUIElements.getTextColor(
                            Colors.white, 18, "Sign In"),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signInButtonClick() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        this._fieldsEnabled = false;
      });
      await AuthenticationService.shared.signIn(
          email: _userName,
          password: _password,
          onStatusChanged: (status, message) async {
            setState(() {
              this._fieldsEnabled = true;
            });
            if (status) {
              var prefs = await SharedPreferences.getInstance();
              await prefs.setBool(PreferenceHolders.loggedId, true);
              CustomUIElements.showSnackBar(context, 'Success');
              _goToDashBoard();
            } else {
              CustomUIElements.showSnackBar(context, message);
            }
          });
    }
  }

  // Update the username to username
  void _updateUserName(String text) {
    print('_userName=>$text');
    _userName = _userNameController.text;
  }

  // Update the password to password
  void _updatePassword(String text) {
    print('_password=>$text');
    _password = _passwordController.text;
  }

  void _goToForGotPassword() async {
    Navigator.push(context, new ForGotPasswordRoute());
  }

  void _goToDashBoard() async {
    // Navigator.pushReplacement(context, new WelcomeScreenRoute());
    Navigator.pushAndRemoveUntil(
        context, new WelcomeScreenRoute(), (route) => false);
  }
}
