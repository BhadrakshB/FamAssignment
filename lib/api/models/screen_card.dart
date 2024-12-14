import 'card_group.dart';

class ScreenCard {
  final int id;
  final String? slug;
  final String? title;
  final String? formattedTitle;
  final String? description;
  final String? formattedDescription;
  final String? assets;
  final List<CardGroup?> hcGroups;

  ScreenCard({
    required this.id,
    required this.slug,
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.assets,
    required this.hcGroups,
  });

  factory ScreenCard.fromJson(Map<String, dynamic>? json) {
    return ScreenCard(
      id: json?['id'],
      slug: json?['slug'],
      title: json?['title'],
      formattedTitle: json?['formatted_title'],
      description: json?['description'],
      formattedDescription: json?['formatted_description'],
      assets: json?['assets'],
      hcGroups: (json?['hc_groups'] as List)
          .map((card) => CardGroup.fromJson(card))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'ScreenCard{id: $id, slug: $slug, title: $title, formattedTitle: $formattedTitle, description: $description, formattedDescription: $formattedDescription, assets: $assets, hcGroups: $hcGroups}';
  }
}
// The  CardGroup  class is a model class that represents a group of cards. It has three properties:  name ,  isScrollable , and  cards . The  name  property is the name of the card group, the  isScrollable  property indicates whether the card group is scrollable, and the  cards  property is a list of  CardModel  objects.