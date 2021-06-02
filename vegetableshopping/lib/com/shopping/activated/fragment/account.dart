import 'package:flutter/material.dart';
import 'package:vegetableshopping/com/shopping/activated/menu/address.dart';
import 'package:vegetableshopping/com/shopping/customui/customuielements.dart';
import 'package:vegetableshopping/com/shopping/utils/custom_colors.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: _getUi(),
        ),
      ),
    );
  }

  _getUi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _getProfileImage(),
        const SizedBox(height: 10),
        _getPayment(),
        const SizedBox(height: 10),
        _getAddress(),
        const SizedBox(height: 10),
        _getSetting(),
        const SizedBox(height: 10),
        _getAbout(),
        const SizedBox(height: 10),
        _getLogout(),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _getProfileImage() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          CircleAvatar(
            radius: 35.0,
            backgroundColor: CustomColors.colorPrimary,
            child: CircleAvatar(
              radius: 33.0,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.camera_alt,
                color: CustomColors.colorPrimary,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                "User Name",
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
              const SizedBox(height: 5),
              Text(
                "Email Id: demo@demo.com",
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
              const SizedBox(height: 5),
            ],
          )
        ],
      ),
    );
  }

  Widget _getPayment() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CustomColors.bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              Icons.payments,
              size: 20,
              color: CustomColors.titleLightColor,
            ),
          ),
        ),
        CustomUIElements.getTextAC(
            TextAlign.start, CustomColors.titleDarkColor, 15, "Payment",
            isBold: false),
      ],
    );
  }

  Widget _getAbout() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CustomColors.bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              Icons.info_outline_rounded,
              size: 20,
              color: CustomColors.titleLightColor,
            ),
          ),
        ),
        CustomUIElements.getTextAC(
            TextAlign.start, CustomColors.titleDarkColor, 15, "About",
            isBold: false)
      ],
    );
  }

  Widget _getAddress() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, AddressRoute());
      },
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CustomColors.bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.location_on_rounded,
                size: 20,
                color: CustomColors.titleLightColor,
              ),
            ),
          ),
          CustomUIElements.getTextAC(
              TextAlign.start, CustomColors.titleDarkColor, 15, "Saved Address",
              isBold: false)
        ],
      ),
    );
  }

  Widget _getSetting() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CustomColors.bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              Icons.settings,
              size: 20,
              color: CustomColors.titleLightColor,
            ),
          ),
        ),
        CustomUIElements.getTextAC(
            TextAlign.start, CustomColors.titleDarkColor, 15, "Setting",
            isBold: false)
      ],
    );
  }

  Widget _getLogout() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CustomColors.bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              Icons.logout,
              size: 20,
              color: CustomColors.titleLightColor,
            ),
          ),
        ),
        CustomUIElements.getTextAC(
            TextAlign.start, CustomColors.titleDarkColor, 15, "Logout",
            isBold: false)
      ],
    );
  }
}
