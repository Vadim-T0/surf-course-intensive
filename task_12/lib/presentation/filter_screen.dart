import 'package:flutter/material.dart';
import 'package:task_12/app/colors_app.dart';
import 'package:task_12/app/strings_app.dart';
import 'package:task_12/domain/entity/sorting_type.dart';
import 'package:task_12/app/text_styles_app.dart';
import 'package:task_12/app/icons_app.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Экран выбора типа сортировки.
class FilterScreen extends StatefulWidget {
  /// Начальный вариант сортировки.
  final SortingType filter;

  const FilterScreen({super.key, required this.filter});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  /// Текущий выбранный вариант сортировки.
  late SortingType _selectedFilter;

  @override
  void initState() {
    super.initState();

    /// При инициализации текущий вариант сортировки равен начальному.
    _selectedFilter = widget.filter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Графический элемент вверху окна.
          SizedBox(
            height: 8,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppIcons.rectangle,
                colorFilter:
                    const ColorFilter.mode(AppColors.light, BlendMode.srcIn),
              ),
            ),
          ),

          /// Заголовок и иконка закрытия окна.
          SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppStrings.sortingTitle,
                    style: AppStyle.textBold20h24,
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      AppIcons.close,
                      colorFilter: const ColorFilter.mode(
                          AppColors.dark, BlendMode.srcIn),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            /// Выводим типы и варианты сортировки.
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              itemCount: FilterType.values.length,
              itemBuilder: (context, index) {
                final type = FilterType.values[index];
                final sortingList =
                    SortingType.values.where((e) => e.type == type).toList();

                if (sortingList.isEmpty) return const SizedBox();

                final isLastType = index == FilterType.values.length - 1;

                return _FilterTypeWidget(
                  type: type,
                  sortingList: sortingList,
                  selectedFilter: _selectedFilter,
                  isLastType: isLastType,
                  onChanged: _onChanged,
                  onDone: _onPressedDone,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Если выбрали другой вариант сортировки, то запоминаем его и перерисовываем экран выбора сортировки.
  void _onChanged(SortingType? value) {
    if (value != null && value != _selectedFilter) {
      setState(() {
        _selectedFilter = value;
      });
    }
  }

  /// При нажатии на кнопку закрываем модальное окно и передаем вариант выбранной сортировки на предыдущий экран.
  void _onPressedDone() {
    Navigator.of(context).pop(_selectedFilter);
  }
}

/// Виджет для вывода типа сортировки и вариантов сортировки этого типа в виде радио-кнопок.
class _FilterTypeWidget extends StatelessWidget {
  /// Тип сортировки.
  final FilterType type;

  /// Список с вариантами сортировки этого типа.
  final List<SortingType> sortingList;

  /// Текущий выбранный варинт сортировки.
  final SortingType selectedFilter;

  /// Последний тип сортировки в выводе или нет.
  final bool isLastType;

  /// Функция вызываемая при смене выбранного варианта сортировки.
  final ValueChanged<SortingType?> onChanged;

  /// Функци вызываемая при нажатии на кнопку 'Готово'.
  final VoidCallback onDone;

  const _FilterTypeWidget({
    required this.type,
    required this.sortingList,
    required this.selectedFilter,
    required this.isLastType,
    required this.onChanged,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Если тип фильтра не равен FilterType.none, то выводим его имя.
        if (type != FilterType.none)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              type.name,
              style: AppStyle.textRegular12h20,
            ),
          ),

        /// Выводим варианты сортировки для данного типа в виджете радио-кнопок.
        ...sortingList.map((e) => RadioListTile<SortingType>(
              title: Text(
                e.name,
                style: AppStyle.textRegular16h24,
              ),
              value: e,
              groupValue: selectedFilter,
              onChanged: onChanged,
              activeColor: AppColors.green,
            )),

        /// Если тип сортировки не последний в выводе, то добавляем ниже разделитель.
        if (!isLastType)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: AppColors.divider,
            ),
          ),

        /// Если тип сортировки последний в выводе, то добавляем ниже кнопку 'Готово'.
        if (isLastType)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: onDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(AppStrings.sortingButtonOK,
                    style: AppStyle.textBold16h20),
              ),
            ),
          ),
      ],
    );
  }
}
