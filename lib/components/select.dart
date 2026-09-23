import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vize/vize.dart';

class CustomDropdown extends StatefulWidget {
  final String? labelText;

  const CustomDropdown({super.key, this.labelText = 'Selector'});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(widget.labelText!, style: AppText.bodyS.copyWith(fontWeight: .w600, color: AppColors.secondary),),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 48.fh,
            width: 350.fw,
            decoration: BoxDecoration(
              color: AppColors.darkenWhite,
              border: .all(color: AppColors.grey, width: 1),
              borderRadius: .circular(8.r)
            ),
            padding: ps(h: 16.fw, v: 11.fh),
            child: Row(
              children: [
                Text('Engineering', style: AppText.bodyM),
                Spacer(),
                SvgPicture.asset('assets/icons/arrowDown.svg', package: 'ui_kit',),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
