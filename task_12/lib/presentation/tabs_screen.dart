import 'package:flutter/material.dart';
import 'package:task_12/app/icons_app.dart';
import 'package:task_12/app/text_styles_app.dart';
import 'package:task_12/presentation/empty_screen.dart';
import 'package:task_12/presentation/cheque_screen.dart';
import 'package:task_12/app/colors_app.dart';
import 'package:task_12/app/strings_app.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Экран с навигацией

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 3;

  final List<Widget> _pages = const [
    EmptyScreen(),
    EmptyScreen(),
    EmptyScreen(),
    ChequeScreen(id: 56),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: IconWithColorFilter(
                assetName: AppIcons.article,
                index: 0,
                currentIndex: _currentIndex),
            label: AppStrings.iconArticle,
          ),
          BottomNavigationBarItem(
            icon: IconWithColorFilter(
                assetName: AppIcons.search,
                index: 1,
                currentIndex: _currentIndex),
            label: AppStrings.iconSearch,
          ),
          BottomNavigationBarItem(
            icon: IconWithColorFilter(
                assetName: AppIcons.cart,
                index: 2,
                currentIndex: _currentIndex),
            label: AppStrings.iconCart,
          ),
          BottomNavigationBarItem(
            icon: IconWithColorFilter(
                assetName: AppIcons.person,
                index: 3,
                currentIndex: _currentIndex),
            label: AppStrings.iconPerson,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme.cardColor,
        selectedItemColor: AppColors.green,
        unselectedItemColor: AppColors.graphite,
        selectedLabelStyle: AppStyle.tabSemiBold10,
        unselectedLabelStyle: AppStyle.tabSemiBold10,
      ),
    );
  }
}

/// Виджет для отображения иконки, на активном табе иконка будет подсвечиваться.
class IconWithColorFilter extends StatelessWidget {
  final String assetName;
  final int index;
  final int currentIndex;

  const IconWithColorFilter({
    super.key,
    required this.assetName,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: 24,
      colorFilter: ColorFilter.mode(
        currentIndex == index ? AppColors.green : AppColors.graphite,
        BlendMode.srcIn,
      ),
    );
  }
}
