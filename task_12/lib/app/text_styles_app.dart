import 'package:flutter/painting.dart';
import 'package:task_12/app/colors_app.dart';
import 'package:flutter/material.dart';

/// Текстовые стили
class AppStyle {
  static const titleBold18 = TextStyle(
    color: AppColors.chequeNumber,
    fontSize: 18.0,
    height: 24.0 / 18.0,
    fontWeight: FontWeight.w700,
  );

  static const textBold12h20 = TextStyle(
    color: AppColors.dark,
    fontSize: 12.0,
    height: 24.0 / 12.0,
    fontWeight: FontWeight.w700,
  );

  static const textBold16h20 = TextStyle(
    color: AppColors.white,
    fontSize: 16.0,
    height: 20.0 / 16.0,
    fontWeight: FontWeight.w700,
  );

  static const textBold16h24 = TextStyle(
    color: AppColors.dark,
    fontSize: 16.0,
    height: 24.0 / 16.0,
    fontWeight: FontWeight.w700,
  );

  static const textBold20h24 = TextStyle(
    color: AppColors.dark,
    fontSize: 20.0,
    height: 24.0 / 20.0,
    fontWeight: FontWeight.w700,
  );

  static const textRegular10 = TextStyle(
    color: AppColors.chequeDateTime,
    fontSize: 10.0,
    height: 16.0 / 10.0,
  );

  static const textRegular12h16 = TextStyle(
    color: AppColors.dark,
    fontSize: 12.0,
    height: 16.0 / 12.0,
  );

  static const textRegular16h24 = TextStyle(
    color: AppColors.dark,
    fontSize: 16.0,
    height: 24.0 / 16.0,
  );

  static const textRegular12h20 = TextStyle(
    color: AppColors.dark,
    fontSize: 12.0,
    height: 20.0 / 12.0,
  );

  static const textRegular12h20Line = TextStyle(
    color: AppColors.light,
    decoration: TextDecoration.lineThrough,
    fontSize: 12.0,
    height: 20.0 / 12.0,
  );

  static const tabSemiBold10 = TextStyle(
    color: AppColors.chequeDateTime,
    fontSize: 10.0,
    height: 16.0 / 10.0,
    letterSpacing: -0.24,
    fontWeight: FontWeight.w600,
  );
}
