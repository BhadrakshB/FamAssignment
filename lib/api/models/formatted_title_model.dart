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
      entities:
          (json?['entities'] as List?)?.map((entity) => EntityModel.fromJson(entity)).toList(),
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

  InlineSpan generateSpans() {
    final template = text ?? '';
    final replacements = entities?.map((entity) {
          final style = TextStyle(
            fontSize: entity?.getFontSize,
            color: entity?.getColor,
            fontWeight: entity?.getFontWeight,
            fontStyle: entity?.getStyling.runtimeType == FontStyle ? entity?.getStyling : null,
            decoration:
                entity?.getStyling.runtimeType == TextDecoration ? entity?.getStyling : null,
          );
          return {entity?.text ?? '': style};
        }).toList() ??
        [];
    final placeholderPattern = RegExp(r"\{\}");
    int index = 0;
    print(replacements);
    // Split the template into parts with matches and non-matches
    List<InlineSpan> spans = [];

    (text != " " || text != "" ) ?
        template.splitMapJoin(
      placeholderPattern,
      onMatch: (match) {
        // Add replacement with style
        if (index < replacements.length) {
          final replacement = replacements[index].keys.first;
          final style = replacements[index].values.first;

          if (replacement == "") {
            return '';
          }

          spans.add(const WidgetSpan(
              child: SizedBox(
            height: 70,
          )));

          spans.add(TextSpan(
            text: replacement,
            style: style,
          ));

          index++;
        }

        return ''; // No actual text is added here
      },
      onNonMatch: (nonMatch) {
        // Add plain text (non-placeholder text)
        spans.add(TextSpan(
            text: nonMatch, style: replacements.first.values.first.copyWith(color: Colors.white)));
        return ''; // No actual text is added here
      },
    ) : replacements.forEach((replacement) {
      final style = replacement.values.first;
      final text = replacement.keys.first;

      spans.add(TextSpan(
        text: text,
        style: style,
      ));
    });



    print(spans.length);
    print(spans);

    spans.removeWhere((element) => element.toPlainText() == " " || element.toPlainText() == "");

    print(spans.length);
    print(spans);

    return TextSpan(children: spans);
  }
}
