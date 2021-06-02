import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

class NotificationItemView extends StatefulWidget {
  final int index;

  const NotificationItemView({Key? key, required this.index}) : super(key: key);

  @override
  _NotificationItemViewState createState() =>
      _NotificationItemViewState(index: index);
}

class _NotificationItemViewState extends State<NotificationItemView> {
  final int index;

  _NotificationItemViewState({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CustomColors.bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Image(
            height: 100,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/ic_no_image.png"),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Title : $index",
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
          const SizedBox(height: 10),
          Text(
            "Title Description : $index",
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
          Text(
            "Date & Time : $index ",
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: CustomColors.titleLightColor,
              fontSize: 10,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.ellipsis,
            ),
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}
