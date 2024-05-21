import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_12/main.dart';
import 'package:task_12/domain/entity/category_type.dart';
import 'package:task_12/domain/entity/cheque_entity.dart';
import 'package:task_12/domain/entity/sorting_type.dart';
import 'package:task_12/presentation/empty_screen.dart';
import 'package:task_12/presentation/filter_screen.dart';
import 'package:task_12/utils/extension/date_time_x.dart';
import 'package:task_12/utils/extension/products_list_x.dart';
import 'package:task_12/app/colors_app.dart';
import 'package:task_12/app/text_styles_app.dart';
import 'package:task_12/app/icons_app.dart';
import 'package:task_12/app/strings_app.dart';
import 'package:task_12/widgets/loading_widget.dart';
import 'package:task_12/widgets/category_widget.dart';
import 'package:task_12/widgets/no_category_widget.dart';

/// Экран с чеком.
class ChequeScreen extends StatefulWidget {
  /// Номер чека.
  final int id;

  const ChequeScreen({super.key, required this.id});

  @override
  State<ChequeScreen> createState() => _ChequeScreenState();
}

class _ChequeScreenState extends State<ChequeScreen> {
  /// Будущие данные по чеку.
  Future<ChequeEntity>? _data;

  @override
  void initState() {
    super.initState();
    _load();
  }

  /// Получаем чек.
  Future<void> _load() async {
    _data = shoppingListRepository.getCheque(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    /// Загружаем модель чека и открываем экран с чеком.
    return FutureBuilder<ChequeEntity>(
      future: _data,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const _ErrorWidget();
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            return data != null
                ? _ContentWidget(data: data)
                : const EmptyScreen();
          }
        }
        return const LoadingWidget();
      },
    );
  }
}

class _ContentWidget extends StatefulWidget {
  /// Данные чека.
  final ChequeEntity data;

  const _ContentWidget({required this.data});

  @override
  State<_ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<_ContentWidget> {
  /// Текущий метод сортировки.
  SortingType _currentFilter = SortingType.none;

  /// Состояние загрузки данных.
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar с номером и датой чека, заголовком списка и иконкой 'Сортировка'.
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        leading: Center(
          child: SvgPicture.asset(
            AppIcons.blue,
            colorFilter:
                const ColorFilter.mode(AppColors.green, BlendMode.srcIn),
          ),
        ),
        title: Column(
          children: [
            Text('${AppStrings.chequeNumber} ${widget.data.id} ',
                style: AppStyle.titleBold18),
            Text(
              widget.data.date.toStringDateAndTime(),
              style: AppStyle.textRegular10,
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    AppStrings.productList,
                    style: AppStyle.titleBold18,
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    _currentFilter == SortingType.none
                        ? AppIcons.sort
                        : AppIcons.sorton,
                  ),

                  /// При нажатии на инконку 'Сортировка' открываем модальное окно с выбором метода сортировки.
                  onPressed: () {
                    _onPressedFilter();
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      /// Если загрузились, то выводим содержимое чека.
      body: _isLoading ? const LoadingWidget() : _buildContent(),
    );
  }

  /// Модальное окно с выбором метода сортировки.
  Future<void> _onPressedFilter() async {
    final SortingType? filter = await showFlexibleBottomSheet(
      initHeight: 0.8,
      bottomSheetColor: Colors.transparent,
      bottomSheetBorderRadius:
          const BorderRadius.vertical(top: Radius.circular(24.0)),
      context: context,
      builder: (_, __, ___) => FilterScreen(filter: _currentFilter),
      isExpand: true,
    );

    if (filter == null) return;

    if (filter != _currentFilter) {
      setState(() {
        _isLoading = true;
      });

      /// Имитация задержки
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _currentFilter = filter;
        _isLoading = false;
      });
    }
  }

  /// Список продуктов с учетом метода сортировки.
  Widget _buildContent() {
    if (_currentFilter == SortingType.typeFromA ||
        _currentFilter == SortingType.typeFromZ) {
      /// Делаем список уникальных категорий отсортированных по текущему методу сортировки.
      final categoryProductsSorted =
          widget.data.products.sortByFilter(_currentFilter);

      Set<Category> uniqueCategoriesSet =
          categoryProductsSorted.map((product) => product.category).toSet();

      List<Category> uniqueCategoriesList = uniqueCategoriesSet.toList();

      /// Вывод списка продуктов с категориями.
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        itemBuilder: (_, i) {
          final category = uniqueCategoriesList[i];
          final categoryProducts = widget.data.products
              .where((product) => product.category == category)
              .toList();

          final isLastCat = i == uniqueCategoriesList.length - 1;

          return categoryProducts.isNotEmpty
              ? CategoryWidget(
                  category: category.name,
                  productsOfCategory: categoryProducts,
                  products: widget.data.products,
                  isLastCat: isLastCat,
                )
              : const SizedBox();
        },
        itemCount: uniqueCategoriesList.length,
      );
    } else {
      /// Вывод списка продуктов без категорий.
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        itemBuilder: (_, i) {
          return NoCategoryWidget(
            products: widget.data.products,
            filter: _currentFilter,
          );
        },
        itemCount: 1,
      );
    }
  }
}

// /// Виджет для вывод списка продуктов из категории.
// class _CategoryWidget extends StatelessWidget {
//   /// Имя категории
//   final String category;

//   /// Список продуктов этой категории.
//   final List<ProductEntity> productsOfCategory;

//   /// Список продуктов для финансового виджета.
//   final List<ProductEntity> products;

//   /// Последния категория в выводе или нет.
//   final bool isLastCat;

//   const _CategoryWidget({
//     required this.category,
//     required this.productsOfCategory,
//     required this.products,
//     required this.isLastCat,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         /// Выводим название категории и ее продукты.
//         Text(category),
//         ...productsOfCategory.map((e) => ProductWidget(product: e)),
//         if (!isLastCat)
//           const Divider(
//             color: AppColors.divider,
//           ),

//         /// Если категория последняя в выводе, то ниже выводим финансовый виджет.
//         if (isLastCat)
//           FinancialWidget(
//             products: products,
//           ),
//       ],
//     );
//   }
// }

// /// Виджет для вывод списка продуктов без категорий.
// class _NoCategoryWidget extends StatelessWidget {
//   /// Список продуктов.
//   final List<ProductEntity> products;

//   /// Тип сортировки.
//   final SortingType filter;

//   const _NoCategoryWidget({
//     required this.products,
//     required this.filter,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,

//       /// Выводим список отсортированных продуктов и финансовый виджет.
//       children: [
//         ...products.sortByFilter(filter).map((e) => ProductWidget(product: e)),
//         FinancialWidget(
//           products: products,
//         ),
//       ],
//     );
//   }
// }

// /// Виджет для вывода информации про продукту (изображение, название, объем, скидка, цена).
// class _ProductWidget extends StatelessWidget {
//   final ProductEntity product;

//   const _ProductWidget({
//     required this.product,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 16.0),
//         SizedBox(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: 68,
//                 height: 68,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: Image.network(
//                     product.imageUrl,
//                     fit: BoxFit.cover,
//                     errorBuilder: (BuildContext context, Object exception,
//                         StackTrace? stackTrace) {
//                       return SvgPicture.asset(AppIcons.restraunt,
//                           fit: BoxFit.cover);
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12.0),
//               Expanded(
//                   child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 32.0,
//                     child: Text(
//                       product.title,
//                       style: AppStyle.textRegular12h16,
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         getAmount(product.amount),
//                         style: AppStyle.textRegular12h20,
//                       ),
//                       Row(
//                         children: [
//                           if (product.sale > 0) ...[
//                             Text(
//                               product.decimalPrice.toFormattedCurrency(),
//                               style: AppStyle.textRegular12h20Line,
//                             ),
//                             const SizedBox(width: 16),
//                             Text(
//                               calculateDiscountForProduct(
//                                 product.decimalPrice,
//                                 product.sale.toString(),
//                               ).toFormattedCurrency(),
//                               style: AppStyle.textBold12h20
//                                   .copyWith(color: AppColors.red),
//                             ),
//                           ] else if (product.sale == 0) ...[
//                             Text(
//                               product.decimalPrice.toFormattedCurrency(),
//                               style: AppStyle.textBold12h20,
//                             ),
//                           ]
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               ))
//             ],
//           ),
//         ),
//         const SizedBox(height: 16.0),
//       ],
//     );
//   }
// }

// /// Финансовый виджет (итоговые суммы со скидкой и без).
// class _FinancialWidget extends StatelessWidget {
//   final List<ProductEntity> products;

//   const _FinancialWidget({required this.products});

//   @override
//   Widget build(BuildContext context) {
//     final fullTotal = getFullTotal(products);
//     final discount = getDiscount(products);
//     final total = fullTotal - discount;
//     final discountPercent = calculateDiscountForAmount(fullTotal, discount);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Divider(
//           color: AppColors.divider,
//         ),
//         const SizedBox(height: 24.0),
//         const Text(AppStrings.yourPurchase, style: AppStyle.textBold16h24),
//         const SizedBox(height: 8.0),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               _plural(products.length),
//               style: AppStyle.textRegular12h20,
//             ),
//             Text(
//               fullTotal.toFormattedCurrency(),
//               style: AppStyle.textBold12h20,
//             )
//           ],
//         ),
//         const SizedBox(height: 11.0),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               '${AppStrings.discount} $discountPercent%',
//               style: AppStyle.textRegular12h20,
//             ),
//             Text(
//               '-${discount.toFormattedCurrency()}',
//               style: AppStyle.textBold12h20,
//             )
//           ],
//         ),
//         const SizedBox(height: 11.0),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               AppStrings.amount,
//               style: AppStyle.textBold16h24,
//             ),
//             Text(
//               total.toFormattedCurrency(),
//               style: AppStyle.textBold16h24,
//             )
//           ],
//         ),
//         const SizedBox(height: 40.0),
//       ],
//     );
//   }

//   /// Склонение слова 'товар'
//   String _plural(int count) {
//     return Intl.plural(
//       count,
//       zero: 'Нет товаров',
//       one: '$count товар',
//       few: '$count товара',
//       many: '$count товаров',
//       other: '$count товара',
//       locale: 'ru',
//     );
//   }
// }

// /// Виджет с индикатором загрузки.
// class _LoadingWidget extends StatelessWidget {
//   const _LoadingWidget();

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }

/// Виджет ошибки.
class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.error),
    );
  }
}
