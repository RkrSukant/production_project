import 'package:flutter/material.dart';
import 'package:furnihome_ar/utils/colors.dart';

@immutable
class AppTheme {
  static const colors = AppColors();

  const AppTheme._();

  static ThemeData define() {
    return ThemeData(
        fontFamily: 'Inter',
        primaryColor: colors.backGroundColor,
        scaffoldBackgroundColor: colors.backGroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: colors.secondaryColor)
            .copyWith(surface: colors.backGroundColor));
  }
}
