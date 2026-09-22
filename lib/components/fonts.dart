import 'dart:ui';
import 'package:vize/vize.dart';
import 'package:ui_kit/components/colors.dart';

// класс текста,
class AppText{
  const AppText._();

  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    double? letterSpacing,
  }) => TextStyle(
    fontFamily: 'Manrope',
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color ?? AppColors.black,
    letterSpacing: letterSpacing! / fontSize.fh,
  );

  static TextStyle get header => _base(fontSize: 24, fontWeight: .w700, letterSpacing: 32.fh);
  static TextStyle get subHeader => _base(fontSize: 18, fontWeight: .w600, letterSpacing: 24.fh);
  static TextStyle get bodyM => _base(fontSize: 16, fontWeight: .w400, letterSpacing: 24.fh);
  static TextStyle get bodyS => _base(fontSize: 14, fontWeight: .w400, letterSpacing: 20.fh);
  static TextStyle get fieldLabel => _base(fontSize: 14, fontWeight: .w600, letterSpacing: 20.fh);
}