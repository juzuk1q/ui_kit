import 'package:flutter/material.dart';
import 'package:vize/vize.dart';
import 'package:ui_kit/ui_kit.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? firstIcon;
  final Widget? secondIcon;
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;

  const CustomAppBar({super.key, required this.title, this.firstIcon, this.secondIcon, this.onTap1, this.onTap2});

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
          boxShadow: [BoxShadow(color: Color(0xff000000).withValues(alpha: 0.05), blurRadius: 12, offset: Offset(0, 4))]
      ),
      child: Row(
        children: [
          if (firstIcon != null) ...[
            GestureDetector(
              onTap: onTap1,
              child: firstIcon,
            ), SizedBox(width: 12.fw,),
          ],
          Expanded(child: Text(title, style: AppText.subHeader, maxLines: 2, overflow: .ellipsis,)),
          if (secondIcon != null) ...[
            GestureDetector(
              onTap: onTap2,
              child: secondIcon,
            ), SizedBox(width: 12.fw,),
          ],
        ],
      ),
    );
  }
}
