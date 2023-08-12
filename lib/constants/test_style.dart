import 'package:flutter/material.dart';

class AppTextStyle {
  static textBoldWeight400(
      {required String text,
      double? fontSize,
      Color? color,
      int maxLines = 2,
      TextAlign? textAlign,
      FontWeight fontWeight = FontWeight.w400,
      bool needPoppins = true,
      String? fontFamily}) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          fontFamily: needPoppins ? 'Poppins' : fontFamily ?? 'Bubblegum'),
    );
  }

  static Widget textBoldWeight500(
      {required String text,
      double? fontSize,
      Color? color,
      height = 0.0,
      TextDecoration textDecoration = TextDecoration.none,
      FontWeight fontWeight = FontWeight.w500,
      bool needPoppins = true,
      String? fontFamily}) {
    return Text(
      text,
      style: TextStyle(
          height: height,
          fontWeight: fontWeight,
          decoration: textDecoration,
          fontSize: fontSize,
          color: color,
          fontFamily: needPoppins ? 'Poppins' : fontFamily ?? 'Bubblegum'),
    );
  }

  static Widget textBoldWeight600(
      {required String text,
      double? fontSize,
      Color? color,
      TextAlign? textAlign,
      FontWeight fontWeight = FontWeight.w600,
      bool needPoppins = true,
      String? fontFamily}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          fontFamily: needPoppins ? 'Poppins' : fontFamily ?? 'Bubblegum'),
    );
  }

  static textBoldWeight700(
      {required String text,
      double? fontSize,
      Color? color,
      TextDecoration textDecoration = TextDecoration.none,
      bool needPoppins = true,
      String? fontFamily}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
          decoration: textDecoration,
          color: color,
          fontFamily: needPoppins ? 'Poppins' : fontFamily ?? 'Bubblegum'),
    );
  }
}
