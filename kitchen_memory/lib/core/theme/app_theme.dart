import 'package:flutter/material.dart';
import 'package:kitchen_memory/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.lightPrimary,
    colorScheme: ColorScheme.light(
      primary: AppColors.lightPrimary,
      surface: AppColors.lightBackground,
      onSurface: AppColors.lightText,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.lightText),
    ),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.darkPrimary,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      surface: AppColors.darkBackground,
      onSurface: AppColors.darkText,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.darkText),
    ),
    useMaterial3: true,
  );
}
