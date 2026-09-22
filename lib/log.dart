import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

// Уровни логирования
enum LogLevel { info, debug, error }

final appLogger = Logger(printer: SimplePrinter(colors: false, printTime: false), level: kDebugMode ? Level.debug : Level.nothing);

// Метод отображения лога
// Входящие данные: тэг, событие, детали и уровень лога
// Возвращаемые значения: форматирование лога
// Автор создания: 3
// Дата создания: 22.09.2026

void appLog(String tag, String event, String details, {LogLevel level = LogLevel.info}) {
  final mes = '[$tag]: $event - $details';
  switch (level) {
    case LogLevel.debug:
      appLogger.d(mes);
      break;
    case LogLevel.info:
      appLogger.i(mes);
      break;
    case LogLevel.error:
      appLogger.e(mes);
      break;
  }
}