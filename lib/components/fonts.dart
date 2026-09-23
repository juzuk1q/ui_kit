import 'package:flutter/material.dart';
import 'package:vize/vize.dart';
import 'package:ui_kit/components/colors.dart';

// класс текста,
class AppText{
  AppText();

  static TextStyle base({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? letterSpacing,
    required double height,
  }) => TextStyle(
    fontFamily: 'Manrope',
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color ?? AppColors.black,
    letterSpacing: letterSpacing ?? 0,
    height: height / fontSize,
    package: 'ui_kit'
  );

  static TextStyle get header => base(fontSize: 24.fh, fontWeight: .w700, letterSpacing: -0.48, height: 32);
  static TextStyle get subHeader => base(fontSize: 18.fh, fontWeight: .w600, letterSpacing: -0.18, height: 24);
  static TextStyle get bodyM => base(fontSize: 16.fh, fontWeight: .w400, height: 24);
  static TextStyle get bodyS => base(fontSize: 14.fh, fontWeight: .w400, height: 20);
  static TextStyle get fieldLabel => base(fontSize: 14.fh, fontWeight: .w600, height: 20);
}