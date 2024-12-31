import 'package:flutter/material.dart';

import 'constants/app_colors.dart';

Color convertHexToColor(String? hexColor) {
  if (hexColor == null || hexColor.isEmpty) return AppColors.blackColor;
  hexColor = hexColor.replaceFirst('#', '');
  if (hexColor.length == 6) {
    return Color(int.parse('FF$hexColor', radix: 16));
  } else if (hexColor.length == 8) {
    return Color(int.parse(hexColor, radix: 16));
  }
  return AppColors.blackColor;
}
