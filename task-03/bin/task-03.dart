class Television {
  static const String brand = 'Sokol';
  final String model;
  final String? serialNumber;

  final Screen screen;
  final OS os;

  int currentChannel = 0;
  int currentVolume = 0;

  Television(this.model, this.screen, this.os, {this.serialNumber});

  Television.on({
    required this.model,
    required this.screen,
    required this.os,
    this.serialNumber,
  }) {
    changeChannel(7);
    adjustVolume(50);
  }

  void turnOn() {
    print('Телевизор включен');
    currentChannel = 1;
    currentVolume = 25;
  }

  void turnOff() {
    print('Телевизор выключен');
    currentChannel = 0;
    currentVolume = 0;
  }

  void changeChannel(int channel) {
    currentChannel = channel;
  }

  void adjustVolume(int volume) {
    currentVolume = volume;
  }

  @override
  String toString() {
    var aboutTV = '''
    Производитель: $brand
    Модель: $model
    Серийный номер: $serialNumber
    Канал: $currentChannel
    Громкость: $currentVolume
    $screen
    $os
    ''';
    return aboutTV;
  }
}

class Screen {
  final int sizeInInches;
  final String resolution;

  Screen(this.sizeInInches, this.resolution);

  @override
  String toString() {
    var aboutScreen = "Экран: $sizeInInches $resolution";
    return aboutScreen;
  }
}

class OS {
  final String name;
  final String version;

  OS(this.name, this.version);

  @override
  String toString() {
    var aboutOS = "ОС: $name $version";
    return aboutOS;
  }
}

void main() {
  final Screen screen45 = Screen(45, 'HD');
  final Screen screen55 = Screen(55, 'Full HD');
  final Screen screen65 = Screen(65, '4K');

  final OS osSmartOS = OS('SmartOS', '2.0');
  final OS osAndroid = OS('Android', '9.0');

  Television tvA03 = Television('A-03', screen45, osSmartOS);
  Television tvA02 =
      Television('A-02', screen55, osSmartOS, serialNumber: '12345');
  Television tvA01 = Television.on(
      model: 'A-01', screen: screen65, os: osAndroid, serialNumber: '12345');

  tvA03.turnOn();
  tvA03.changeChannel(11);
  print(tvA03);

  tvA02.turnOn();
  tvA02.adjustVolume(75);
  print(tvA02);

  print(tvA01);
  tvA01.turnOff();
  print(tvA01);
}
