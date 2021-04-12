import 'dart:convert';

import 'package:bajajdt/com/bajaj/dnt/custom/CustomUIElements.dart';
import 'package:bajajdt/com/bajaj/dnt/models/ApiModel.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/AppConstants.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/CustomColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PrivacyPage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var _countryList = List<Country>();

  var _userName = "";
  var _cityName = "";
  var _mobile = "";
  var _email = "";
  var _isCheckSelected = false;
  Country _selectedCountry;

  var _formKey = GlobalKey<FormState>();
  var _userNameController = TextEditingController();
  var _cityController = TextEditingController();
  var _mobileController = TextEditingController();
  var _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: setFields(context),
    );
  }

  Widget setFields(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgs.9.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          children: [
            CustomUIElements.getText15("BAJAJ DIAGNOSTIC & TROUBLESHOOTING"),
            SizedBox(height: 20),
            CustomUIElements.getText15("Register"),
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
            DropdownButton<Country>(
              isExpanded: true,
              hint: Container(
                margin: EdgeInsets.only(left: 10),
                child: CustomUIElements.getText13("Select Country"),
              ),
              icon: Container(
                margin: EdgeInsets.only(right: 12.0),
                child: Icon(
                  // Add this
                  Icons.keyboard_arrow_down, // Add this
                  color: Colors.white, // Add this
                  size: 25,
                ),
              ),
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'OpenSans',
              ),
              underline: Container(
                height: 1.0,
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                  ),
                )),
              ),
              value: _selectedCountry,
              items: _countryList.map(
                (item) {
                  return DropdownMenuItem<Country>(
                    value: item,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, bottom: 5),
                      child: Text(
                        item.country,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'OpenSans',
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  );
                },
              ).toList(),
              selectedItemBuilder: (BuildContext context) {
                return _countryList.map<Widget>((Country item) {
                  return Container(
                    margin: EdgeInsets.only(top: 8, left: 10),
                    child: Text(
                      item.country,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  );
                }).toList();
              },
              onChanged: (e) => _onDropDownSelected(e),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              validator: (String userInput) {
                if (userInput.isEmpty) {
                  return 'Please enter City name';
                } else {
                  return null;
                }
              },
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              controller: _cityController,
              onChanged: (value) => _updateCityName(value),
              decoration: CustomUIElements.getEditTextInputDecoration(
                  "City", "assets/images/city.png"),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (String userInput) {
                if (userInput.isEmpty) {
                  return 'Please enter Mobile number';
                } else {
                  return null;
                }
              },
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              controller: _mobileController,
              onChanged: (value) => _updateMobile(value),
              decoration: CustomUIElements.getEditTextInputDecoration(
                  "Mobile", "assets/images/ic_phone.png"),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              validator: (String userInput) {
                if (userInput.isEmpty) {
                  return 'Please enter EmailId';
                } else {
                  return null;
                }
              },
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              controller: _emailController,
              onChanged: (value) => _updateEmail(value),
              decoration: CustomUIElements.getEditTextInputDecoration(
                  "Email", "assets/images/ic_mail.png"),
            ),
            SizedBox(height: 20),
            Container(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _isCheckSelected,
                    activeColor: CustomColors.colorAccent,
                    checkColor: Colors.white,
                    tristate: false,
                    onChanged: (bool newValue) {
                      setState(() {
                        _isCheckSelected = newValue;
                      });
                    },
                  ),
                  Text(
                    "I have read and agree to the",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'OpenSans',
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                  SizedBox(width: 1),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: CustomColors.colorAccent,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _onPrivacyPolicyClicked();
                      },
                      child: Text(
                        "Privacy Policy",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'OpenSans',
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
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
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                                (states) {
                          return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16));
                        }),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomUIElements.getText13("Cancel"),
                      ),
                      onPressed: () => _onCancelClicked(context),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
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
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                                (states) {
                          return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16));
                        }),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomUIElements.getText13("Register"),
                      ),
                      onPressed: () => _onRegisterClicked(context),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getCountryData() async {
    var prefs = await SharedPreferences.getInstance();
    var parsed = jsonDecode(prefs.getString(PreferenceHolders.COUNTRY_LIST));
    print("country : $parsed");
    var allCountry =
        parsed.map<Country>((json) => Country.fromJson(json)).toList();

    var data = List<Country>();

    var selectedCountry = Country();
    selectedCountry.countryId = "-1";
    selectedCountry.country = "Select Country";
    data.add(selectedCountry);

    data.addAll(allCountry);
    setState(() {
      _selectedCountry = selectedCountry;
      _countryList = data;
    });
  }

  void _updateUserName(String newValue) {
    setState(() {
      _userName = newValue;
    });
  }

  void _onDropDownSelected(Country newValue) {
    setState(() {
      _selectedCountry = newValue;
    });
  }

  void _updateCityName(String newValue) {
    setState(() {
      _cityName = newValue;
    });
  }

  void _updateMobile(String newValue) {
    setState(() {
      _mobile = newValue;
    });
  }

  void _updateEmail(String newValue) {
    setState(() {
      _email = newValue;
    });
  }

  void _onPrivacyPolicyClicked() {
    Navigator.of(context).push(new PrivacyRoute());
  }

  void _onRegisterClicked(BuildContext context) {}

  void _onCancelClicked(BuildContext context) {
    Navigator.of(context).pop();
  }
}
