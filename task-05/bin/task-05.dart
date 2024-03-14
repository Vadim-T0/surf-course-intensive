class PokerPlayer {
  /// Список текущих карт в руке у игрока
  List<String> _currentHand = ['King of clubs', 'Nine of hearts'];

  /// Субъективная оценка выигрыша
  double _surenessInWin = 0;

  /// Вычислить шансы на выигрыш
  void calculateProbabilities(
    List<String> cardOnDesk,

    /// Это часть первого задания. [Strategy] пока не сущестивует.
    ///
    /// Опишите его.
    Strategy strategy,
  ) =>
      _surenessInWin = strategy(cardOnDesk, _currentHand);
}

typedef Strategy = double Function(List<String> p0, List<String> p1);

void main() {
  final opponent = PokerPlayer();

  /// Это часть первого задания. [Strategy] пока не сущестивует.
  ///
  /// Опишите его.
  final Strategy fakeStrategy = (p0, p1) {
    print('Карты на столе: ${p0.join(', ')}');
    print('Карты противника: ${p1.join(', ')}');
    return 0.5;
  };

  opponent.calculateProbabilities(
    ['Nine of diamonds', 'king of hearts'],
    fakeStrategy,
  );
}
