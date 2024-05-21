import 'package:flutter/material.dart';
import 'package:task_12/app/strings_app.dart';

/// Виджет пустого экрана
class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.emptyScreen),
    );
  }
}
