import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppDesignSystem {
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color greenColor = Color(0xff092E20);
  static const Color redColor = Colors.red;

  // Fonts
  static const primaryFont = 'Roboto';

  // Text Styles
  // Currency Convert Widgets
  static TextStyle dropdowntext = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Color(0xff1d2937),
  );

  static TextStyle currencyHeading = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: whiteColor,
  );

  static TextStyle currencySubHeading = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: whiteColor,
  );

  static TextStyle ammountText = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: whiteColor,
  );

  static TextStyle currencyError = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: redColor,
  );

  // Currency List

  static TextStyle listCountText = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: whiteColor,
  );

  static TextStyle countryName = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: blackColor,
  );

  static TextStyle countryRate = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: blackColor,
  );

  static TextStyle listError = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: redColor,
  );

  static TextStyle headingStyle = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 30,
    color: blackColor,
  );

  static TextStyle hintText = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: blackColor,
  );

  static TextStyle linkTextStyle = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Color(0xff092E20),
  );

  static void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: Color(0xff1d2937),
      textColor: whiteColor,
      fontSize: 18.0,
    );
  }

  static TextStyle inputFieldTextStyle = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: blackColor,
  );

  static InputDecoration inputFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: blackColor, fontFamily: primaryFont),
      floatingLabelAlignment: FloatingLabelAlignment.center,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelStyle: TextStyle(
          color: blackColor,
          backgroundColor: whiteColor,
          fontSize: 20,
          fontWeight: FontWeight.w300,
          fontFamily: primaryFont),
      filled: true,
      fillColor: whiteColor,
      // contentPadding: EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static InputDecoration amount(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: blackColor, fontFamily: primaryFont),
      floatingLabelAlignment: FloatingLabelAlignment.center,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      floatingLabelStyle: TextStyle(
        color: blackColor,
        backgroundColor: whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.w300, // Set font weight to light
        fontFamily: primaryFont,
      ),
      filled: true,
      fillColor: whiteColor,
      // contentPadding: EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class Constants {
  static Container btn(String? text,) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xff1d2937),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          text ?? 'Default Text',
          style: TextStyle(
            color: AppDesignSystem.whiteColor,
            fontFamily: AppDesignSystem.primaryFont,
            fontSize: 20,
            fontWeight: FontWeight.w300, // Set font weight to light
          ),
        ),
      ),
    );
  }
}
