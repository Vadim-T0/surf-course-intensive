import 'package:flutter/material.dart';
import 'package:task_12/app/strings_app.dart';
import 'package:task_12/data/repository/shopping_list_repository.dart';
import 'package:task_12/presentation/tabs_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('ru_RU', null).then(
    (_) => runApp(const MyApp()),
  );
}

final shoppingListRepository = ShoppingListRepository();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.productList,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        fontFamily: 'Sora',
      ),

      /// Открываем экран с табами.
      home: const TabsScreen(),
    );
  }
}
