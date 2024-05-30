/// Типы сортировки.
enum SortingType {
  none(type: FilterType.none, name: 'Без сортировки'),
  nameFromA(type: FilterType.byName, name: 'По имени от А до Я'),
  nameFromZ(type: FilterType.byName, name: 'По имени от Я до А'),
  ascendingOrder(type: FilterType.byPrice, name: 'По возрастанию'),
  descendingOrder(type: FilterType.byPrice, name: 'По убыванию'),
  typeFromA(type: FilterType.byType, name: 'По типу от А до Я'),
  typeFromZ(type: FilterType.byType, name: 'По типу от Я до А');

  final FilterType type;
  final String name;

  const SortingType({required this.type, required this.name});
}

/// Группы фильтров
enum FilterType {
  none('Без сортировки'),
  byName('По имени'),
  byPrice('По цене'),
  byType('По типу');

  final String name;

  const FilterType(this.name);
}
