import 'package:flutter/material.dart';
import 'package:task_12/domain/entity/product_entity.dart';
import 'package:task_12/domain/entity/sorting_type.dart';
import 'package:task_12/utils/extension/products_list_x.dart';
import 'package:task_12/widgets/product_widget.dart';
import 'package:task_12/widgets/financial_widget.dart';

/// Виджет для вывод списка продуктов без категорий.
class NoCategoryWidget extends StatelessWidget {
  /// Список продуктов.
  final List<ProductEntity> products;

  /// Тип сортировки.
  final SortingType filter;

  const NoCategoryWidget({
    super.key,
    required this.products,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      /// Выводим список отсортированных продуктов и финансовый виджет.
      children: [
        ...products.sortByFilter(filter).map((e) => ProductWidget(product: e)),
        FinancialWidget(
          products: products,
        ),
      ],
    );
  }
}
