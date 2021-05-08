import 'dart:convert';
import 'dart:io';

import 'package:demo_note_app/com/sysfore/note/demo/authenticated/dashboard.dart';
import 'package:demo_note_app/com/sysfore/note/demo/customui/customuielements.dart';
import 'package:demo_note_app/com/sysfore/note/demo/models/user_model.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/customcolor.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/fireauth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

class RegisterRoute extends CupertinoPageRoute {
  RegisterRoute() : super(builder: (BuildContext context) => new Register());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new Register(),
    );
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _formKey = GlobalKey<FormState>();

  var _email = "";
  var _userName = "";
  var _password = "";

  var _emailController = TextEditingController();
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();

  var _fieldsEnabled = true;
  var _picker = ImagePicker();
  PickedFile _image;

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
                child: CustomUIElements.getText(20, "Register"),
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
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 15, top: 0, right: 15, bottom: 20),
                        child: CustomUIElements.getTextColor(
                            CustomColors.colorPrimary, 20, "New Account"),
                      ),
                      CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          child: Image(
                            height: 100,
                            width: 100,
                            image: AssetImage("assets/images/camera.png"),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ],
                  ),
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
                    controller: _emailController,
                    onChanged: (value) => _updateEmail(value),
                    decoration: CustomUIElements.getEditTextInputDecoration(
                        "EmailId", "assets/images/email.png"),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    enabled: _fieldsEnabled,
                    keyboardType: TextInputType.text,
                    validator: (String userInput) {
                      if (userInput.isEmpty) {
                        return 'Please enter User Name';
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
                        "User Name", "assets/images/user.png"),
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
                  SizedBox(height: 20),
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
                          _signUpButtonClick();
                        },
                        child: CustomUIElements.getTextColor(
                            Colors.white, 18, "Sign Up"),
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

  Future<void> _signUpButtonClick() async {
    if (_formKey.currentState.validate()) {
      if (_image == null) {
        CustomUIElements.showSnackBar(context, "Please select a profile pic",
            color: Colors.red);
      } else {
        setState(() {
          this._fieldsEnabled = false;
        });
        await AuthenticationService.shared.signUp(
            email: _email,
            password: _password,
            onStatusChanged: (status, message) {
              if (status) {
                _registerUser();
              } else {
                setState(() {
                  this._fieldsEnabled = true;
                });
                CustomUIElements.showSnackBar(context, message,
                    color: Colors.red);
              }
            });
      }
    }
  }

  Future<void> _registerUser() async {
    final bytes = File(_image.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    var userModel = UserModel(
        uid: AuthenticationService.shared.getCurrentUid(),
        userName: _userName,
        emailId: _email,
        profilePic: img64,
        timeStamp: DateTime.now());
    await AuthenticationService.shared.addUserToDB(
        userModel: userModel,
        onStatusChanged: (status, message) {
          setState(() {
            this._fieldsEnabled = true;
          });
          if (status) {
            CustomUIElements.showSnackBar(context, 'Registration Success');
            _goToDashBoard();
          } else {
            CustomUIElements.showSnackBar(context, message, color: Colors.red);
          }
        });
  }

  // Update the username to username
  void _updateEmail(String text) {
    print('_userName=>$text');
    _email = _emailController.text;
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

  void _goToDashBoard() async {
    Navigator.pushReplacement(context, new DashBoardRoute());
  }

  void _onImageButtonPressed() async {
    try {
      _image = await _picker.getImage(source: ImageSource.gallery);
    } on Exception catch (e) {
      CustomUIElements.showSnackBar(context, e.toString(), color: Colors.red);
      setState(() {
        _image = null;
      });
    }
  }
}
