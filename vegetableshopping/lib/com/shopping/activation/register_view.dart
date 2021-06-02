import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vegetableshopping/com/shopping/customui/custom_textfield.dart';
import 'package:vegetableshopping/com/shopping/customui/customuielements.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

class RegistrationView extends StatefulWidget {
  final void Function(bool) callback;

  const RegistrationView({Key? key, required this.callback}) : super(key: key);

  @override
  _RegistrationViewState createState() => _RegistrationViewState(callback);
}

class _RegistrationViewState extends State<RegistrationView> {
  final void Function(bool) _callback;
  final _registerFormKey = GlobalKey<FormState>();
  var _registrationFieldsEnabled = true;

  final _registerFirstNameController = TextEditingController();
  final _registerLastNameController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerPasswordReEnterController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPhoneController = TextEditingController();

  _RegistrationViewState(this._callback);

  @override
  Widget build(BuildContext context) {
    return _registerUi();
  }

  Widget _registerUi() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _registerFormKey,
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomUIElements.getTextAC(TextAlign.start,
                  CustomColors.titleDarkColor, 15, "Register For New Account"),
              const SizedBox(height: 20),
              CustomUIElements.getTextAC(
                  TextAlign.start,
                  CustomColors.titleLightColor,
                  12,
                  "Let's get you all set up so you can verify your personal account and begin setting up your profile."),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      label: 'First Name',
                      hintText: 'First Name',
                      validatorText: 'Please enter First Name',
                      textEditingController: _registerFirstNameController,
                      enabled: _registrationFieldsEnabled,
                      onChanged: _updateFirstName,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      label: 'Last Name',
                      hintText: 'Last Name',
                      validatorText: 'Please enter Last Name',
                      textEditingController: _registerLastNameController,
                      enabled: _registrationFieldsEnabled,
                      onChanged: _updateLastName,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      label: 'Password',
                      hintText: 'Password',
                      validatorText: 'Please enter password',
                      textEditingController: _registerPasswordController,
                      enabled: _registrationFieldsEnabled,
                      obscureText: true,
                      obscuringCharacter: "*",
                      keyBoardType: TextInputType.text,
                      onChanged: _updatePassword,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      label: 'Confirm Password',
                      hintText: 'Confirm Password',
                      validatorText: 'Please enter confirm password',
                      textEditingController: _registerPasswordReEnterController,
                      enabled: _registrationFieldsEnabled,
                      obscureText: true,
                      obscuringCharacter: "*",
                      keyBoardType: TextInputType.text,
                      onChanged: _updatePasswordConfirm,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      label: 'Phone',
                      hintText: 'Phone Number',
                      validatorText: 'Please enter Phone Number',
                      textEditingController: _registerPhoneController,
                      enabled: _registrationFieldsEnabled,
                      onChanged: _updatePhoneNumber,
                      keyBoardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      label: 'Email',
                      hintText: 'Email',
                      validatorText: 'Please enter Email',
                      textEditingController: _registerEmailController,
                      enabled: _registrationFieldsEnabled,
                      onChanged: _updateEmail,
                      keyBoardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (!_registrationFieldsEnabled)
                SpinKitCircle(color: CustomColors.colorPrimary, size: 50),
              if (_registrationFieldsEnabled)
                Container(
                  decoration: BoxDecoration(
                    color: CustomColors.colorPrimary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: CustomUIElements.getTextColor(
                        Colors.white, 18, "Register"),
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomUIElements.getTextAC(TextAlign.start,
                      CustomColors.titleDarkColor, 14, "You have an account."),
                  TextButton(
                    onPressed:
                        (_registrationFieldsEnabled) ? _onLoginClicked : null,
                    child: CustomUIElements.getTextColor(
                        CustomColors.colorPrimary, 14, "Login!"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _onLoginClicked() {
    _callback(false);
  }

  void _updatePassword(String value) {}

  void _updateFirstName(String value) {}

  void _updateLastName(String value) {}

  void _updatePasswordConfirm(String value) {}

  void _updatePhoneNumber(String value) {}

  void _updateEmail(String value) {}
}
