void main() {
  // Список товаров отфильтрованных по количеству и сроку годности
  final List<RawProductItem> filteredProducts = products
      .where(
        (product) =>
            product.qty > 0 &&
            product.expirationDate.isAfter(
              DateTime(2022, 12, 21),
            ),
      )
      .toList();

  print('Отфильтрованный список товаров:');
  filteredProducts.forEach(print);

  // Создаем пустой каталог товаров
  final ProductsCatalog productsCatalog = {};

  //Заполняем каталог из списка отфильтрованных товаров
  for (var product in filteredProducts) {
    // Проверяем, существует ли категория
    if (!productsCatalog.containsKey(product.categoryName)) {
      productsCatalog[product.categoryName] = {};
    }

    // Проверяем, существует ли подкатегория в данной категории
    if (!productsCatalog[product.categoryName]!
        .containsKey(product.subcategoryName)) {
      productsCatalog[product.categoryName]![product.subcategoryName] = [];
    }

    // Добавляем название товара в список
    productsCatalog[product.categoryName]![product.subcategoryName]!
        .add(product.name);
  }

  print('Каталог товаров:');
  print(productsCatalog);
}

// Тип для каталога товаров
typedef ProductsCatalog = Map<String, Map<String, List<String>>>;

// Класс товара
class RawProductItem {
  final String name;
  final String categoryName;
  final String subcategoryName;
  final DateTime expirationDate;
  final int qty;

  RawProductItem(
      {required this.name,
      required this.categoryName,
      required this.subcategoryName,
      required this.expirationDate,
      required this.qty});

  @override
  String toString() {
    return 'RawProductItem(name: $name, categoryName: $categoryName, subcategoryName: $subcategoryName, expirationDate: $expirationDate, qty: $qty)';
  }
}

// Входной список товаров
final List<RawProductItem> products = [
  RawProductItem(
    name: 'Персик',
    categoryName: 'Растительная пища',
    subcategoryName: 'Фрукты',
    expirationDate: DateTime(2022, 12, 22),
    qty: 5,
  ),
  RawProductItem(
    name: 'Молоко',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Напитки',
    expirationDate: DateTime(2022, 12, 22),
    qty: 5,
  ),
  RawProductItem(
    name: 'Кефир',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Напитки',
    expirationDate: DateTime(2022, 12, 22),
    qty: 5,
  ),
  RawProductItem(
    name: 'Творог',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Не напитки',
    expirationDate: DateTime(2022, 12, 22),
    qty: 0,
  ),
  RawProductItem(
    name: 'Творожок',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Не напитки',
    expirationDate: DateTime(2022, 12, 22),
    qty: 0,
  ),
  RawProductItem(
    name: 'Творог',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Не напитки',
    expirationDate: DateTime(2022, 12, 22),
    qty: 0,
  ),
  RawProductItem(
    name: 'Гауда',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Сыры',
    expirationDate: DateTime(2022, 12, 22),
    qty: 3,
  ),
  RawProductItem(
    name: 'Маасдам',
    categoryName: 'Молочные продукты',
    subcategoryName: 'Сыры',
    expirationDate: DateTime(2022, 12, 22),
    qty: 2,
  ),
  RawProductItem(
    name: 'Яблоко',
    categoryName: 'Растительная пища',
    subcategoryName: 'Фрукты',
    expirationDate: DateTime(2022, 12, 4),
    qty: 4,
  ),
  RawProductItem(
    name: 'Морковь',
    categoryName: 'Растительная пища',
    subcategoryName: 'Овощи',
    expirationDate: DateTime(2022, 12, 23),
    qty: 51,
  ),
  RawProductItem(
    name: 'Черника',
    categoryName: 'Растительная пища',
    subcategoryName: 'Ягоды',
    expirationDate: DateTime(2022, 12, 25),
    qty: 0,
  ),
  RawProductItem(
    name: 'Курица',
    categoryName: 'Мясо',
    subcategoryName: 'Птица',
    expirationDate: DateTime(2022, 12, 18),
    qty: 2,
  ),
  RawProductItem(
    name: 'Говядина',
    categoryName: 'Мясо',
    subcategoryName: 'Не птица',
    expirationDate: DateTime(2022, 12, 17),
    qty: 0,
  ),
  RawProductItem(
    name: 'Телятина',
    categoryName: 'Мясо',
    subcategoryName: 'Не птица',
    expirationDate: DateTime(2022, 12, 17),
    qty: 0,
  ),
  RawProductItem(
    name: 'Индюшатина',
    categoryName: 'Мясо',
    subcategoryName: 'Птица',
    expirationDate: DateTime(2022, 12, 17),
    qty: 0,
  ),
  RawProductItem(
    name: 'Утка',
    categoryName: 'Мясо',
    subcategoryName: 'Птица',
    expirationDate: DateTime(2022, 12, 18),
    qty: 0,
  ),
  RawProductItem(
    name: 'Гречка',
    categoryName: 'Растительная пища',
    subcategoryName: 'Крупы',
    expirationDate: DateTime(2022, 12, 22),
    qty: 8,
  ),
  RawProductItem(
    name: 'Свинина',
    categoryName: 'Мясо',
    subcategoryName: 'Не птица',
    expirationDate: DateTime(2022, 12, 23),
    qty: 5,
  ),
  RawProductItem(
    name: 'Груша',
    categoryName: 'Растительная пища',
    subcategoryName: 'Фрукты',
    expirationDate: DateTime(2022, 12, 25),
    qty: 5,
  ),
];
