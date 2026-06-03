import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      useMaterial3: true,
      fontFamily: 'sans-serif',
    );
  }
}
