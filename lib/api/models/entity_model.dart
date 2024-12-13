import 'package:flutter/material.dart';

class EntityModel {
  final String? text;
  final String? type;
  final String? color;
  final int? fontSize;
  final String? fontStyle;
  final String? fontWeight;

  EntityModel({
    required this.text,
    required this.type,
    required this.color,
    required this.fontSize,
    required this.fontStyle,
    required this.fontWeight,
  });

  factory EntityModel.fromJson(Map<String, dynamic>? json) {
    return EntityModel(
      text: json?['text'],
      type: json?['type'],
      color: json?['color'],
      fontSize: json?['font_size'],
      fontStyle: json?['font_style'],
      fontWeight: json?['font_weight'],
    );
  }

  Color get getColor {
    if (color?.startsWith("#") ?? false) {
      return Color(int.parse(color!.substring(1, 7), radix: 16) + 0xFF000000);
    } else {
      return Colors.black;
    }
  }

  FontWeight get getFontWeight {
    switch (fontWeight) {
      case 'met_bold':
        return FontWeight.bold;
      case 'met_regular':
        return FontWeight.normal;
      case 'met_semi_bold':
        return FontWeight.w500;
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

      case 'underline':
        return TextDecoration.underline;

      default:
        return FontStyle.normal;
    }
  }

  double get getFontSize {
    return fontSize!.toDouble();
  }


}