import 'package:bajajdt/com/bajaj/dnt/activated/DashboardPage.dart';
import 'package:bajajdt/com/bajaj/dnt/activation/PrivacyPage.dart';
import 'package:bajajdt/com/bajaj/dnt/activation/RegistrationPage.dart';
import 'package:bajajdt/com/bajaj/dnt/custom/CustomUIElements.dart';
import 'package:bajajdt/com/bajaj/dnt/database/Db.dart';
import 'package:bajajdt/com/bajaj/dnt/models/ApiModel.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/AppConstants.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/CustomApi.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/CustomColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRoute extends CupertinoPageRoute {
  LoginRoute() : super(builder: (BuildContext context) => new LoginPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _userName = "";
  var _password = "";

  var _formKey = GlobalKey<FormState>();
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();

  var _dataBase = DbHelper.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(decoration: CustomUIElements.getBg()),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: setFields(),
            )
          ],
        ),
      ),
    );
  }

  Widget setFields() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 130),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: CustomUIElements.getText15(
                      "BAJAJ DIAGNOSTIC & TROUBLESHOOTING"),
                ),
                SizedBox(height: 20),
                CustomUIElements.getText15("LOGIN"),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (String userInput) {
                    if (userInput.isEmpty) {
                      return 'Please enter username';
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  controller: _userNameController,
                  onChanged: (value) => _updateUserName(value),
                  decoration: CustomUIElements.getEditTextInputDecoration(
                      "User Name", "assets/images/ic_user_white.png"),
                ),
                SizedBox(height: 20),
                TextFormField(
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
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  controller: _passwordController,
                  onChanged: (value) => _updatePassword(value),
                  decoration: CustomUIElements.getEditTextInputDecoration(
                      "Password", "assets/images/ic_pass_white.png"),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        return Colors.transparent;
                      }),
                      overlayColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return CustomColors.colorPrimary;
                        }
                        return Colors.transparent;
                      }),
                      side: MaterialStateProperty.resolveWith((states) {
                        Color _borderColor;
                        if (states.contains(MaterialState.pressed)) {
                          _borderColor = CustomColors.colorAccent;
                        } else {
                          _borderColor = Colors.white;
                        }
                        return BorderSide(color: _borderColor, width: 2);
                      }),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (states) {
                        return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16));
                      }),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CustomUIElements.getText15("Login"),
                    ),
                    onPressed: () => _onLoginClicked(context),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomUIElements.getText13(
                        "By Logging in you agree to our"),
                    SizedBox(width: 2),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: CustomColors.colorAccent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _onPrivacyPolicyClicked();
                        },
                        child: CustomUIElements.getText13("Privacy Policy"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomUIElements.getText13("First time user?"),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: CustomColors.colorAccent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _onRegisterClicked();
                        },
                        child: CustomUIElements.getText13("Register"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      CustomUIElements.getText13(
                          "Powered by Bajaj Global Connect Platform"),
                      SizedBox(width: 5),
                      CustomUIElements.getText13(
                          "Developed by Sysfore Technologies Pvt. ltd.")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  void _onLoginClicked(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      showLoadingAlertDialog(context);
      var masterData = await CustomApi.loginMethod(_userName, _password);
      if (masterData != null && masterData.responseStatus == "Pass") {
        navigateToDashBoard(context, masterData);
      } else {
        CustomUIElements.showSnackBar(context, masterData.errorMessage);
        Navigator.pop(context);
      }
    }
  }

  void _onPrivacyPolicyClicked() {
    Navigator.of(context).push(new PrivacyRoute());
  }

  void _onRegisterClicked() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RegistrationPage();
      },
    );
  }

  void showLoadingAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              "Please wait while verifying your credentials...",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 13,
                fontFamily: 'OpenSans',
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> navigateToDashBoard(
      BuildContext context, MasterResponse masterResponse) async {
    for (var brand in masterResponse.brands) {
      await _dataBase.insertBrand(brand, masterResponse.userID);
    }
    var data = await _dataBase.getBrandList(0, "", masterResponse.userID);
    Navigator.pop(context);
    if (data.isNotEmpty) {
      CustomUIElements.showSnackBar(context, "Login Successful");
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString(PreferenceHolders.userId, masterResponse.userID);
      Navigator.pushReplacement(context, new DashBoardRoute());
    } else {
      CustomUIElements.showSnackBar(context, "Login Failed");
    }
  }
}
