import 'package:intl/intl.dart';

/// Преобразуем DateTime в нужный формат
extension DateTimeX on DateTime {
  /// Строка вида 24.02.23 в 12:23
  String toStringDateAndTime() {
    return DateFormat('dd.MM.yy в HH:mm').format(this);
  }
}
