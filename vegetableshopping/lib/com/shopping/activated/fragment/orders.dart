import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/activated/adapter/order_item_view.dart';
import 'package:vegetableshopping/com/shopping/customui/customuielements.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: _getUi(),
      ),
    );
  }

  _getUi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomUIElements.getTextAC(
            TextAlign.start, CustomColors.titleDarkColor, 15, 'Past Orders'),
        const SizedBox(height: 10),
        _getOrderedList(),
      ],
    );
  }

  _getOrderedList() {
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      primary: true,
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) {
        return OrderItemView(index: index);
      },
    ));
  }
}
