import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_12/domain/entity/product_entity.dart';
import 'package:task_12/utils/extension/amount_x.dart';
import 'package:task_12/utils/extension/decimal_x.dart';
import 'package:task_12/utils/extension/price_and_discount_x.dart';
import 'package:task_12/app/colors_app.dart';
import 'package:task_12/app/text_styles_app.dart';
import 'package:task_12/app/icons_app.dart';

/// Виджет для вывода информации про продукту (изображение, название, объем, скидка, цена).
class ProductWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 68,
                height: 68,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return SvgPicture.asset(AppIcons.restraunt,
                          fit: BoxFit.cover);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32.0,
                    child: Text(
                      product.title,
                      style: AppStyle.textRegular12h16,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getAmount(product.amount),
                        style: AppStyle.textRegular12h20,
                      ),
                      Row(
                        children: [
                          if (product.sale > 0) ...[
                            Text(
                              product.decimalPrice.toFormattedCurrency(),
                              style: AppStyle.textRegular12h20Line,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              calculateDiscountForProduct(
                                product.decimalPrice,
                                product.sale.toString(),
                              ).toFormattedCurrency(),
                              style: AppStyle.textBold12h20
                                  .copyWith(color: AppColors.red),
                            ),
                          ] else if (product.sale == 0) ...[
                            Text(
                              product.decimalPrice.toFormattedCurrency(),
                              style: AppStyle.textBold12h20,
                            ),
                          ]
                        ],
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
