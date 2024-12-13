import 'package:flutter/material.dart';

class CallToActionModel {
  final String? text;
  final String? type;
  final String? backgroundColor;
  final bool? isCircular;
  final bool? isSecondary;
  final num? strokeWidth;

  CallToActionModel({
    required this.text,
    required this.type,
    required this.backgroundColor,
    required this.isCircular,
    required this.isSecondary,
    required this.strokeWidth,
  });

  factory CallToActionModel.fromJson(Map<String, dynamic>? json) {
    return CallToActionModel(
      text: json?['text'],
      type: json?['type'],
      backgroundColor: json?['bg_color'],
      isCircular: json?['is_circular'],
      isSecondary: json?['is_secondary'],
      strokeWidth: json?['stroke_width'],
    );
  }

  Color get getColor {
    if (backgroundColor?.startsWith("#") ?? false) {
      return Color(int.parse(backgroundColor!.substring(1, 7), radix: 16) + 0xFF000000);
    } else {
      return Colors.black;
    }
  }
}