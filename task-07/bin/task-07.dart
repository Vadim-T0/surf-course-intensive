/* Класс товара */
class Product {
  final int id;
  final String category;
  final String name;
  final double price;
  final int quantity;

  const Product(this.id, this.category, this.name, this.price, this.quantity);

  @override
  String toString() {
    return '$id\t$category\t$name\t$price ₽\t$quantity шт.';
  }
}

/* Интерфейс фильтра */
abstract interface class Filter<T> {
  bool apply(T value);
}

/* Реализация фильтра по категории */
class CategoryLikeValue implements Filter<Product> {
  final String value;

  CategoryLikeValue(this.value);

  @override
  bool apply(Product product) => product.category == value;
}

/* Реализация фильтра по цене */
class PriceNotGreaterThanValue implements Filter<Product> {
  final int value;

  PriceNotGreaterThanValue(this.value);

  @override
  bool apply(Product product) => product.price <= value;
}

/* Реализация фильтра по остаткам */
class QuantityLessThanValue implements Filter<Product> {
  final double value;

  QuantityLessThanValue(this.value);

  @override
  bool apply(Product product) => product.quantity < value;
}

/* Функция применения фильтра */
List<Product> applyFilter(List<Product> products, Filter<Product> filter) {
  return products.where(filter.apply).toList();
}

/* Функция печати таблицы */
void printProducts(List<Product> products, String comment) {
  print("\n$comment");
  products.forEach(print);
}

void main() {
  final articles = '''
1,хлеб,Бородинский,500,5
2,хлеб,Белый,200,15
3,молоко,Полосатый кот,50,53
4,молоко,Коровка,50,53
5,вода,Апельсин,25,100
6,вода,Лимон,500,5
''';

// Сделать из текста список товаров
  List<Product> products = articles.trim().split('\n').map((line) {
    var parts = line.split(',');
    return Product(int.parse(parts[0]), parts[1], parts[2],
        double.parse(parts[3]), int.parse(parts[4]));
  }).toList();

// Применить фильтр по категории
  final filteredProductsByCategory =
      applyFilter(products, CategoryLikeValue('хлеб'));
  printProducts(filteredProductsByCategory, 'По категории (хлеб)');

// Применить фильтр по цене
  final filteredProductsByPrice =
      applyFilter(products, PriceNotGreaterThanValue(300));
  printProducts(filteredProductsByPrice, 'По цене (не больше указанной: 300)');

// Применить фильтр по остатку на складе
  final filteredProductsByQuantity =
      applyFilter(products, QuantityLessThanValue(50));
  printProducts(filteredProductsByQuantity,
      'По количеству остатков на складе (меньше указанной: 50)');
}
