import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/customui/customuielements.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

class AddressItemView extends StatefulWidget {
  final int index;

  const AddressItemView({Key? key, required this.index}) : super(key: key);

  @override
  _AddressItemViewState createState() => _AddressItemViewState(index: index);
}

class _AddressItemViewState extends State<AddressItemView> {
  final int index;

  _AddressItemViewState({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColors.bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(
              Icons.location_on_rounded
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address Title : $index",
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: CustomColors.titleDarkColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(height: 5),
                Text(
                  "Address: $index",
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: CustomColors.titleLightColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
