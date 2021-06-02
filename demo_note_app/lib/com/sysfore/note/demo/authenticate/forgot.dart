import 'package:demo_note_app/com/sysfore/note/demo/customui/customuielements.dart';
import 'package:demo_note_app/com/sysfore/note/demo/utils/customcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ForGotPasswordRoute extends CupertinoPageRoute {
  ForGotPasswordRoute()
      : super(builder: (BuildContext context) => new ForGotPassword());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new ForGotPassword(),
    );
  }
}

class ForGotPassword extends StatefulWidget {
  @override
  _ForGotPasswordState createState() => _ForGotPasswordState();
}

class _ForGotPasswordState extends State<ForGotPassword> {
  var _formKey = GlobalKey<FormState>();

  var _userName = "";

  var _userNameController = TextEditingController();

  var _fieldsEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
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
                    20, "Never Forget Anything Again."),
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
                    keyboardType: TextInputType.emailAddress,
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
                    controller: _userNameController,
                    onChanged: (value) => _updateUserName(value),
                    decoration: CustomUIElements.getEditTextInputDecoration(
                        "EmailId", "assets/images/email.png"),
                  ),
                  SizedBox(
                    height: 20,
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
                          _resetButtonClick();
                        },
                        child: CustomUIElements.getTextColor(
                            Colors.white, 18, "Reset Password"),
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

  Future<void> _resetButtonClick() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print(_userName);
      setState(() {
        this._fieldsEnabled = false;
      });
    }
  }

  // Update the username to username
  void _updateUserName(String text) {
    print('_userName=>$text');
    _userName = _userNameController.text;
  }
}
