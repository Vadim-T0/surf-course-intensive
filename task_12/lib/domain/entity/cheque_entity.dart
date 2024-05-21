import 'package:task_12/domain/entity/product_entity.dart';

/// Модель чека
/// Содержит данные: номер, дата, список покупок
class ChequeEntity {
  final int id;
  final DateTime date;
  final List<ProductEntity> products;

  ChequeEntity({required this.id, required this.date, required this.products});
}
