import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Animation Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double _myWidgetHeight = 130;
  double _myWidgetWidth = 130;

  late Size _screenSize;
  double _coordinateX = 0;
  double _coordinateY = 0;

  Color _myWidgetColor = Colors.red;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Инициализация контроллера анимации
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    // Определение анимации вращения
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

// Меняем цвет и размер нашего виджета
  void _changeColor() {
    setState(() {
      _myWidgetColor =
          Colors.primaries[Random().nextInt(Colors.primaries.length)];
      _myWidgetHeight = Random().nextDouble() * 200;
      _myWidgetWidth = Random().nextDouble() * 200;
    });
  }

// Обновляем коородинаты
  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _coordinateX += details.delta.dx;
      _coordinateY += details.delta.dy;
    });
  }

// Запускаем или останавливаем вращение
  void _onLongPress() {
    if (!_controller.isAnimating) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenSize = MediaQuery.of(context).size;
    _coordinateX = _screenSize.width / 2 - _myWidgetWidth / 2;
    _coordinateY = _screenSize.height / 2 - _myWidgetHeight / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Positioned(
            left: _coordinateX,
            top: _coordinateY,
            child: RotationTransition(
              turns: _animation,
              child: AnimatedContainer(
                color: _myWidgetColor,
                height: _myWidgetHeight,
                width: _myWidgetWidth,
                duration: Duration(milliseconds: 800),
                curve: Curves.fastEaseInToSlowEaseOut,
              ),
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _changeColor,
              onPanUpdate: _onPanUpdate,
              onLongPress: _onLongPress,
            ),
          )
        ],
      ),
    );
  }
}
