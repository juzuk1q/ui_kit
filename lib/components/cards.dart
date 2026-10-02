import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vize/vize.dart';

// тип карточек
enum CardType {
  visitCard, // карточка с аватаром, именем+фамилией, должность
  vacantion, // карточка с вакансией
  vacantionV2, // карточка с вакансией с инициалами
  number, // карточка с аватаром, именем+фамилией, адрес, номер телефона
  experience, // карточка без аватара, самая большая
}

/*
    дата создания: 25-09-2026
    автор создания: 1001
    класс отвечает за создания и отрисовки карточек (они нигде не используются, зачем).
*/
class CustomCard extends StatefulWidget {
  final CardType type; // тип карточки
  final double height; // высота карточки
  final VoidCallback onTap; // действие при нажатии
  final String? title; // имя + фамилия
  final String? job; // должность
  final String? status; // состояние (на .vacantion)
  final String? icon1; // иконка для элемента 1
  final String? iconText1; // текст для элемента 1
  final String? icon2; // иконка для элемента 2
  final String? iconText2; // текст для элемента 2
  final String? icon3; // иконка для элемента 3
  final String? iconText3; // текст для элемента 3 (.vacantion)
  final String? icon4; // иконка для элемента 4
  final String? iconText4; // текст для элемента 4 (.vacantionV2)

  const CustomCard({
    super.key,
    required this.type,
    required this.height,
    required this.onTap,
    this.title = 'Elena Rodriguez',
    this.job = 'Senior Product Designer',
    this.status = 'Active',
    this.icon1 = 'assets/icons/productTeam.svg',
    this.iconText1 = 'Product Team',
    this.icon2 = 'assets/icons/time.svg',
    this.iconText2 = 'Full-time',
    this.icon3 = 'assets/icons/money.svg',
    this.iconText3 = '\$120k - \$160k',
    this.icon4 = 'assets/icons/applicants.svg',
    this.iconText4 = '24 Applicants',
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  void initState() {
    super.initState();
    appLog(
      'CustomCard',
      'Инициализация',
      'Создание карточки (Тип: ${widget.type}, Title: "${widget.title ?? ''}")',
      level: LogLevel.info,
    );
  }

  @override
  void dispose() {
    appLog(
      'CustomCard',
      'Уничтожение',
      'Уничтожение карточки (Тип: ${widget.type})',
      level: LogLevel.info,
    );
    super.dispose();
  }

  // каркас для карточек
  @override
  Widget build(BuildContext context) {
    appLog(
      'CustomCard',
      'Отрисовка',
      'Отрисовка карточки (Тип: ${widget.type}, Title: "${widget.title ?? ''}")',
      level: LogLevel.debug,
    );

    return GestureDetector(
      onTap: () {
        appLog(
          'CustomCard',
          'Нажатие',
          'Клик по карточке (Тип: ${widget.type}, Title: "${widget.title ?? ''}")',
          level: LogLevel.info,
        );
        widget.onTap();
      },
      child: Container(
        padding: pa(16),
        height: widget.height.fh,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: .circular(12),
          border: .all(color: AppColors.darkenWhite),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withValues(alpha: 0.05),
              offset: Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        // меняем содержимое, в зависимости от типа карточки
        child: switch (widget.type) {
          CardType.visitCard => _VisitCard(),
          CardType.vacantion => _VacantionCard(),
          CardType.vacantionV2 => _VacantionV2Card(),
          CardType.number => _NumberCard(),
          CardType.experience => _ExperienceCard(),
        },
      ),
    );
  }

  Widget _VisitCard() {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      children: [
        CustomAvatars(initials: widget.title!, avatar: .avatar2, size: 96),
        SizedBox(height: 16.fh),
        Text(widget.title!, style: AppText.subHeader),
        SizedBox(height: 4.fh),
        Text(widget.job!, style: AppText.bodyM.copyWith(color: AppColors.secondary)),
      ],
    );
  }

  Widget _VacantionCard() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            Text(
              widget.job!,
              style: AppText.subHeader.copyWith(color: AppColors.black),
            ),
            Spacer(),
            _chipCircle(widget.status ?? 'Active', AppColors.secondary, AppColors.grey),
          ],
        ),
        SizedBox(height: 4.fh),
        Text([widget.iconText1, widget.iconText2].join(' • '), style: AppText.bodyS.copyWith(color: AppColors.secondary)),
        SizedBox(height: 16.fh),
        Container(
          padding: po(t: 10),
          decoration: BoxDecoration(
            border: .fromLTRB(
              left: .none,
              top: .new(color: AppColors.darkenWhite, width: 1),
              right: .none,
              bottom: .none,
            ),
          ),
          child: Row(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              _IconText(widget.icon3!, widget.iconText3!, 11, 16.5, AppColors.black),
              SizedBox(width: 24.fw),
              _IconText(widget.icon4!, widget.iconText4!, 9, 16, AppColors.black),
            ],
          ),
        ),
      ],
    );
  }

  Widget _VacantionV2Card() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: .start,
          children: [
            CustomAvatars(initials: widget.title!, avatar: .initials),
            SizedBox(width: 16.fw),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(widget.title!, style: AppText.bodyS),
                SizedBox(height: 4.fh),
                Row(
                  children: [
                    _IconText(widget.icon1!, widget.iconText1!, 13, 13),
                    SizedBox(width: 18.fw),
                    _IconText(widget.icon2!, widget.iconText2!, 13, 13),
                  ],
                ),
                SizedBox(height: 4.fh),
                _IconText(widget.icon3!, widget.iconText3!, 15, 10, AppColors.black),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.fh),
        Container(
          padding: po(t: 16),
          decoration: BoxDecoration(
            border: .fromLTRB(top: .new(color: AppColors.grey)),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: .end,
                children: [
                  Text('24',style: AppText.bodyS.copyWith(color: AppColors.primary),),
                  Text('Applicants', style: AppText.bodyS),
                ],
              ),
              Spacer(),
              SvgPicture.asset('assets/icons/arrowRight.svg', package: 'ui_kit',)
            ],
          ),
        ),
      ],
    );
  }

  Widget _NumberCard() {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            CustomAvatars(initials: 'Alexander Volkov', avatar: .avatar3, size: 48,),
            SizedBox(width: 16.fw),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(widget.title!, style: AppText.fieldLabel,),
                Text('Senior Product', style: AppText.bodyS.copyWith(color: AppColors.secondary),)
              ],
            ),
            Spacer(),
            _chipRound('Интервью'),
          ],
        ),
        SizedBox(height: 12.fh,),
        _IconText('assets/icons/geo.svg', 'San Francisco, CA', 15, 12),
        SizedBox(height: 32.fh,),
        Row(
          children: [
            _IconText('assets/icons/phone.svg', '+1 415 555 0128', 13.5, 13.5),
            SizedBox(width: 4.fw,),
            SizedBox(height: 13.33.fh, width: 13.33.fw, child: SvgPicture.asset('assets/icons/copy.svg', colorFilter: .mode(AppColors.primary, .srcIn), package: 'ui_kit')),
          ],
        )
      ],
    );
  }

  Widget _ExperienceCard() {
    return Container(
      padding: pa(8),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(widget.title!, style: AppText.subHeader.copyWith(fontWeight: .w700)),
          SizedBox(height: 4.fh),
          Text(widget.job!, style: AppText.bodyM.copyWith(color: AppColors.secondary)),
          SizedBox(height: 16.fh),
          Row(children: [
            _chipCircle('Shortlisted', AppColors.secondary, AppColors.darkenWhite),
            SizedBox(width: 4.fw,),
            _chipCircle('New York, NY', AppColors.secondary, AppColors.darkenWhite),
          ],),
          SizedBox(height: 24.fh,),
          Container(
            padding: po(t: 16),
            decoration: BoxDecoration(
              border: .fromLTRB(top: .new(color: AppColors.darkenWhite)),
            ),
            child: Row(
              children: [
                Container(
                  height: 44.fh,
                  width: 142.fw,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('Experience',style: AppText.fieldLabel.copyWith(color: AppColors.secondary),),
                      Text('8 Years', style: AppText.fieldLabel.copyWith(color: AppColors.black, fontWeight: .w600)),
                    ],
                  ),
                ),
                SizedBox(width: 16.fw),
                Container(
                  height: 44.fh,
                  width: 142.fw,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('Notice Period',style: AppText.fieldLabel.copyWith(color: AppColors.secondary),),
                      Text('Immediate', style: AppText.fieldLabel.copyWith(color: AppColors.black, fontWeight: .w600)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]
      ),
    );
  }

  // доп. виджет для отрисовки иконки рядом с текстом
  Widget _IconText(
    String icon,
    String text,
    double h,
    double w, [
    Color color = AppColors.secondary,
  ]) {
    return Container(
      height: 20.fh,
      child: Row(
        mainAxisSize: .min,
        mainAxisAlignment: .center,
        children: [
          SizedBox(
            child: SvgPicture.asset(
              icon,
              colorFilter: .mode(color, .srcIn),
              package: 'ui_kit',
            ),
            height: h.fh,
            width: w.fw,
          ),
          SizedBox(width: 4.fw),
          Text(text, style: AppText.bodyS.copyWith(color: color)),
        ],
      ),
    );
  }

  // доп. виджет для чипса с сильным закруглением
  Widget _chipCircle(String text, [Color colorText = AppColors.primary, Color colorBg = AppColors.grey]) {
    return Container(
      padding: ps(h: 12.fw, v: 4.fh),
      decoration: BoxDecoration(
        color: colorBg,
        borderRadius: .circular(999.r),
      ),
      child: Text(
        text,
        style: AppText.fieldLabel.copyWith(color: colorText),
      ),
    );
  }

  // доп. виджет для чипса с закруглением
  Widget _chipRound(String text) {
    return Container(
      padding: ps(h: 8.fw, v: 4.fh),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: .circular(4.r),
      ),
      child: Text(
        text,
        style: AppText.fieldLabel.copyWith(color: AppColors.darkenWhite),
      ),
    );
  }
}
