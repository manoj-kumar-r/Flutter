import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/activated/adapter/item_view.dart';
import 'package:vegetableshopping/com/shopping/customui/customuielements.dart';
import 'package:vegetableshopping/com/shopping/models/data_model.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_json.dart';

class CartRoute extends CupertinoPageRoute {
  CartRoute() : super(builder: (BuildContext context) => const CartPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: const CartPage(),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var _cartCount = 0;

  List<ProductModel> _productList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    var data = await CustomJson.loadProductJson();
    setState(() {
      _productList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: CustomUIElements.getTextColor(
            CustomColors.titleDarkColor, 15, "Shopping Cart"),
      ),
      backgroundColor: Colors.white,
      body: (_cartCount > 0) ? _getCartUi() : _getCartEmptyUi(),
      bottomNavigationBar: (_cartCount > 0) ? _getPlaceOrder() : null,
    );
  }

  Widget _getCartEmptyUi() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Image(
            height: 200,
            fit: BoxFit.contain,
            image: AssetImage("assets/images/farmer.jpg"),
          ),
          const SizedBox(height: 10),
          Text(
            "Your cart is empty",
            textAlign: TextAlign.start,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: CustomColors.titleDarkColor,
              fontSize: 16,
              fontFamily: "OpenSansBold",
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.ltr,
          ),
          const SizedBox(height: 10),
          Text(
            "Add items from the menu.",
            textAlign: TextAlign.start,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: CustomColors.titleLightColor,
              fontSize: 13,
              fontFamily: "OpenSansBold",
              fontWeight: FontWeight.normal,
            ),
            textDirection: TextDirection.ltr,
          ),
          const SizedBox(height: 10),
          Container(
            width: 200,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: CustomColors.colorPrimary,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            child: TextButton(
              onPressed: _continueShoppingClick,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomUIElements.getTextColor(
                      CustomColors.titleDarkColor, 15, "Continue Shopping"),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _continueShoppingClick() {
    setState(() {
      _cartCount = 1;
    });
  }

  Widget _getCartUi() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getOrderedItemsList(),
            const SizedBox(height: 5),
            Text(
              "Bill Details",
              textAlign: TextAlign.start,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: CustomColors.titleDarkColor,
                fontSize: 15,
                fontFamily: "OpenSansBold",
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 1,
              child: Container(
                color: Colors.black12,
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Item Total",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: CustomColors.titleLightColor,
                      fontSize: 13,
                      fontFamily: "OpenSansBold",
                      fontWeight: FontWeight.normal,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "\u20B955",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: CustomColors.titleDarkColor,
                      fontSize: 13,
                      fontFamily: "OpenSansBold",
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Delivery Charge",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: CustomColors.titleLightColor,
                      fontSize: 13,
                      fontFamily: "OpenSansBold",
                      fontWeight: FontWeight.normal,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "\u20B955",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: CustomColors.titleDarkColor,
                      fontSize: 13,
                      fontFamily: "OpenSansBold",
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 1,
              child: Container(
                color: Colors.black12,
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Total",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: CustomColors.titleLightColor,
                      fontSize: 13,
                      fontFamily: "OpenSansBold",
                      fontWeight: FontWeight.normal,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "\u20B955",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: CustomColors.titleDarkColor,
                      fontSize: 13,
                      fontFamily: "OpenSansBold",
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: CustomColors.bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sticky_note_2_outlined,
                    size: 40,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      "Review your order and address details to avoid cancellation.",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: CustomColors.titleDarkColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  _getOrderedItemsList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.vertical,
      itemCount: _productList.length,
      itemBuilder: (context, index) {
        return ItemView(index: index, productModel: _productList[index]);
      },
    );
  }

  Widget _getPlaceOrder() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _getAddress(),
        const SizedBox(height: 2),
        _getPaymentMethod(),
        const SizedBox(height: 2),
        _getPlaceOrderButton(),
      ],
    );
  }

  _getAddress() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: CustomColors.bgColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    const Icon(Icons.location_on_rounded),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deliver to Saved Name ",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: CustomColors.titleDarkColor,
                            fontSize: 12,
                            fontFamily: "OpenSansBold",
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                        Text(
                          "Location Name",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: CustomColors.titleLightColor,
                            fontSize: 10,
                            fontFamily: "OpenSansBold",
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                        Text(
                          "Delivery Time",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: CustomColors.titleDarkColor,
                            fontSize: 10,
                            fontFamily: "OpenSansBold",
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Change Address",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: CustomColors.colorPrimary,
                      fontSize: 13,
                      fontFamily: "OpenSansBold",
                      fontWeight: FontWeight.normal,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getPaymentMethod() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: CustomColors.bgColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    const Icon(Icons.payments),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment Method",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: CustomColors.titleDarkColor,
                            fontSize: 12,
                            fontFamily: "OpenSansBold",
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                        Text(
                          "Location Name",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: CustomColors.titleLightColor,
                            fontSize: 10,
                            fontFamily: "OpenSansBold",
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Change",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: CustomColors.colorPrimary,
                      fontSize: 13,
                      fontFamily: "OpenSansBold",
                      fontWeight: FontWeight.normal,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getPlaceOrderButton() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.colorPrimary,
      ),
      child: TextButton(
        onPressed: _continueShoppingClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomUIElements.getTextColor(
                CustomColors.titleDarkColor, 15, "Place Order"),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
