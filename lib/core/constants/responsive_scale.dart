import 'package:flutter/material.dart';

class ResponsiveScale {
  const ResponsiveScale._();

  static const double _designWidth = 390;
  static const double _designHeight = 844;

  static double width(BuildContext context) {
    final ratio = MediaQuery.sizeOf(context).width / _designWidth;
    return ratio.clamp(0.82, 1.18);
  }

  static double height(BuildContext context) {
    final ratio = MediaQuery.sizeOf(context).height / _designHeight;
    return ratio.clamp(0.82, 1.18);
  }
}
