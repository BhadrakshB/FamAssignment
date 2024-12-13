import 'package:flutter/material.dart';

import 'entity_model.dart';

class FormattedTitleModel {
  final String? text;
  final String? align;
  final List<EntityModel?>? entities;

  FormattedTitleModel({
    required this.text,
    required this.align,
    required this.entities,
  });

  factory FormattedTitleModel.fromJson(Map<String, dynamic>? json) {
    return FormattedTitleModel(
      text: json?['text'],
      align: json?['align'],
      entities: (json?['entities'] as List?)
          ?.map((entity) => EntityModel.fromJson(entity))
          .toList(),
    );
  }


  CrossAxisAlignment get getCrossAxisAlignment {
    switch (align) {
      case 'center':
        return CrossAxisAlignment.center;
      case 'right':
        return CrossAxisAlignment.end;
      case 'left':
        return CrossAxisAlignment.start;
      default:
        return CrossAxisAlignment.start;
    }
  }



}