import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/activated/adapter/address_item_view.dart';
import 'package:vegetableshopping/com/shopping/customui/customuielements.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

class AddressRoute extends CupertinoPageRoute {
  AddressRoute()
      : super(builder: (BuildContext context) => const AddressPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: const AddressPage(),
    );
  }
}

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomUIElements.getTextColor(
            CustomColors.titleDarkColor, 15, "My Address"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: _getUi(),
      ),
      floatingActionButton: _getAddFloatingButton(),
    );
  }

  Widget _getAddFloatingButton() {
    return FloatingActionButton.extended(
      backgroundColor: CustomColors.bgColor,
      onPressed: () {},
      icon: Icon(
        Icons.add,
        color: CustomColors.titleDarkColor,
      ),
      label:
          CustomUIElements.getTextColor(CustomColors.titleDarkColor, 15, "Add"),
    );
  }

  _getUi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _getAddressList(),
      ],
    );
  }

  _getAddressList() {
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      primary: true,
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) {
        return AddressItemView(index: index);
      },
    ));
  }
}
