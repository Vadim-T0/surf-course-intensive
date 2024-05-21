import 'package:task_12/domain/entity/product_entity.dart';
import 'package:task_12/domain/entity/sorting_type.dart';

/// Расширение для сортировки списка продуктов
extension ProductsListX on List<ProductEntity> {
  List<ProductEntity> sortByFilter(SortingType type) {
    final List<ProductEntity> sortedList = switch (type) {
      SortingType.none => this,
      SortingType.nameFromA => _sortByName(this),
      SortingType.nameFromZ => _sortByName(this, isFromA: false),
      SortingType.ascendingOrder => _sortByPrice(this),
      SortingType.descendingOrder => _sortByPrice(this, isCheapFirst: false),
      SortingType.typeFromA => _sortByCategory(this),
      SortingType.typeFromZ => _sortByCategory(this, isFromA: false),
    };

    return sortedList;
  }

  /// Сортировка по цене товара, по умолчанию в порядке возрастания
  List<ProductEntity> _sortByPrice(List<ProductEntity> initialList,
      {bool isCheapFirst = true}) {
    final result = initialList;

    result.sort((a, b) => isCheapFirst
        ? a.decimalPrice.compareTo(b.decimalPrice)
        : b.decimalPrice.compareTo(a.decimalPrice));

    return result;
  }

  /// Сортировка по названию товара, по умолчанию в порядке возрастания
  List<ProductEntity> _sortByName(List<ProductEntity> initialList,
      {bool isFromA = true}) {
    final result = initialList;

    result.sort((a, b) =>
        isFromA ? a.title.compareTo(b.title) : b.title.compareTo(a.title));

    return result;
  }

  /// Сортировка по категории, по умолчанию в порядке возрастания
  List<ProductEntity> _sortByCategory(List<ProductEntity> initialList,
      {bool isFromA = true}) {
    final result = List<ProductEntity>.from(initialList);

    result.sort((a, b) => isFromA
        ? a.category.name.compareTo(b.category.name)
        : b.category.name.compareTo(a.category.name));

    return result;
  }
}
