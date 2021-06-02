import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

class CustomAppBar extends StatelessWidget {
  final Widget body;
  final String title;
  final String subtitle;

  const CustomAppBar({
    Key? key,
    required this.body,
    required this.title,
    this.subtitle = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (subtitle.isEmpty) {
      widget = Text(title);
    } else {
      widget = RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSansBold',
            ),
            children: <TextSpan>[
              TextSpan(
                text: '\n$subtitle',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'OpenSansBold',
                ),
              ),
            ]),
      );
    }

    return Scaffold(
      backgroundColor: CustomColors.colorPrimary,
      appBar: AppBar(
        title: widget,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
      ),
      body: Center(child: body),
    );
  }
}
