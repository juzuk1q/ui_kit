import 'package:ui_kit/ui_kit.dart';
import 'package:vize/vize.dart';
import 'package:flutter/material.dart';

/*
    дата создания: 25-09-2026
    автор создания: 1001
    класс отвечает за создания и отрисовки аватара.
*/
class CustomProgressBar extends StatefulWidget {
  final int totalSteps;     // сколько шагов всего
  final int currentSteps;   // текущий шаг

  const CustomProgressBar({super.key, required this.totalSteps, required this.currentSteps});

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  // красим элемент в зависимости от шага
  Color _colorIndex(int index) {
    final stepNumber = index + 1;

    if (stepNumber < widget.currentSteps) {
      return AppColors.primary;
    } else if (stepNumber == widget.currentSteps) {
     return AppColors.secondary;
    } else {
      return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.totalSteps, (index) {
        final color = _colorIndex(index);
        return Expanded(child: _progressElement(color));
      }),
    );
  }

  // элемент для 1 шага
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

