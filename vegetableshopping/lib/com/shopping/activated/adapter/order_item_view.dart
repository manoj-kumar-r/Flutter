import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/customui/customuielements.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

class OrderItemView extends StatefulWidget {
  final int index;

  const OrderItemView({Key? key, required this.index}) : super(key: key);

  @override
  _OrderItemViewState createState() => _OrderItemViewState(index: index);
}

class _OrderItemViewState extends State<OrderItemView> {
  final int index;

  _OrderItemViewState({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CustomColors.bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // const Image(
          //   height: 80,
          //   width: 80,
          //   fit: BoxFit.contain,
          //   image: AssetImage("assets/images/ic_no_image.png"),
          // ),
          // const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Id : $index",
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: CustomColors.titleDarkColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(height: 5),
                Text(
                  "Product Titles : $index",
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: CustomColors.titleDarkColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(height: 5),
                Text(
                  "Price : $index",
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: CustomColors.titleLightColor,
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Date : $index",
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: CustomColors.titleDarkColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Align(
                      alignment: Alignment.topRight,
                      child: Center(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: CustomUIElements.getTextAC(TextAlign.center, Colors.white, 12, "Status"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
