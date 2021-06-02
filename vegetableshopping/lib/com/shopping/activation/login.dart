import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/customui/customuielements.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

import 'login_view.dart';
import 'register_view.dart';

class LoginRoute extends CupertinoPageRoute {
  LoginRoute() : super(builder: (BuildContext context) => const LoginPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: CustomColors.titleDarkColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: CustomColors.titleDarkColor,
                        tabs: [
                          Tab(
                            child: CustomUIElements.getTextAC(TextAlign.start,
                                CustomColors.titleDarkColor, 15, "Login"),
                          ),
                          Tab(
                            child: CustomUIElements.getTextAC(TextAlign.start,
                                CustomColors.titleDarkColor, 15, "Register"),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    //Add this to give height
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        LoginView(callback: _changeTab),
                        RegistrationView(callback: _changeTab),
                      ],
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

  _changeTab(bool forward) {
    setState(() {
      _tabController.animateTo(
          (forward) ? _tabController.index + 1 : _tabController.index - 1);
    });
  }
}
