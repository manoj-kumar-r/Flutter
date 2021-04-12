import 'dart:convert';

import 'package:bajajdt/com/bajaj/dnt/custom/CustomUIElements.dart';
import 'package:bajajdt/com/bajaj/dnt/models/ApiModel.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/AppConstants.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/CustomApi.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/CustomColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';

class LanguageRoute extends CupertinoPageRoute {
  LanguageRoute()
      : super(builder: (BuildContext context) => new LanguageSelectionPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new LanguageSelectionPage(),
    );
  }
}

class LanguageSelectionPage extends StatefulWidget {
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  var _languageList = List<Language>();
  Future<MasterResponse> _masterResponse;

  @override
  void initState() {
    super.initState();
    _languageList = List<Language>();
    _masterResponse = CustomApi.fetchLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: CustomUIElements.getBg(),
        child: getContent(),
      ),
    );
  }

  Widget getContent() {
    return Column(
      verticalDirection: VerticalDirection.down,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 140),
            child: Text(
              "Select Language To Proceed",
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 1,
                fontFamily: 'OpenSans',
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
        FutureBuilder<MasterResponse>(
            future: _masterResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data.responseStatus != null &&
                  snapshot.data.responseStatus == "Pass") {
                _languageList = List<Language>();
                _languageList.addAll(snapshot.data.language);

                if (snapshot.data.country != null &&
                    snapshot.data.country.length > 0) {
                  insertToPreference(snapshot.data.country);
                }

                return getListView();
              } else if (snapshot.hasError) {
                var message = "";
                if (snapshot.data != null &&
                    snapshot.data.responseStatus != null &&
                    snapshot.data.responseStatus == "false") {
                  message = snapshot.data.errorMessage.toString();
                } else {
                  print(snapshot.error);
                  message = "${snapshot.error}";
                }
                return _getErrorMessage(message);
              }
              return Center(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ],
    );
  }

  Widget getListView() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 50, right: 50),
        child: ListView.builder(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          scrollDirection: Axis.vertical,
          itemCount: _languageList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Center(
                  child: Text(
                    this._languageList[index].languageText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 18,
                      letterSpacing: 1,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  _navigateToLoginScreen(this._languageList[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getErrorMessage(String message) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(left: 40, right: 40),
        child: Column(
          verticalDirection: VerticalDirection.down,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                "$message",
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 23,
                  letterSpacing: 1,
                  fontFamily: 'OpenSans',
                ),
                textDirection: TextDirection.ltr,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: CustomColors.colorAccent,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Retry',
                  textScaleFactor: 1.5,
                ),
              ),
              onPressed: () => _onRetryClicked(),
            ),
          ],
        ),
      ),
    );
  }

  void _onRetryClicked() async {
    setState(() {
      _masterResponse = null;
      _masterResponse = CustomApi.fetchLanguage();
    });
  }

  void _navigateToLoginScreen(Language language) async {
    print(language.toString());
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        PreferenceHolders.LANGUAGE_ID, language.languageId.toString());
    await prefs.setString(
        PreferenceHolders.LANGUAGE_PREF, language.languageCode);
    Navigator.pushReplacement(context, new LoginRoute());
  }

  Future<void> insertToPreference(List<Country> countryList) async {
    var json = jsonEncode(countryList.map((e) => e.toJson()).toList());
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferenceHolders.COUNTRY_LIST, json.toString());
  }
}
