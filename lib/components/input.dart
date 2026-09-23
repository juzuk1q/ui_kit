import 'package:flutter/material.dart';
import 'package:ui_kit/components/colors.dart';
import 'package:ui_kit/components/fonts.dart';
import 'package:vize/vize.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TextFieldState { disabled, error, focused, normal }  // состояния поле ввода
enum TextFieldType { normal, pwrd, search }               // типы поле ввода

class CustomTextField extends StatefulWidget {
  final TextFieldType? type;      // типы
  final TextFieldState? state;    // состояния
  final String? labelText;        // текст над полем
  final String? hintText;         // текст внутри поля
  final String errorDescription;  // описание ошибки
  final TextEditingController? controller;  // контроллер
  final bool enabled;             // флаг для включения / выключения поле ввода
  final bool hasError;            // флаг для ошибок

  const CustomTextField({
    super.key,
    this.type,
    this.state,
    this.controller,
    this.labelText,
    this.hintText,
    this.enabled = true,
    this.hasError = false,
    this.errorDescription = 'ERR_DESCRIPTION',
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;          // флаг для фокуса на элемент
  bool _obscureText = true;         // флаг для скрытия / показа вводимых данных в поле пароля

  TextFieldState get _currentState {
    if (widget.state != null)
      return widget.state!; // виджет работает как обычно
    if (!widget.enabled) return TextFieldState.disabled; // виджет отключен
    if (widget.hasError)
      return TextFieldState.error; // виджет с состоянием ошибкой
    if (_isFocused) return TextFieldState.focused; // виджет с состоянием фокуса
    return TextFieldState.normal; // виджет "обычный"
  }

  // кортеж для цветов, использующие для обводки
  ({Color label, Color text, Color border}) get _colors =>
      switch (_currentState) {
        TextFieldState.disabled => (
          label: AppColors.secondary,
          text: AppColors.grey,
          border: AppColors.grey,
        ),
        TextFieldState.error => (
          label: AppColors.error,
          text: AppColors.black,
          border: AppColors.error,
        ),
        TextFieldState.focused => (
          label: AppColors.primary,
          text: AppColors.black,
          border: AppColors.primary,
        ),
        TextFieldState.normal => (
          label: AppColors.secondary,
          text: AppColors.secondary,
          border: AppColors.grey,
        ),
      };

  Color get _labelColor => _colors.label; // цвет для текста
  Color get _textColor => _colors.text; // цвет для обычного текст
  Color get _borderColor => _colors.border; // цвет для обводки

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_isFocused != _focusNode.hasFocus) {
      setState(() => _isFocused = _focusNode.hasFocus);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: _borderColor, width: 1),
      borderRadius: .circular(8.r),
    );

    return Column(
      crossAxisAlignment: .start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: AppText.bodyS.copyWith(
              fontWeight: .w600,
              color: _labelColor,
            ),
          ),
          SizedBox(height: 4.5.fh),
        ],
        Container(
          height: 50.fh,
          width: 350.fw,
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            enabled: widget.enabled,
            obscureText: widget.type == .pwrd && _obscureText,
            decoration: InputDecoration(
              contentPadding: ps(h: 16.fw, v: 12.fh),
              hintText: widget.hintText,
              hintStyle: AppText.bodyM.copyWith(color: _textColor),
              filled: true,
              fillColor: AppColors.darkenWhite,
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              errorBorder: border,
              disabledBorder: border,

              //search settings
              prefixIcon: _prefixIcon,

              //pwrd settings
              suffixIcon: _suffixIcon,
            ),
          ),
        ),
        if (_currentState == .error) ...[
          SizedBox(height: 4.fh),
          Text(
            widget.errorDescription,
            style: AppText.fieldLabel.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }

  // иконка для поля поиска
  Widget? get _prefixIcon {
    if (widget.type == TextFieldType.search) {
      return Container(
        height: 18.fh,
        width: 18.fw,
        child: Padding(
          padding: po(l: 18.fw, r: 8.fw),
          child: SvgPicture.asset('assets/icons/search.svg', package: 'ui_kit'),
        ),
      );
    }
    return null;
  }

  // иконка для поля пароля
  Widget? get _suffixIcon {
    if (widget.type == TextFieldType.pwrd) {
      return GestureDetector(
        onTap: () => setState(() => _obscureText = !_obscureText),
        child: Padding(
          padding: po(r: 18.fw),
          child: SizedBox(width: 18.fw, child: SvgPicture.asset('assets/icons/eye.svg', package: 'ui_kit',)),
        ),
      );
    }
    return null;
  }
}
