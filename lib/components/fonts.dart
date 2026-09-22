import 'package:flutter/material.dart';
import 'package:vize/vize.dart' hide TextStyle;
import 'package:ui_kit/components/colors.dart';

// класс текста,
class AppText{
  AppText();

  static TextStyle base({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? letterSpacing,
  }) => TextStyle(
    fontFamily: 'Manrope',
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color ?? AppColors.black,
    letterSpacing: letterSpacing ?? 0,
  );

  static TextStyle get header => base(fontSize: 24.fh, fontWeight: .w700, letterSpacing: -0.48.fw);
  static TextStyle get subHeader => base(fontSize: 18.fh, fontWeight: .w600, letterSpacing: -0.18.fw);
  static TextStyle get bodyM => base(fontSize: 16.fh, fontWeight: .w400);
  static TextStyle get bodyS => base(fontSize: 14.fh, fontWeight: .w400);
  static TextStyle get fieldLabel => base(fontSize: 14.fh, fontWeight: .w600);
}