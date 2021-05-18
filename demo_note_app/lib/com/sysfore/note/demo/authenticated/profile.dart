import 'dart:async';
import 'dart:io';

import 'package:demo_note_app/com/sysfore/note/demo/customui/customuielements.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/customcolor.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/fireauth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRoute extends CupertinoPageRoute {
  ProfileRoute() : super(builder: (BuildContext context) => new Profile());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new Profile(),
    );
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var _formKey = GlobalKey<FormState>();

  var _email = "";
  var _userName = "";
  var _password = "";

  var _emailController = TextEditingController();
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();

  var _fieldsEnabled = false;
  var _picker = ImagePicker();
  PickedFile _image;
  var _profileNetworkPath = "";

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      _getProfileData();
    });
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
      appBar: _getAppBar(),
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

  Widget _getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black54),
        onPressed: () => Navigator.of(context).pop(),
      ),
      // actions: [
      //   (_fieldsEnabled)
      //       ? IconButton(
      //           icon: Icon(Icons.save, color: Colors.black54),
      //           onPressed: () => {_savedClicked()},
      //         )
      //       : IconButton(
      //           icon: Icon(Icons.edit, color: Colors.black54),
      //           onPressed: () => {_editClicked()},
      //         )
      // ],
      title: Text(
        "Profile",
        textAlign: TextAlign.start,
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.black87,
          fontSize: 20,
          fontFamily: 'OpenSansBold',
        ),
        textDirection: TextDirection.ltr,
      ),
    );
  }

  Widget _getUi() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (_fieldsEnabled) _onProfilePicPressed();
            },
            child: _getCameraImage(),
          ),
          SizedBox(height: 20),
          _emailDesign(),
          SizedBox(height: 20),
          _userDesign(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Camera Image design
  Widget _getCameraImage() {
    return CircleAvatar(
      radius: 35.0,
      backgroundColor: (_fieldsEnabled)
          ? CustomColors.colorPrimary
          : CustomColors.colorAccent,
      child: CircleAvatar(
        radius: 32.0,
        backgroundColor: Colors.white,
        child: _getImage(),
      ),
    );
  }

  Widget _getImage() {
    if (_image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.file(
          File(_image.path),
          width: 100,
          height: 100,
          fit: BoxFit.fitHeight,
        ),
      );
    }
    if (_profileNetworkPath != null && _profileNetworkPath.length > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.network(
          _profileNetworkPath,
          width: 100,
          height: 100,
          fit: BoxFit.fitHeight,
        ),
      );
    } else {
      return Icon(
        Icons.camera_alt,
        color: CustomColors.colorPrimary,
      );
    }
  }

  //Email Desing
  Widget _emailDesign() {
    return TextFormField(
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
    );
  }

  // User name desing
  Widget _userDesign() {
    return TextFormField(
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
    );
  }

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
        this._image = _image;
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

  Future<void> _getProfileData() async {
    showLoadingAlertDialog(context);
    await AuthenticationService.shared.getUserFromDB(
        uid: AuthenticationService.shared.getCurrentUid(),
        onStatusChanged: (status, userModel, message) {
          Navigator.pop(context);
          if (status) {
            setState(() {
              _emailController.text = userModel.emailId;
              _userNameController.text = userModel.userName;
              _profileNetworkPath = userModel.profilePic;
            });
          } else {
            CustomUIElements.showSnackBar(context, message);
          }
        });
  }

  void showLoadingAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircularProgressIndicator(
            backgroundColor: CustomColors.colorPrimary,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              "Please wait while fetching data...",
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

  void _editClicked() {
    setState(() {
      this._fieldsEnabled = true;
    });
  }

  void _savedClicked() {
    setState(() {
      this._fieldsEnabled = false;
    });
  }
}
