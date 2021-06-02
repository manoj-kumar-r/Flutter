import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/activated/fragment/home.dart';
import 'package:vegetableshopping/com/shopping/activated/fragment/orders.dart';
import 'package:vegetableshopping/com/shopping/activated/fragment/search.dart';
import 'package:vegetableshopping/com/shopping/customui/customuielements.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

import 'fragment/account.dart';
import 'menu/address.dart';
import 'menu/cart.dart';
import 'menu/notification.dart';

class DashBoardRoute extends CupertinoPageRoute {
  DashBoardRoute()
      : super(builder: (BuildContext context) => const DashBoard());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: const DashBoard(),
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var _cartCount = 1;
  var _notificationCount = 1;
  var _selectedIndex = 0;
  List<Widget> layouts = [];

  @override
  void initState() {
    super.initState();
    layouts = [
      const HomePage(),
      const SearchPage(),
      const OrdersPage(),
      const AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: layouts[_selectedIndex],
      bottomNavigationBar: _getBottomBar(),
    );
  }

  _getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      elevation: 0,
      title: GestureDetector(
        onTap: _onLocationClicked,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_rounded,
                    color: CustomColors.titleDarkColor),
                const SizedBox(width: 5),
                CustomUIElements.getTextAC(TextAlign.start,
                    CustomColors.titleDarkColor, 16, "Location Name"),
              ],
            ),
            CustomUIElements.getTextAC(TextAlign.start,
                CustomColors.titleLightColor, 11, "Location Description..",
                isBold: false),
          ],
        ),
      ),
      actions: [
        _getNotification(),
        _getCart(),
      ],
    );
  }

  _getNotification() {
    return Stack(
      children: <Widget>[
        IconButton(
            icon:
                Icon(Icons.message_rounded, color: CustomColors.titleDarkColor),
            onPressed: () {
              _goToNotification();
            }),
        if (_notificationCount != 0)
          Positioned(
            right: 11,
            top: 11,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: const BoxConstraints(
                minWidth: 14,
                minHeight: 14,
              ),
              child: Text(
                '$_notificationCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        else
          Container()
      ],
    );
  }

  _getCart() {
    return Stack(
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.shopping_cart, color: CustomColors.titleDarkColor),
            onPressed: () {
              _goToCart();
            }),
        if (_cartCount != 0)
          Positioned(
            right: 11,
            top: 11,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: const BoxConstraints(
                minWidth: 14,
                minHeight: 14,
              ),
              child: Text(
                '$_cartCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        else
          Container()
      ],
    );
  }

  _goToNotification() {
    Navigator.push(context, NotificationRoute());
  }

  _goToCart() {
    Navigator.push(context, CartRoute());
  }

  void _onLocationClicked() {
    Navigator.push(context, AddressRoute());
  }

  _getBottomBar() {
    return BottomNavigationBar(
      backgroundColor: CustomColors.colorPrimary,
      selectedItemColor: CustomColors.colorPrimary,
      unselectedItemColor: CustomColors.titleDarkColor,
      currentIndex: _selectedIndex,
      showUnselectedLabels: false,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.white,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Search',
          backgroundColor: Colors.white,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.event_note),
          label: 'Orders',
          backgroundColor: Colors.white,
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
