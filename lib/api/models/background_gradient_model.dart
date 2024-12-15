import 'dart:math';

import 'package:flutter/material.dart';

class BackgroundGradientModel {
  final num angle;
  final List<String?>? colors;

  BackgroundGradientModel({
    required this.angle,
    required this.colors,
  });

  factory BackgroundGradientModel.fromJson(Map<String, dynamic>? json) {
    return BackgroundGradientModel(
      angle: json?['angle'] ?? 0.0,
      colors: json?['colors']?.cast<String?>(),
    );
  }

  dynamic get getGradient {
    try {
      if (colors != null) {
        print('Angle: $angle');
        // Convert angle to radians
        double angleInRadians = angle * (pi / 180);

        // Calculate the start and end points
        double x = cos(angleInRadians);
        double y = sin(angleInRadians);

        return LinearGradient(
          begin: Alignment(x, -y),
          end: Alignment(-x, y),
          colors: (colors)!.map((color) => color!.toColors).toList(),
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF000000), Color(0xFF000000)],
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp,
      );
    }
  }

  @override
  String toString() {
    return 'BackgroundGradientModel{angle: $angle, colors: $colors}';
  }
}

extension colorsFromString on String {
  Color get toColors {
    if (startsWith("#") ?? false) {
      // Remove the '#' if it exists
      final hex = replaceAll('#', '');

      // Add 'FF' for full opacity if the code is only 6 characters (RGB)
      final validHex = hex.length == 6 ? 'FF$hex' : hex;

      return Color(int.parse(validHex, radix: 16));
    } else {
      return Colors.black;
    }
  }
}