import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vegetableshopping/com/shopping/customui/custom_textfield.dart';
import 'package:vegetableshopping/com/shopping/customui/customuielements.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

class LoginView extends StatefulWidget {
  final void Function(bool) callback;

  const LoginView({Key? key, required this.callback}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState(callback);
}

class _LoginViewState extends State<LoginView> {
  final void Function(bool) _callback;
  final _loginFormKey = GlobalKey<FormState>();
  final _loginUserNameController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  var _loginFieldsEnabled = true;

  var _userName = "";
  var _password = "";

  _LoginViewState(this._callback);

  @override
  Widget build(BuildContext context) {
    return _loginUi();
  }

  Widget _loginUi() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _loginFormKey,
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomUIElements.getTextAC(TextAlign.start,
                  CustomColors.titleDarkColor, 15, "Login To Your Account"),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'Username',
                hintText: 'Email/Phone number',
                iconData: Icons.email,
                validatorText: 'Please enter Email/Phone number',
                textEditingController: _loginUserNameController,
                enabled: _loginFieldsEnabled,
                onChanged: _updateUserName,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'Password',
                hintText: 'Password',
                iconData: Icons.lock,
                validatorText: 'Please enter password',
                textEditingController: _loginPasswordController,
                enabled: _loginFieldsEnabled,
                obscureText: true,
                obscuringCharacter: "*",
                keyBoardType: TextInputType.text,
                onChanged: _updatePassword,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (_loginFieldsEnabled) ? _forGotClicked : null,
                    child: CustomUIElements.getTextColor(
                        CustomColors.titleDarkColor, 14, "Forgot password?"),
                  ),
                ],
              ),
              if (!_loginFieldsEnabled)
                SpinKitCircle(color: CustomColors.colorPrimary, size: 50),
              if (_loginFieldsEnabled)
                Container(
                  decoration: BoxDecoration(
                    color: CustomColors.colorPrimary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _loginClicked();
                    },
                    child: CustomUIElements.getTextColor(
                        Colors.white, 18, "Sign In"),
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomUIElements.getTextAC(
                      TextAlign.start,
                      CustomColors.titleDarkColor,
                      14,
                      "Don't have an account yet?"),
                  TextButton(
                    onPressed: (_loginFieldsEnabled) ? _onSignUpClicked : null,
                    child: CustomUIElements.getTextColor(
                        CustomColors.colorPrimary, 14, "Sign Up!"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _onSignUpClicked() {
    _callback(true);
  }

  // Update the username to username
  void _updateUserName(String text) {
    _userName = _loginUserNameController.text;
  }

  // Update the password to password
  void _updatePassword(String text) {
    _password = _loginPasswordController.text;
  }

  _loginClicked() {
    setState(() {
      _loginFieldsEnabled = false;
    });
  }

  _forGotClicked() {}
}
