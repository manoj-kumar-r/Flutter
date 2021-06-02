import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/activated/adapter/notification_item_view.dart';
import 'package:vegetableshopping/com/shopping/customui/customuielements.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

class NotificationRoute extends CupertinoPageRoute {
  NotificationRoute()
      : super(builder: (BuildContext context) => const NotificationPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: const NotificationPage(),
    );
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomUIElements.getTextColor(
            CustomColors.titleDarkColor, 15, "Messages"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.delete_forever_rounded),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: _getNoteList(),
      ),
    );
  }

  _getNoteList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) {
        return NotificationItemView(index: index);
      },
    );
  }
}
