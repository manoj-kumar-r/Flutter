import 'package:bajajdt/com/bajaj/dnt/activated/DashboardPage.dart';
import 'package:bajajdt/com/bajaj/dnt/activation/LanguageSelectionPage.dart';
import 'package:bajajdt/com/bajaj/dnt/activation/LoginPage.dart';
import 'package:bajajdt/com/bajaj/dnt/custom/CustomUIElements.dart';
import 'package:bajajdt/com/bajaj/dnt/database/Db.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// export PATH="$PATH:/Users/sysfore/flutter/bin"

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _autoController;
  Animation<double> _autoOffSet;

  AnimationController _bikeController;
  Animation<double> _bikeOffSet;

  AnimationController _carController;
  Animation<double> _carOffSet;

  AnimationController _logoController;
  Animation<Offset> _logoOffSet;

  bool _visible = true;

  var _dbHelper = DbHelper.instance;

  @override
  void initState() {
    super.initState();
    _logoController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _logoOffSet = Tween<Offset>(begin: Offset.zero, end: Offset(0, -1.5))
        .animate(_logoController);

    _autoController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _autoOffSet = Tween<double>(begin: 1, end: 0).animate(_autoController);
    _autoController.forward();

    _autoController.addListener(() {
      if (_autoController.isCompleted) {
        setState(() {
          _visible = false;
          _logoController.forward();
        });
      }
    });

    _bikeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _bikeOffSet = Tween<double>(begin: 1, end: 0).animate(_bikeController);
    _bikeController.forward();

    _carController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _carOffSet = Tween<double>(begin: 1, end: 0).animate(_bikeController);
    _carController.forward();

    _logoController.addListener(() {
      if (_logoController.isCompleted) {
        setState(() {
          _visible = true;
          _validateAndProceed();
        });
      }
    });
  }

  @override
  void dispose() {
    _autoController.dispose();
    _bikeController.dispose();
    _carController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: CustomUIElements.getBg(),
        child: getStackImages(),
      ),
    );
  }

  Widget getStackImages() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: _autoOffSet,
            child: _getImageContainer(
              "assets/images/newauto.9.png",
              EdgeInsets.only(left: 20, right: 20, top: 60),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: FadeTransition(
            opacity: _bikeOffSet,
            child: _getImageContainer(
              "assets/images/newbike.9.png",
              EdgeInsets.all(20),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: FadeTransition(
            opacity: _carOffSet,
            child: _getImageContainer(
              "assets/images/newauto.9.png",
              EdgeInsets.all(20),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SlideTransition(
            position: _logoOffSet,
            child: AnimatedOpacity(
              opacity: _visible ? 0.0 : 1.0,
              duration: Duration(milliseconds: 300),
              child: Container(
                height: 150,
                margin: EdgeInsets.all(20),
                child: Image(
                  height: 100,
                  image: AssetImage(
                    "assets/images/bajaj_logo.png",
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getImageContainer(String path, EdgeInsets edgeInsets) {
    return Container(
      margin: edgeInsets,
      child: Image(
        width: 100,
        height: 100,
        image: AssetImage(
          path,
        ),
      ),
    );
  }

  void _validateAndProceed() async {
    var prefs = await SharedPreferences.getInstance();
    var languageSelected = prefs.getString(PreferenceHolders.LANGUAGE_ID);
    if (languageSelected != null && languageSelected.length > 0) {
      var brandSelected = prefs.getString(PreferenceHolders.userId);
      if (brandSelected != null && brandSelected.length > 0) {
        Navigator.pushReplacement(context, new DashBoardRoute());
      } else {
        Navigator.pushReplacement(context, new LoginRoute());
      }
    } else {
      Navigator.pushReplacement(context, new LanguageRoute());
    }
  }
}
