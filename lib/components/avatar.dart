import 'package:flutter/material.dart';
import 'package:vize/vize.dart';
import 'package:ui_kit/ui_kit.dart';

class CustomAvatars extends StatelessWidget {
  final double size;
  final ImageProvider? image;
  final String initials;
  final String? wth; // под аватаркой

  const CustomAvatars({
    super.key,
    this.size = 64,
    this.image,
    required this.initials,
    this.wth = null,
  });

  @override
  Widget build(BuildContext context) {
    final icon = Container(
      height: size.fh,
      width: size.fw,
      decoration: BoxDecoration(
        shape: .circle,
        color: AppColors.darkenWhite,
        border: .all(color: image != null ? AppColors.primary : AppColors.grey),
      ),
      child: ClipOval(
        child: Stack(
          children: [
            Center(
              child: Text(
                initialsFromName(initials),
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 20,
                  fontWeight: .w700,
                  height: 28.fh / 20.fh,
                ),
              ),
            ),
            if (image != null)
              Image(
                image: image!,
                fit: .cover,
                errorBuilder: (_, __, ___) => SizedBox.shrink(),
              ),
          ],
        ),
      ),
    );

    return Column(
      mainAxisSize: .min,
      children: [
        icon,
        if (wth != null) ...[
          SizedBox(height: 8.fh),
          Text(wth!, style: AppText.bodyM)
        ]
      ],
    );
  }
}

String initialsFromName(String name) {
  final parts = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((p) => p.isNotEmpty)
      .toList();
  if (parts.isEmpty) return '';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return (parts.first[0] + parts.last[0]).toUpperCase();
}
