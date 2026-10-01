import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vize/vize.dart';

enum BottomBarType { normal, fromJSON }

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final BottomBarType type;
  final ValueChanged<int>? onTap;
  final VoidCallback? onSaveTap;
  final VoidCallback? onContinueTap;

  const CustomBottomBar({
    super.key,
    this.type = .normal,
    this.selectedIndex = 0,
    this.onTap,
    this.onSaveTap,
    this.onContinueTap,
  });

  static const _items = [
    (label: 'Vacancies', icon: 'assets/icons/vacancies.svg'),
    (label: 'Candidates', icon: 'assets/icons/candidates.svg'),
    (label: 'Settings', icon: 'assets/icons/settings.svg'),
  ];

  static const _jsonItems = [
    (label: 'Сохранить', icon: 'assets/icons/save.svg'),
    (label: 'Продолжить', icon: 'assets/icons/continue.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: .all(color: AppColors.darkenWhite, width: 1),
        borderRadius: .only(
          topLeft: .circular(12.r),
          topRight: .circular(12.r),
        ),
      ),
      child: type == .fromJSON ? _FromJSON() : _Normal(),
    );
  }

  Widget _Normal() {
    return Padding(
      padding: ps(h: 22.5.fw, v: 21.5.fh),
      child: Row(
        children: List.generate(_items.length, (i) {
          final selected = i == selectedIndex;
          final item = _items[i];
          return Expanded(
            child: Container(
              margin: ps(h: 24.5.fw),
              child: GestureDetector(
                onTap: () => onTap?.call(i),
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    SvgPicture.asset(
                      item.icon,
                      colorFilter: .mode(
                        selected ? AppColors.primary : AppColors.secondary,
                        .srcIn,
                      ),
                      package: 'ui_kit',
                    ),
                    SizedBox(height: 2),
                    Text(
                      item.label,
                      style: AppText.fieldLabel.copyWith(
                        color: selected
                            ? AppColors.primary
                            : AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _FromJSON() {
    return Padding(
      padding: ps(h: 43.89.fw, v: 15.5.fh),
      child: Row(
        children: [
          GestureDetector(
            onTap: onSaveTap,
            child: Container(
              height: 48,
              width: 125,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: .center,
                children: [
                  SvgPicture.asset(
                    _jsonItems.first.icon,
                    colorFilter: .mode(AppColors.secondary, .srcIn),
                    package: 'ui_kit',
                  ),
                  SizedBox(height: 4.fh),
                  Text(
                    _jsonItems.first.label,
                    style: AppText.bodyS.copyWith(color: AppColors.secondary),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.fw),
          GestureDetector(
            onTap: onContinueTap,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: .circular(12.r),
              ),
              height: 48.fh,
              width: 165.fw,
              child: Column(children: [
                SvgPicture.asset(
                  _jsonItems.last.icon,
                  colorFilter: .mode(AppColors.white, .srcIn),
                ),
                SizedBox(height: 4.fh),
                Text(
                  _jsonItems.last.label,
                  style: AppText.bodyS.copyWith(color: AppColors.white),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
