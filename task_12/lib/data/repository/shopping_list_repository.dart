import 'package:task_12/data/mock_data.dart';
import 'package:task_12/domain/entity/cheque_entity.dart';
import 'package:task_12/domain/entity/product_entity.dart';

/// Репозиторий для получения данных
class ShoppingListRepository {
  /// Получить чек по номеру
  Future<ChequeEntity> getCheque(int id) async {
    /// Копия чека для отображения "Без сортировки"
    List<ProductEntity> dataForStudentsOriginal = List.from(dataForStudents);

    return Future.value(
      ChequeEntity(
        id: id,
        date: DateTime(2023, 2, 24, 12, 23),
        products: dataForStudents,
        productsOrgignal: dataForStudentsOriginal,
      ),
    );
  }
}
