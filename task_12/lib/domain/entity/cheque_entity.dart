import 'package:task_12/domain/entity/product_entity.dart';

/// Модель чека
/// Содержит данные: номер, дата, список покупок для сортировки, список покупок оригинальный.
class ChequeEntity {
  final int id;
  final DateTime date;
  final List<ProductEntity> products;
  final List<ProductEntity> productsOrgignal;

  ChequeEntity({
    required this.id,
    required this.date,
    required this.products,
    required this.productsOrgignal,
  });
}
