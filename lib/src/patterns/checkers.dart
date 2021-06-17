import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class Checkers extends Pattern {
  /// The [Pattern]'s background color.
  final Color bgColor;

  /// The [Pattern]'s foreground color (for the stripes, dots, squares, etc.).
  final Color fgColor;
  final int squaresCount = 40;
  String get description => "Checkers";

  /// Paints a [Pattern] made of 40 squares across the largest side
  /// with alternating colors.
  ///
  /// Example:
  ///
  /// ```dart
  /// Checkers(bgColor: Colors.yellow, fgColor: Colors.black).paintOnPath(canvas, size, path);
  /// ```
  const Checkers({required this.bgColor, required this.fgColor})
      : super(
            patternType: PatternType.checkers,
            bgColor: bgColor,
            fgColor: fgColor);

  void paintWithPattern(
      Canvas canvas, double x, double y, double width, double height) {
    final maxDimension = max(width, height);
    var rectSide = maxDimension / squaresCount;
    var horizontalSquaresCount = width / rectSide;
    var verticalSquaresCount = height / rectSide;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);

    var dx = 0.0, dy = 0.0;
    final rectsPath = Path();
    for (var j = 0; j < verticalSquaresCount; j++) {
      for (var i = 0; i < horizontalSquaresCount; i++) {
        if (i % 2 == 0 && j % 2 != 0 || i % 2 != 0 && j % 2 == 0) {
          final rectX = x + dx;
          final rectY = y + dy;
          final innerRect = Rect.fromLTWH(rectX, rectY, rectSide, rectSide);
          rectsPath.addRect(innerRect);
        }
        dx += rectSide;
      }
      dy += rectSide;
      dx = 0;
    }
    paint
      ..style = PaintingStyle.fill
      ..color = fgColor;
    canvas.drawPath(rectsPath, paint);
  }
}
