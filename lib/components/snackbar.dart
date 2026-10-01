import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vize/vize.dart';

void showCustomSnack( //вызов снэкбара
    BuildContext context, {
      required String msg,
      String action = 'UNDO',
      VoidCallback? onAction,
    }) {
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

class CustomSnackBar extends StatelessWidget {
  final String msg;
  final String? action;
  final VoidCallback? onAction;

  const CustomSnackBar({super.key, required this.msg, this.action = 'UNDO', this.onAction});

  @override
  Widget build(BuildContext context) {
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
          SvgPicture.asset('assets/icons/success.svg',),
          SizedBox(width: 8.fw),
          Expanded(child: Text(msg, style: AppText.bodyS.copyWith(color: AppColors.darkenWhite),)),
          SizedBox(width: 38.fw),
          GestureDetector(
            onTap: onAction ?? () {},
            child: Text(action!, style: AppText.fieldLabel.copyWith(color: AppColors.grey),),
          )
        ],
      ),
    );
  }
}
