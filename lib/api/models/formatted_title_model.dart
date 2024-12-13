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

}