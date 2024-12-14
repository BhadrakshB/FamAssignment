import 'card_model.dart';

class CardGroup {
  final int id;
  final String? name;
  final String? designType;
  final int? cardType;
  final bool? isScrollable;
  final num? height;
  final bool? isFullWidth;
  final String? slug;
  final int? level;
  final List<CardModel?> cards;

  CardGroup({
    required this.id,
    required this.name,
    required this.designType,
    required this.cardType,
    required this.isScrollable,
    required this.height,
    required this.isFullWidth,
    required this.slug,
    required this.level,
    required this.cards,
  });

  factory CardGroup.fromJson(Map<String, dynamic>? json) {
    // print("JSON CARD GROUP: ${json?.keys}");
    return CardGroup(
      id: json?['id'],
      name: json?['name'],
      designType: json?['design_type'],
      cardType: json?['card_type'],
      isScrollable: json?['is_scrollable'],
      height: json?['height'],
      isFullWidth: json?['is_full_width'],
      slug: json?['slug'],
      level: json?['level'],
      cards: (json?['cards'] as List?)
          !.map((card) => CardModel.fromJson(card))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'CardGroup{id: $id, name: $name, designType: $designType, cardType: $cardType, isScrollable: $isScrollable, height: $height, isFullWidth: $isFullWidth, slug: $slug, level: $level, cards: $cards}';
  }
}
