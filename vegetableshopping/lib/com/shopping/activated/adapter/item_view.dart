import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/models/data_model.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

class ItemView extends StatefulWidget {
  final int index;
  final ProductModel productModel;

  const ItemView({Key? key, required this.index, required this.productModel})
      : super(key: key);

  @override
  _ItemViewState createState() =>
      _ItemViewState(index: index, productModel: productModel);
}

class _ItemViewState extends State<ItemView> {
  final int index;
  final ProductModel productModel;

  _ItemViewState({required this.index, required this.productModel});

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
          Image.network(
            productModel.photoUrl,
            errorBuilder: (context, exception, stackTrace) {
              return const Image(
                height: 80,
                width: 80,
                fit: BoxFit.contain,
                image: AssetImage("assets/images/ic_no_image.png"),
              );
            },
            height: 80,
            width: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.name,
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
                  productModel.quantity,
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
                        "\u{20B9}${productModel.price}",
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
                              child: const Icon(Icons.add,
                                  size: 10, color: Colors.white),
                            ),
                            const SizedBox(width: 5),
                            Text("0"),
                            const SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(Icons.remove,
                                  size: 10, color: Colors.white),
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
