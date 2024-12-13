import 'background_image_model.dart';
import 'call_to_action_model.dart';
import 'formatted_title_model.dart';
import 'icon_model.dart';

class CardModel {
  final int id;
  final String? name;
  final String? slug;
  final String? title;
  final FormattedTitleModel? formattedTitle;
  final IconModel? icon;
  final List<String?>? positionalImages;
  final List<String?>? components;
  final String? url;
  final String? backgroundColor;
  final int? iconSize;
  final BackgroundImageModel? backgroundImage;
  final List<CallToActionModel?>? callToAction;
  final bool? isDisabled;
  final bool? isShareable;
  final bool? isInternal;

  CardModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.title,
    required this.formattedTitle,
    required this.icon,
    required this.positionalImages,
    required this.components,
    required this.url,
    required this.backgroundColor,
    required this.iconSize,
    required this.backgroundImage,
    required this.callToAction,
    required this.isDisabled,
    required this.isShareable,
    required this.isInternal,
  });

  factory CardModel.fromJson(Map<String, dynamic>? json) {
    print("JSON CARD MODEL: ${json?.keys}");
    return CardModel(
      id: json?['id'],
      name: json?['name'],
      slug: json?['slug'],
      title: json?['title'],
      formattedTitle: FormattedTitleModel.fromJson(json?['formatted_title']),
      icon: json?['icon'] != null ? IconModel.fromJson(json?['icon']) : null,
      positionalImages: List<String?>.from(json?['positional_images']),
      components: List<String?>.from(json?['components']),
      url: json?['url'],
      backgroundColor: json?['bg_color'],
      iconSize: json?['icon_size'],
      backgroundImage: BackgroundImageModel.fromJson(json?['bg_image']),
      callToAction: (json?['cta'] as List?)
          ?.map((cta) => CallToActionModel.fromJson(cta))
          .toList(),
      isDisabled: json?['is_disabled'],
      isShareable: json?['is_shareable'],
      isInternal: json?['is_internal'],
    );
  }
}
// The  EntityModel  class is a model class that represents an entity. It has three properties:  entityType ,  entityId , and  actionUrl . The  entityType  property is the type of the entity, the  entityId  property is the ID of the entity, and the  actionUrl  property is the URL for performing an action related to the entity. The  EntityModel  class also has a  factory  constructor that creates an instance of the class from a JSON object.