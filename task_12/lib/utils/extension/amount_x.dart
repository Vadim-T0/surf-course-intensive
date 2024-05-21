import 'package:task_12/domain/entity/amount.dart';
import 'package:task_12/app/strings_app.dart';

/// Функция отображения количества товара в граммах или штуках
String getAmount(Amount amount) {
  return switch (amount) {
    Grams gm => '${(gm.value / 1000).toString()} ${AppStrings.kg}',
    Quantity qu => '${qu.value} ${AppStrings.qu}',
  };
}
