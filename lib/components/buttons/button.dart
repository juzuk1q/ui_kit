import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:vize/vize.dart';

// вариации стиля кнопок
enum CustomButtonState {
  normal,       // обычный стиль
  disabled,     // стиль, когда кнопка не доступна
  outlined,     // кнопка без заднего фона (обводка + содержание)
  destructive,  // красная кнопка
}

/*
    дата создания: 24-09-2026
    автор создания: 1001
    класс отвечает за создание кнопки
 */
class CustomButton extends StatefulWidget {
  final VoidCallback onTap; // действие при нажатии
  final String text; // текст кнопки
  final CustomButtonState state; // тип кнопки

  const CustomButton({
    super.key,
    required this.onTap,
    this.text = 'Text',
    this.state = CustomButtonState.normal,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  void initState() {
    super.initState();
    appLog(
      'CustomButton',
      'Инициализация',
      'Создание кнопки "${widget.text}" (${widget.state})',
      level: LogLevel.info,
    );
  }

  @override
  void dispose() {
    appLog(
      'CustomButton',
      'Уничтожение',
      'Уничтожение кнопки "${widget.text}"',
      level: LogLevel.info,
    );
    super.dispose();
  }

  // кортеж для сопоставления цветов с вариантом кнопки
  ({Color textColor, Color bgColor, Color borderColor}) get _colors =>
      switch (widget.state) {
        CustomButtonState.normal => (
          textColor: AppColors.white,
          bgColor: AppColors.primary,
          borderColor: AppColors.primary,
        ),
        CustomButtonState.disabled => (
          textColor: AppColors.white,
          bgColor: AppColors.primary.withValues(alpha: 0.6),
          borderColor: AppColors.primary.withValues(alpha: 0.3),
        ),
        CustomButtonState.outlined => (
          textColor: AppColors.primary,
          bgColor: Colors.transparent,
          borderColor: AppColors.primary,
        ),
        CustomButtonState.destructive => (
          textColor: AppColors.white,
          bgColor: AppColors.error,
          borderColor: AppColors.error,
        ),
      };

  void _handleTap() {
    if (widget.state == CustomButtonState.disabled) {
      appLog(
        'CustomButton',
        'Нажатие',
        'Попытка клика по заблокированной кнопке "${widget.text}"',
        level: LogLevel.debug,
      );
      return;
    }

    appLog(
      'CustomButton',
      'Нажатие',
      'Клик по кнопке "${widget.text}" (${widget.state})',
      level: LogLevel.info,
    );

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: 48.fh,
        width: double.infinity,
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width.fw * 0.5,
          maxWidth: MediaQuery.of(context).size.width.fw,
        ),
        decoration: BoxDecoration(
          color: _colors.bgColor,
          border: .all(color: _colors.borderColor, width: 2),
          borderRadius: .circular(8.r),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: AppText.bodyM.copyWith(color: _colors.textColor),
          ),
        ),
      ),
    );
  }
}
