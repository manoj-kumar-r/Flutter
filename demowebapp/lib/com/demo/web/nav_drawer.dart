import 'package:flutter/material.dart';

import 'fragment/contact_page.dart';
import 'fragment/event_page.dart';
import 'fragment/home_page.dart';
import 'fragment/notification_page.dart';
import 'fragment/profile_page.dart';

// ignore: use_key_in_widget_constructors
class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  var messageText = "Home Page";

  late bool displayMobileLayout;

  var _selectedIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    ProfilePage(),
    EventPage(),
    NotificationPage(),
    ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return Row(
      children: [
        if (!displayMobileLayout) _getDrawer(),
        Expanded(
          child: Scaffold(
            appBar: AppBar(title: Text(messageText)),
            drawer: (displayMobileLayout) ? _getDrawer() : null,
            body: _children[_selectedIndex],
            bottomNavigationBar: _getBottomView(),
          ),
        )
      ],
    );
  }

  Widget _getBottomView() {
    return BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black12,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Events',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notifications',
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            label: 'Contact Info',
            backgroundColor: Colors.brown,
          )
        ]);
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getDrawer() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          _createDrawerBodyItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () {
              if (displayMobileLayout) Navigator.pop(context);
              _showMessage("Home");
              setState(() {
                _selectedIndex = 0;
                messageText = "Home";
              });
            },
          ),
          _createDrawerBodyItem(
            icon: Icons.account_circle,
            text: 'Profile',
            onTap: () {
              if (displayMobileLayout) Navigator.pop(context);
              _showMessage("Profile");
              setState(() {
                _selectedIndex = 1;
                messageText = "Profile";
              });
            },
          ),
          _createDrawerBodyItem(
            icon: Icons.event_note,
            text: 'Events',
            onTap: () {
              if (displayMobileLayout) Navigator.pop(context);
              _showMessage("Events");
              setState(() {
                _selectedIndex = 2;
                messageText = "Events";
              });
            },
          ),
          const Divider(),
          _createDrawerBodyItem(
            icon: Icons.notifications_active,
            text: 'Notifications',
            onTap: () {
              if (displayMobileLayout) Navigator.pop(context);
              _showMessage("Notifications");
              setState(() {
                _selectedIndex = 3;
                messageText = "Notifications";
              });
            },
          ),
          _createDrawerBodyItem(
              icon: Icons.contact_phone,
              text: 'Contact Info',
              onTap: () {
                if (displayMobileLayout) Navigator.pop(context);
                _showMessage('Contact Info');
                setState(() {
                  _selectedIndex = 4;
                  messageText = 'Contact Info';
                });
              }),
          ListTile(
            title: const Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  _showMessage(String text) {
    var snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _createDrawerBodyItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
