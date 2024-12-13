import 'package:flutter/material.dart';

class ColorUtils {
  /// Converts a hex color string (e.g., `#FF5733`) into a [Color] object.
  static Color fromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Add alpha if missing
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  /// Converts a list of hex strings into a [LinearGradient].
  static LinearGradient fromGradient(List<String?> hexColors) {
    return LinearGradient(
      colors: hexColors.map((color) => fromHex(color ?? '')).toList(),
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
