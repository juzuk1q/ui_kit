import 'package:flutter/material.dart';
import 'package:vize/vize.dart';
import 'package:ui_kit/ui_kit.dart';

/*
    дата создания: 29-09-2026
    автор создания: 1001
    класс отвечает за создания аппбара.
 */
class CustomAppBar extends StatefulWidget {
  final String title;           // заголовок
  final Widget? firstIcon;      // кнопка слева
  final Widget? secondIcon;     // кнопка справа
  final VoidCallback? onTap1;   // действие на кнопку слева
  final VoidCallback? onTap2;   // действие на кнопку справа

  const CustomAppBar({
    super.key,
    required this.title,
    this.firstIcon,
    this.secondIcon,
    this.onTap1,
    this.onTap2,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    super.initState();
    appLog(
      'CustomAppBar',
      'Инициализация',
      'Создание шапки экрана с заголовком "${widget.title}"',
      level: LogLevel.info,
    );
  }

  @override
  void dispose() {
    appLog(
      'CustomAppBar',
      'Уничтожение',
      'Уничтожение шапки экрана с заголовком "${widget.title}"',
      level: LogLevel.info,
    );
    super.dispose();
  }

  void _handleFirstIconTap() {
    appLog(
      'CustomAppBar',
      'Нажатие',
      'Клик по левой иконке (Заголовок: "${widget.title}")',
      level: LogLevel.info,
    );
    widget.onTap1?.call();
  }

  void _handleSecondIconTap() {
    appLog(
      'CustomAppBar',
      'Нажатие',
      'Клик по правой иконке (Заголовок: "${widget.title}")',
      level: LogLevel.info,
    );
    widget.onTap2?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ps(h: 20.fw),
      height: 65.fh,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: .all(color: AppColors.darkenWhite, width: 1),
        borderRadius: .circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withValues(alpha: 0.05),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (widget.firstIcon != null) ...[
            GestureDetector(
              onTap: _handleFirstIconTap,
              child: widget.firstIcon,
            ),
            SizedBox(width: 12.fw),
          ],
          Expanded(
            child: Text(
              widget.title,
              style: AppText.subHeader,
              maxLines: 2,
              overflow: .ellipsis,
            ),
          ),
          if (widget.secondIcon != null) ...[
            GestureDetector(
              onTap: _handleSecondIconTap,
              child: widget.secondIcon,
            ),
            SizedBox(width: 12.fw),
          ],
        ],
      ),
    );
  }
}
