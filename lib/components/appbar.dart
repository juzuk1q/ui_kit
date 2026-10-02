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
  final VoidCallback? onTap1;   // действие на кнопку слеву
  final VoidCallback? onTap2;   // действие на кнопку справа

  const CustomAppBar({super.key, required this.title, this.firstIcon, this.secondIcon, this.onTap1, this.onTap2});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  @override
  void initState() {
    super.initState();
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
          boxShadow: [BoxShadow(color: Color(0xff000000).withValues(alpha: 0.05), blurRadius: 12, offset: Offset(0, 4))]
      ),
      child: Row(
        children: [
          if (widget.firstIcon != null) ...[
            GestureDetector(
              onTap: widget.onTap1,
              child: widget.firstIcon,
            ), SizedBox(width: 12.fw,),
          ],
          Expanded(child: Text(widget.title, style: AppText.subHeader, maxLines: 2, overflow: .ellipsis,)),
          if (widget.secondIcon != null) ...[
            GestureDetector(
              onTap: widget.onTap2,
              child: widget.secondIcon,
            ), SizedBox(width: 12.fw,),
          ],
        ],
      ),
    );
  }
}
