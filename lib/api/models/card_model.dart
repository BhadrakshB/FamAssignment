import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'background_image_model.dart';
import 'call_to_action_model.dart';
import 'formatted_title_model.dart';
import 'icon_model.dart';

class CardModel {
  final int id;
  final String? name;
  final String? slug;
  final String? title;
  final FormattedTextModel? formattedTitle;
  final String? description;
  final FormattedTextModel? formattedDescription;
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
    required this.description,
    required this.formattedDescription,
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
      formattedTitle: FormattedTextModel.fromJson(json?['formatted_title']),
      description: json?['description'],
      formattedDescription: FormattedTextModel.fromJson(json?['formatted_description']),
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

  Color? get getBackgroundColor {
    return backgroundColor == null ? null : Color(int.parse(backgroundColor!.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Object getIcon({bool isDecorationImage = true}) {
    try {
      if (icon?.imageType == 'ext') {
        return isDecorationImage ? NetworkImage(icon?.imageUrl! ?? "") : Image.network(icon?.imageUrl! ?? "", errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/placeholder.png'),);
      } else {
        return isDecorationImage ? AssetImage(icon?.assetType! ?? "") : Image.asset(icon?.assetType! ?? "");
      }
    } catch (e) {
      return isDecorationImage ? const AssetImage('/assets/images/placeholder.png') : Image.asset('/assets/images/placeholder.png');
    }
  }


  @override
  String toString() {
    return 'CardModel{id: $id, name: $name, slug: $slug, title: $title, formattedTitle: $formattedTitle, description: $description, formattedDescription: $formattedDescription, icon: $icon, positionalImages: $positionalImages, components: $components, url: $url, backgroundColor: $backgroundColor, iconSize: $iconSize, backgroundImage: $backgroundImage, callToAction: $callToAction, isDisabled: $isDisabled, isShareable: $isShareable, isInternal: $isInternal}';
  }
}
// The  EntityModel  class is a model class that represents an entity. It has three properties:  entityType ,  entityId , and  actionUrl . The  entityType  property is the type of the entity, the  entityId  property is the ID of the entity, and the  actionUrl  property is the URL for performing an action related to the entity. The  EntityModel  class also has a  factory  constructor that creates an instance of the class from a JSON object.