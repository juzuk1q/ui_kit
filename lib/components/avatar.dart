import 'package:flutter/material.dart';
import 'package:vize/vize.dart';
import 'package:ui_kit/ui_kit.dart';

enum AvatarType {
  avatar1,
  avatar2,
  avatar3,
  avatar4,
  avatar5,
  initials,
}

class CustomAvatars extends StatelessWidget {
  final double size;
  final AvatarType? avatar;
  final ImageProvider? image;
  final String initials;
  final String? wth; // под аватаркой

  const CustomAvatars({
    super.key,
    this.size = 64,
    this.avatar,
    this.image,
    required this.initials,
    this.wth = null,
  });

  String? get _assetPath => switch (avatar) {
    AvatarType.avatar1 => '/assets/images/avatar1.png',
    AvatarType.avatar2 => '/assets/images/avatar2.png',
    AvatarType.avatar3 => '/assets/images/avatar3.png',
    AvatarType.avatar4 => '/assets/images/avatar4.png',
    AvatarType.avatar5 => '/assets/images/avatar5.jpg',
    AvatarType.initials => null,
    null => null,
  };

  ImageProvider? get _Image2 {
    if (image != null) return image;
    final path = _assetPath;
    if (path != null) {
      return AssetImage(path, package: 'ui_kit');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final img = _Image2;

    final icon = Container(
      height: size.fh,
      width: size.fw,
      decoration: BoxDecoration(
        shape: .circle,
        color: AppColors.darkenWhite,
        border: .all(color: img != null ? AppColors.primary : AppColors.grey),
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
            if (img != null)
              Positioned.fill(
                child: Image(
                  image: img,
                  fit: .cover,
                  errorBuilder: (_, __, ___) => SizedBox.shrink(),
                ),
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
        ],
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
