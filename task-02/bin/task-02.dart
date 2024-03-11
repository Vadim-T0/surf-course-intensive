enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  final int areaInHectare;
  final List<String> crops;
  final List<AgriculturalMachinery> machineries;

  Territory(
    this.areaInHectare,
    this.crops,
    this.machineries,
  );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
    this.id,
    this.releaseDate,
  );

  /// Переопределяем оператор "==", чтобы сравнивать объекты по значению.
  @override
  bool operator ==(Object? other) {
    if (other is! AgriculturalMachinery) return false;
    if (other.id == id && other.releaseDate == releaseDate) return true;

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ releaseDate.hashCode;
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery(
          'Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};

void main() {
  
Map<String, int> mapMachineresAge={}; // Словарь для возраста уникальной техники
List<int> listMachineresAge; // Список с возрастом уникальной техники

var currentYear = DateTime.now().year; // Текущий год

// Собираем из двух словарей данные о возрасте техники в единый словарь, получаем словарь mapMachineresAge с возрастом техники без дубликатов.
// Проходим словарь mapBefore2010
for (var country in mapBefore2010.keys) {
  var territories = mapBefore2010[country]!;
  for (var territory in territories) {
    for (var machinery in territory.machineries) {
      mapMachineresAge[machinery.id]=currentYear-machinery.releaseDate.year;
    }
  }
}

// Проходим словарь mapAfter2010
for (var country in mapAfter2010.keys) {
  var territories = mapAfter2010[country]!;
  for (var territory in territories) {
    for (var machinery in territory.machineries) {
      mapMachineresAge[machinery.id]=currentYear-machinery.releaseDate.year;
    }
  }
}

listMachineresAge = mapMachineresAge.values.toList();
int totalMachineresAge = listMachineresAge.reduce((int previousValue, int element) => previousValue + element); // Общий возраст всей техники
int averageMachineresAge = (totalMachineresAge / listMachineresAge.length).round(); // Средний возраст всей техники

listMachineresAge.sort((int previousValue, int element) => element.compareTo(previousValue)); // Сортируем список по убыванию
int numOldMachineres = listMachineresAge.length ~/ 2; // Определяем количество техники составляющей 50%
List<int> listOldMachineresAge = listMachineresAge.sublist(0, numOldMachineres); // Выделяем в новый список возрастов наиболее старой техники
int averageOldMachineresAge = (listOldMachineresAge.reduce((int previousValue, int element) => previousValue + element) / numOldMachineres).round(); // Средний возраст наиболее старой техники

print('Средний возраст всей техники: $averageMachineresAge');
print('Средний возраст самой старой техники: $averageOldMachineresAge');
  
}