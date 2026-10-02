import 'package:flutter/material.dart';
import 'package:vize/vize.dart';
import 'package:ui_kit/ui_kit.dart';

// перечисляем различные варианты аватарки
enum AvatarType {
  avatar1,    // синий мужчина
  avatar2,    // нарисованная женщина
  avatar3,    // крутой чел в костюме
  avatar4,    // аватарка с мужчиной (нарисованный)
  avatar5,    // аватарка с женщиной
  initials,   // строится на initialsFromName
}

/*
    дата создания: 25-09-2026
    автор создания: 1001
    класс отвечает за создания и отрисовки аватара.
*/
class CustomAvatars extends StatelessWidget {
  final double size;            // размер аватара
  final AvatarType? avatar;     // тип аватара
  final ImageProvider? image;   // если у нас фото загружается с бд
  final String initials;        // фио личности
  final String? wth;            // под аватаркой

  const CustomAvatars({
    super.key,
    this.size = 64,
    this.avatar,
    this.image,
    required this.initials,
    this.wth = null,
  });

  // определяем к каждому типу аватара свою картинку
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

// функция, чтобы достать первые буквы из ФИО личности
String initialsFromName(String name) {
  final parts = name
      .trim()                       // убираем лишние пробелы
      .split(RegExp(r'\s+'))        // делим там, где есть пробелы
      .where((p) => p.isNotEmpty)
      .toList();                    // возвращаем в список
  if (parts.isEmpty) return '';
  if (parts.length == 1) return parts.first[0].toUpperCase(); // если 1 элемент
  return (parts.first[0] + parts.last[0]).toUpperCase();      // если 2+
}
