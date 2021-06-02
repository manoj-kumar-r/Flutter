import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

import 'customuielements.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final String validatorText;
  final String hintText;
  final IconData? iconData;
  final bool enabled;
  final bool obscureText;
  final TextInputType keyBoardType;
  final String obscuringCharacter;
  final ValueChanged<String>? onChanged;

  const CustomTextField(
      {Key? key,
      required this.label,
      required this.hintText,
      required this.validatorText,
      required this.textEditingController,
      required this.enabled,
      this.iconData,
      this.obscureText = false,
      this.obscuringCharacter = ".",
      this.keyBoardType = TextInputType.text,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomUIElements.getTextAC(
            TextAlign.start, CustomColors.titleDarkColor, 14, label),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: obscureText,
          obscuringCharacter: obscuringCharacter,
          keyboardType: keyBoardType,
          enabled: enabled,
          validator: (String? userInput) {
            if (userInput != null && userInput.isEmpty) {
              return validatorText;
            } else {
              return null;
            }
          },
          controller: textEditingController,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: (iconData != null)
                ? Icon(
                    iconData,
                    color: Colors.black45,
                  )
                : null,
            labelStyle: const TextStyle(
              fontSize: 11,
              color: Colors.black45,
              fontWeight: FontWeight.normal,
              fontFamily: 'OpenSansBold',
            ),
            hintStyle: const TextStyle(
              color: Colors.black45,
              fontSize: 13,
              fontWeight: FontWeight.normal,
              fontFamily: 'OpenSansBold',
            ),
            filled: true,
            fillColor: CustomColors.bgColor,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              borderSide:
                  BorderSide(color: CustomColors.colorPrimary, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
