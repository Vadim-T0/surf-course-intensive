import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_12/domain/entity/product_entity.dart';
import 'package:task_12/utils/extension/decimal_x.dart';
import 'package:task_12/utils/extension/price_and_discount_x.dart';
import 'package:task_12/app/colors_app.dart';
import 'package:task_12/app/text_styles_app.dart';
import 'package:task_12/app/strings_app.dart';

/// Финансовый виджет (итоговые суммы со скидкой и без).
class FinancialWidget extends StatelessWidget {
  final List<ProductEntity> products;

  const FinancialWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final fullTotal = getFullTotal(products);
    final discount = getDiscount(products);
    final total = fullTotal - discount;
    final discountPercent = calculateDiscountForAmount(fullTotal, discount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: AppColors.divider,
        ),
        const SizedBox(height: 24.0),
        const Text(AppStrings.yourPurchase, style: AppStyle.textBold16h24),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _plural(products.length),
              style: AppStyle.textRegular12h20,
            ),
            Text(
              fullTotal.toFormattedCurrency(),
              style: AppStyle.textBold12h20,
            )
          ],
        ),
        const SizedBox(height: 11.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppStrings.discount} $discountPercent%',
              style: AppStyle.textRegular12h20,
            ),
            Text(
              '-${discount.toFormattedCurrency()}',
              style: AppStyle.textBold12h20,
            )
          ],
        ),
        const SizedBox(height: 11.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppStrings.amount,
              style: AppStyle.textBold16h24,
            ),
            Text(
              total.toFormattedCurrency(),
              style: AppStyle.textBold16h24,
            )
          ],
        ),
        const SizedBox(height: 40.0),
      ],
    );
  }

  /// Склонение слова 'товар'
  String _plural(int count) {
    return Intl.plural(
      count,
      zero: 'Нет товаров',
      one: '$count товар',
      few: '$count товара',
      many: '$count товаров',
      other: '$count товара',
      locale: 'ru',
    );
  }
}
