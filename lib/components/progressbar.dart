import 'package:ui_kit/ui_kit.dart';
import 'package:vize/vize.dart';
import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final int totalSteps;     // сколько шагов всего
  final int currentSteps;   // текущий шаг

  const CustomProgressBar({super.key, required this.totalSteps, required this.currentSteps});

  Color _colorIndex(int index) {
    final stepNumber = index + 1;

    if (stepNumber < currentSteps) {
      return AppColors.primary;
    } else if (stepNumber == currentSteps) {
     return AppColors.secondary;
    } else {
      return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final color = _colorIndex(index);
        return Expanded(child: _progressElement(color));
      }),
    );
  }

  Widget _progressElement(Color color) {
    return Container(
      margin: ps(h: 2.fw),
      height: 8.fh,
      decoration: BoxDecoration(
        color: color,
        borderRadius: .circular(99.r),
      ),
    );
  }
}

