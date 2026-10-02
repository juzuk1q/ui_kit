import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vize/vize.dart';

// тип ботмбара
enum BottomBarType {
  normal,   // обычный (используется в основных экранах приложения)
  fromJSON  // для редактирования (используется при заполнении каких-либо анкет)
}

/*
    дата создания: 29-09-2026
    автор создания: 1001
    класс отвечает за создание ботмбара в нижней части экрана.
*/
class CustomBottomBar extends StatefulWidget {
  final int selectedIndex; // выбранный элемент
  final BottomBarType type; // тип ботмбара
  final ValueChanged<int>? onTap; // нажатие на элемент
  final VoidCallback? onSaveTap; // сохранить
  final VoidCallback? onContinueTap; // продолжить

  const CustomBottomBar({
    super.key,
    this.type = BottomBarType.normal,
    this.selectedIndex = 0,
    this.onTap,
    this.onSaveTap,
    this.onContinueTap,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  // словарь для основного ботмбара
  static const _items = [
    (label: 'Vacancies', icon: 'assets/icons/vacancies.svg'),
    (label: 'Candidates', icon: 'assets/icons/candidates.svg'),
    (label: 'Settings', icon: 'assets/icons/settings.svg'),
  ];

  // словарь для ботмбара, использующийся для редактирования
  static const _jsonItems = [
    (label: 'Сохранить', icon: 'assets/icons/save.svg'),
    (label: 'Продолжить', icon: 'assets/icons/continue.svg'),
  ];

  @override
  void initState() {
    super.initState();
    appLog(
      'CustomBottomBar',
      'Инициализация',
      'Создание бара (Тип: ${widget.type}, Выбран индекс: ${widget.selectedIndex})',
      level: LogLevel.info,
    );
  }

  @override
  void dispose() {
    appLog(
      'CustomBottomBar',
      'Уничтожение',
      'Уничтожение бара (Тип: ${widget.type})',
      level: LogLevel.info,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appLog(
      'CustomBottomBar',
      'Отрисовка',
      'Отрисовка бара (Тип: ${widget.type}, Выбран индекс: ${widget.selectedIndex})',
      level: LogLevel.debug,
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: .all(color: AppColors.darkenWhite, width: 1),
        borderRadius: .only(
          topLeft: .circular(12.r),
          topRight: .circular(12.r),
        ),
      ),
      child: widget.type == BottomBarType.fromJSON ? _FromJSON() : _Normal(),
    );
  }

  // обычный ботмбар
  Widget _Normal() {
    return Padding(
      padding: ps(h: 22.5.fw, v: 21.5.fh),
      child: Row(
        children: List.generate(_items.length, (i) {
          final selected = i == widget.selectedIndex;
          final item = _items[i];
          return Expanded(
            child: Container(
              margin: ps(h: 18.5.fw),
              child: GestureDetector(
                onTap: () {
                  appLog(
                    'CustomBottomBar',
                    'Нажатие',
                    'Переключение на вкладку "${item.label}" (Индекс: $i)',
                    level: LogLevel.info,
                  );
                  widget.onTap?.call(i);
                },
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

  // ботмбар для редактирования чего-либо
  Widget _FromJSON() {
    return Padding(
      padding: ps(h: 43.89.fw, v: 15.5.fh),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              appLog(
                'CustomBottomBar',
                'Нажатие',
                'Клик по кнопке "${_jsonItems.first.label}"',
                level: LogLevel.info,
              );
              widget.onSaveTap?.call();
            },
            child: Container(
              padding: pa(8),
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
            onTap: () {
              appLog(
                'CustomBottomBar',
                'Нажатие',
                'Клик по кнопке "${_jsonItems.last.label}"',
                level: LogLevel.info,
              );
              widget.onContinueTap?.call();
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: .circular(12.r),
              ),
              padding: pa(8),
              height: 48.fh,
              width: 165.fw,
              child: Column(
                children: [
                  SvgPicture.asset(
                    _jsonItems.last.icon,
                    colorFilter: .mode(AppColors.white, .srcIn),
                    package: 'ui_kit',
                  ),
                  SizedBox(height: 4.fh),
                  Text(
                    _jsonItems.last.label,
                    style: AppText.bodyS.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
