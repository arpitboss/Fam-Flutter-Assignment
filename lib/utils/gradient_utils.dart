import 'dart:math';

import 'package:fam_flutter_assignment/models/gradient_model.dart';
import 'package:flutter/material.dart';

import 'color_utils.dart';

LinearGradient convertHexToGradient(GradientModel bgGradient) {
  final radians = bgGradient.angle * (pi / 180);

  final Alignment start = Alignment(
    -1 * cos(radians),
    -1 * sin(radians),
  );
  final Alignment end = Alignment(
    cos(radians),
    sin(radians),
  );

  return LinearGradient(
    begin: start,
    end: end,
    colors: bgGradient.colors
        .map((hexColor) => convertHexToColor(hexColor))
        .toList(),
  );
}
