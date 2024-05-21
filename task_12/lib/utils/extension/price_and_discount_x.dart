import 'package:task_12/domain/entity/product_entity.dart';
import 'package:decimal/decimal.dart';

/// Вычисление цены конкретного товара с учетом скидки
Decimal calculateDiscountForProduct(Decimal price, String discountPercent) {
  if (price <= Decimal.zero || discountPercent.isEmpty) {
    return price;
  }
  final discountAmount =
      (price * Decimal.parse(discountPercent) / Decimal.fromInt(100))
          .toDecimal();
  return price - discountAmount;
}

/// Общая стоимость товаров (всего)
Decimal getFullTotal(List<ProductEntity> products) {
  return products.fold(Decimal.zero,
      (previousValue, element) => previousValue + element.decimalPrice);
}

/// Считаем сколько % составила скидка
String calculateDiscountForAmount(Decimal totalAmount, Decimal discountAmount) {
  final doubleTotalAmount = totalAmount.toDouble();
  final doubleDiscountAmount = discountAmount.toDouble();

  return (100 - (doubleDiscountAmount / doubleTotalAmount * 100))
      .toStringAsFixed(0);
}

/// Общая сумма скидки
Decimal getDiscount(List<ProductEntity> product) {
  /// Список товаров со скидкой
  final discount = product.where((element) => element.sale > 0).toList();

  return discount.isEmpty
      ? Decimal.zero
      : discount.fold<Decimal>(
          Decimal.zero,
          (previousValue, element) =>
              previousValue +
              calculateDiscountForProduct(
                element.decimalPrice,
                element.sale.toString(),
              ),
        );
}
