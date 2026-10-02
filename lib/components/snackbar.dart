import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vize/vize.dart';

//вызов снэкбара
void showCustomSnack(
  BuildContext context, {
  required String msg,
  String action = 'UNDO',
  VoidCallback? onAction,
}) {
  appLog(
    'CustomSnackBar',
    'Показ оповещения',
    'Сообщение: "$msg"',
    level: LogLevel.info,
  );

  final messenger = ScaffoldMessenger.of(context);
  messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        margin: pa(16),
        duration: Duration(seconds: 5),
        content: CustomSnackBar(
          msg: msg,
          action: action,
          onAction: () {
            onAction?.call();
            messenger.hideCurrentSnackBar();
          },
        ),
      ),
    );
}

/*
    дата создания: 29-09-2026
    автор создания: 1001
    класс отвечает за создания оповещения внутри приложения.
*/
class CustomSnackBar extends StatefulWidget {
  final String msg;               // сообщение
  final String? action;           // действие (текст)
  final VoidCallback? onAction;   // что делает действие

  const CustomSnackBar({
    super.key,
    required this.msg,
    this.action = 'UNDO',
    this.onAction,
  });

  @override
  State<CustomSnackBar> createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar> {
  @override
  void initState() {
    super.initState();
    appLog(
      'CustomSnackBar',
      'Инициализация',
      'Создание снекбара (Сообщение: "${widget.msg}")',
      level: LogLevel.info,
    );
  }

  @override
  void dispose() {
    appLog(
      'CustomSnackBar',
      'Уничтожение',
      'Уничтожение снекбара',
      level: LogLevel.info,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appLog(
      'CustomSnackBar',
      'Отрисовка',
      'Отрисовка снекбара (Сообщение: "${widget.msg}")',
      level: LogLevel.debug,
    );

    return Container(
      padding: pa(16),
      height: 72.fh,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff1a1c24),
        borderRadius: .circular(8.r),
        boxShadow: [
          BoxShadow(color: Color(0xff000000).withValues(alpha: 0.1), blurRadius: 25, spreadRadius: -5, offset: Offset(0, 20)),
          BoxShadow(color: Color(0xff000000).withValues(alpha: 0.1), blurRadius: 10, spreadRadius: -6, offset: Offset(0, 8)),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/success.svg',
            package: 'ui_kit',
          ),
          SizedBox(width: 8.fw),
          Expanded(
            child: Text(
              widget.msg,
              style: AppText.bodyS.copyWith(color: AppColors.darkenWhite),
            ),
          ),
          SizedBox(width: 38.fw),
          GestureDetector(
            onTap: () {
              appLog(
                'CustomSnackBar',
                'Нажатие',
                'Клик по действию "${widget.action ?? ''}"',
                level: LogLevel.info,
              );
              widget.onAction?.call();
            },
            child: Text(
              widget.action!,
              style: AppText.fieldLabel.copyWith(color: AppColors.grey),
            ),
          )
        ],
      ),
    );
  }
}
