import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';
import 'package:ui_kit/ui_kit.dart';

enum CheckBoxState{checked, unchecked, disabled}

class CustomCheckbox extends StatelessWidget {
  final VoidCallback? onTap;
  final bool value;
  final CheckBoxState state;

  const CustomCheckbox({super.key, this.state = .unchecked, this.value = false, this.onTap});

  CheckBoxState get _currentState {
    if (state == CheckBoxState.disabled) return CheckBoxState.disabled;
    if (value || state == CheckBoxState.checked) return CheckBoxState.checked;
    return CheckBoxState.unchecked;
  }

  ({Color bgColor, Color borderColor}) get _colors => switch (state) {
    CheckBoxState.checked => (bgColor: AppColors.primary, borderColor: AppColors.primary),
    CheckBoxState.unchecked => (bgColor: AppColors.darkenWhite, borderColor: AppColors.secondary),
    CheckBoxState.disabled => (bgColor: AppColors.darkenWhite, borderColor: AppColors.grey)
  };

  @override
  Widget build(BuildContext context) {
    final isChecked = _currentState == CheckBoxState.checked;
    final isDisabled = _currentState == CheckBoxState.disabled;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: pa(5),
        height: 24.fh, width: 24.fw,
        decoration: BoxDecoration(
          color: _colors.bgColor,
          border: .all(color: _colors.borderColor),
          borderRadius: .circular(4.r),
        ),
        child: isChecked
            ? SizedBox(height: 7.01.fh, width: 9.51.fw, child: SvgPicture.asset('assets/icons/checked.svg'))
            : null,
      ),
    );
  }
}
