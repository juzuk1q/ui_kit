import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

enum CustomButtonState { normal, disabled, outlined, destructive }

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;         // действие при нажатии
  final String text;                // текст кнопки
  final CustomButtonState state;    // тип кнопки

  const CustomButton({super.key, required this.onTap, this.text='Text', this.state = CustomButtonState.normal});

  ({Color textColor, Color bgColor, Color borderColor}) get _colors => switch (state) {
    CustomButtonState.normal => (textColor: AppColors.white, bgColor: AppColors.primary, borderColor: AppColors.primary),
    CustomButtonState.disabled => (textColor: AppColors.white, bgColor: AppColors.primary.withValues(alpha: 0.6), borderColor: AppColors.primary.withValues(alpha: 0.3)),
    CustomButtonState.outlined => (textColor: AppColors.primary, bgColor: Colors.transparent, borderColor: AppColors.primary),
    CustomButtonState.destructive => (textColor: AppColors.white, bgColor: AppColors.error, borderColor: AppColors.error)
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.fh,
        width: double.infinity,
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width.fw * 0.5,
          maxWidth: MediaQuery.of(context).size.width.fw
        ),
        decoration: BoxDecoration(color: _colors.bgColor, border: .all(color: _colors.borderColor, width: 2), borderRadius: .circular(8.r)),
        child: Center(child: Text(text, style: AppText.bodyM.copyWith(color: _colors.textColor))),
      ),
    );
  }
}
