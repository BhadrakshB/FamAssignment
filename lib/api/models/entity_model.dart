import 'package:flutter/material.dart';

class EntityModel {
  final String? text;
  final String? type;
  final String? color;
  final int? fontSize;
  final String? fontStyle;
  final String? fontFamily;

  EntityModel({
    required this.text,
    required this.type,
    required this.color,
    required this.fontSize,
    required this.fontStyle,
    required this.fontFamily,
  });

  factory EntityModel.fromJson(Map<String, dynamic>? json) {
    return EntityModel(
      text: json?['text'],
      type: json?['type'],
      color: json?['color'],
      fontSize: json?['font_size'],
      fontStyle: json?['font_style'],
      fontFamily: json?['font_family'],
    );
  }

  Color get getColor {
    if (color?.startsWith("#") ?? false) {
      // Remove the '#' if it exists
      final hex = color?.replaceAll('#', '');

      // Add 'FF' for full opacity if the code is only 6 characters (RGB)
      final validHex = hex?.length == 6 ? 'FF$hex' : hex;

      return Color(int.parse(validHex!, radix: 16));
    } else {
      return Colors.black;
    }
  }

  /// For time being we are using FontWeight for fontFamily
  /// This will be changed in future to use FontFamily

  FontWeight get getFontFamily {
    switch (fontFamily) {
      case 'met_bold':
        return FontWeight.w900;
      case 'met_regular':
        return FontWeight.normal;
      case 'met_semi_bold':
        return FontWeight.bold;
      default:
        return FontWeight.normal;
    }
  }

  dynamic get getStyling {
    switch (fontStyle) {
      case 'italic':
        return FontStyle.italic;
      case 'normal':
        return FontStyle.normal;

      // case 'underline':
      //   return TextDecoration.underline;

      default:
        return FontStyle.normal;
    }
  }

  double get getFontSize {
    return fontSize?.toDouble() ?? 16.0;
  }

  TextSpan get getTextSpan {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: getFontSize,
        fontWeight: getFontFamily,
        color: getColor,
        fontStyle: getStyling.runtimeType == FontStyle ? getStyling : null,
        decoration: getStyling.runtimeType == TextDecoration ? getStyling : null,
      ),
    );
  }


  @override
  String toString() {
    return 'EntityModel{text: $text, type: $type, color: $color, fontSize: $fontSize, fontStyle: $fontStyle, fontWeight: $fontFamily}';
  }

}