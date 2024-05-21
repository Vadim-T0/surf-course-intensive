import 'package:flutter/material.dart';
import 'package:task_12/domain/entity/product_entity.dart';
import 'package:task_12/app/colors_app.dart';
import 'package:task_12/widgets/product_widget.dart';
import 'package:task_12/widgets/financial_widget.dart';

/// Виджет для вывод списка продуктов из категории.
class CategoryWidget extends StatelessWidget {
  /// Имя категории
  final String category;

  /// Список продуктов этой категории.
  final List<ProductEntity> productsOfCategory;

  /// Список продуктов для финансового виджета.
  final List<ProductEntity> products;

  /// Последния категория в выводе или нет.
  final bool isLastCat;

  const CategoryWidget({
    super.key,
    required this.category,
    required this.productsOfCategory,
    required this.products,
    required this.isLastCat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Выводим название категории и ее продукты.
        Text(category),
        ...productsOfCategory.map((e) => ProductWidget(product: e)),
        if (!isLastCat)
          const Divider(
            color: AppColors.divider,
          ),

        /// Если категория последняя в выводе, то ниже выводим финансовый виджет.
        if (isLastCat)
          FinancialWidget(
            products: products,
          ),
      ],
    );
  }
}
