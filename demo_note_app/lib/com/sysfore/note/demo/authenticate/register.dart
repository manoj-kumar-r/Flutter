import 'dart:io';

import 'package:demo_note_app/com/sysfore/note/demo/authenticated/welcomescreen.dart';
import 'package:demo_note_app/com/sysfore/note/demo/customui/customuielements.dart';
import 'package:demo_note_app/com/sysfore/note/demo/models/user_model.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/constants.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/customcolor.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/fireauth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  PickedFile? _image;

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
      body: _getUi(),
    );
  }

  //region UI elements
  Widget _getUi() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: [
              _headerView(),
              _bottomView(),
            ],
          ),
        ),
      ),
    );
  }

  //Header View
  Widget _headerView() {
    return Column(
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
    );
  }

  //Bottom View
  Widget _bottomView() {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: _registrationView(),
    );
  }

  //registration View
  Widget _registrationView() {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: CustomUIElements.getTextColor(
                    CustomColors.colorPrimary, 22, "New Account"),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    _onProfilePicPressed();
                  },
                  child: _getCameraImage(),
                ),
              ),
            ],
          ),
          _emailDesign(),
          SizedBox(height: 20),
          _userDesign(),
          SizedBox(height: 20),
          _passDesign(),
          SizedBox(height: 20),
          _buttonDesign(),
        ],
      ),
    );
  }

  // Camera Image design
  Widget _getCameraImage() {
    return CircleAvatar(
      radius: 35.0,
      backgroundColor: CustomColors.colorPrimary,
      child: CircleAvatar(
        radius: 32.0,
        backgroundColor: Colors.white,
        child: _image == null
            ? Icon(
                Icons.camera_alt,
                color: CustomColors.colorPrimary,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.file(
                  File(_image!.path),
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
              ),
      ),
    );
  }

  //Email Desing
  Widget _emailDesign() {
    return TextFormField(
      enabled: _fieldsEnabled,
      keyboardType: TextInputType.text,
      validator: (String? userInput) {
        if (userInput != null && userInput.isEmpty) {
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
    );
  }

  // User name desing
  Widget _userDesign() {
    return TextFormField(
      enabled: _fieldsEnabled,
      keyboardType: TextInputType.text,
      validator: (String? userInput) {
        if (userInput != null && userInput.isEmpty) {
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
    );
  }

  // password design
  Widget _passDesign() {
    return TextFormField(
      enabled: _fieldsEnabled,
      obscureText: true,
      obscuringCharacter: "*",
      keyboardType: TextInputType.text,
      validator: (String? userInput) {
        if (userInput != null && userInput.isEmpty) {
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
    );
  }

  // button design
  Widget _buttonDesign() {
    if (_fieldsEnabled)
      return Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: CustomColors.colorPrimary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: () {
            _signUpButtonClick();
          },
          child: CustomUIElements.getTextColor(Colors.white, 18, "Sign Up"),
        ),
      );
    else
      return SpinKitCircle(
        color: CustomColors.colorPrimary,
        size: 50,
      );
  }

  //endregion UI elements

  //region UI Setters
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

  // Go to Welcome
  void _goToWelcome() async {
    // Navigator.pushReplacement(context, new WelcomeScreenRoute());
    Navigator.pushAndRemoveUntil(
        context, new WelcomeScreenRoute(), (route) => false);
  }

  // Profile pic selection
  void _onProfilePicPressed() async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _imageFromGallery();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                      _imageFromCamera();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  //camera selected
  void _imageFromCamera() async {
    try {
      var _image = await _picker.getImage(source: ImageSource.camera);
      setState(() {
        this._image = _image!;
      });
    } on Exception catch (e) {
      CustomUIElements.showSnackBar(context, e.toString(), color: Colors.red);
      setState(() {
        _image = null;
      });
    }
  }

  //gallery selected
  void _imageFromGallery() async {
    try {
      var _image = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        this._image = _image;
      });
    } on Exception catch (e) {
      CustomUIElements.showSnackBar(context, e.toString(), color: Colors.red);
      setState(() {
        _image = null;
      });
    }
  }

  //endregion UI Setters

  //region Api
  Future<void> _signUpButtonClick() async {
    if (_formKey.currentState!.validate()) {
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

  //Register user in the fire store
  Future<void> _registerUser() async {
    String name = _image!.path.split('/').last;
    await AuthenticationService.shared.uploadFile(_image!.path, name,
        onStatusChanged: (status, message) async {
      if (status) {
        var userModel = UserModel(
            uid: AuthenticationService.shared.getCurrentUid(),
            userName: _userName,
            emailId: _email,
            profilePic: message,
            timeStamp: DateTime.now());
        await AuthenticationService.shared.addUserToDB(
            userModel: userModel,
            onStatusChanged: (status, message) async {
              setState(() {
                this._fieldsEnabled = true;
              });
              if (status) {
                var prefs = await SharedPreferences.getInstance();
                await prefs.setBool(PreferenceHolders.loggedId, true);
                CustomUIElements.showSnackBar(context, 'Registration Success');
                _goToWelcome();
              } else {
                CustomUIElements.showSnackBar(context, message,
                    color: Colors.red);
              }
            });
      } else {
        await AuthenticationService.shared.signOut(
            onStatusChanged: (status, message) {
          if (status) {
            CustomUIElements.showSnackBar(context, 'Registration Failed');
          }
        });
      }
    });
  }
//endregion Api
}
