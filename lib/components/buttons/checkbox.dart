import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';
import 'package:ui_kit/ui_kit.dart';

// вариации чекбокса
enum CheckBoxState {
  checked,    // чекбокс выбран
  unchecked,  // чекбокс не выбран
  disabled    // чекбокс недоступен
}

/*
    дата создания: 24-09-2026
    автор создания: 1001
    класс отвечает за создания чекбоксов.
 */
class CustomCheckbox extends StatefulWidget {
  final VoidCallback? onTap; // действие при нажатии
  final bool value; // значение чекбокса
  final CheckBoxState state; // состояние чекбокса

  const CustomCheckbox({
    super.key,
    this.state = .unchecked,
    this.value = false,
    this.onTap,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {

  // получаем состояние чекбокса
  CheckBoxState get _currentState {
    // если чекбокс отключен по некоторым причинам
    if (widget.state == CheckBoxState.disabled) return CheckBoxState.disabled;
    // если известно, что значения чекбокса != false или его состояние сразу выбрано, то делаем его выбранным
    if (widget.value || widget.state == CheckBoxState.checked)
      return CheckBoxState.checked;
    return CheckBoxState.unchecked;   // в других случаях не выбран
  }

  // кортеж для сопоставления цветов с вариантом кнопки
  ({Color bgColor, Color borderColor}) get _colors => switch (widget.state) {
    CheckBoxState.checked => (
      bgColor: AppColors.primary,
      borderColor: AppColors.primary,
    ),
    CheckBoxState.unchecked => (
      bgColor: AppColors.darkenWhite,
      borderColor: AppColors.secondary,
    ),
    CheckBoxState.disabled => (
      bgColor: AppColors.darkenWhite,
      borderColor: AppColors.grey,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final isChecked = _currentState == CheckBoxState.checked;
    final isDisabled = _currentState == CheckBoxState.disabled;

    return GestureDetector(
      onTap: isDisabled ? null : widget.onTap,
      child: Container(
        padding: pa(5),
        height: 24.fh,
        width: 24.fw,
        decoration: BoxDecoration(
          color: _colors.bgColor,
          border: .all(color: _colors.borderColor),
          borderRadius: .circular(4.r),
        ),
        child: isChecked
            ? SizedBox(
                height: 7.01.fh,
                width: 9.51.fw,
                child: SvgPicture.asset(
                  'assets/icons/checked.svg',
                  package: 'ui_kit',
                ),
              )
            : null,
      ),
    );
  }
}
