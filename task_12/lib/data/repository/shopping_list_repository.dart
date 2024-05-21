import 'package:task_12/data/mock_data.dart';
import 'package:task_12/domain/entity/cheque_entity.dart';

/// Репозиторий для получения данных
class ShoppingListRepository {
  /// Получить чек по номеру
  Future<ChequeEntity> getCheque(int id) async {
    return Future.value(
      ChequeEntity(
        id: id,
        date: DateTime(2023, 2, 24, 12, 23),
        products: dataForStudents,
      ),
    );
  }
}
