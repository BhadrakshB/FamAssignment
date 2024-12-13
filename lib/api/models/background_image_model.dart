import 'package:flutter/material.dart';

class BackgroundImageModel {
  final String? imageType;
  final String? imageUrl;
  final String? assetType;
  final String? webpUrl;
  final num? aspectRatio;

  BackgroundImageModel({
    required this.imageType,
    required this.imageUrl,
    required this.assetType,
    required this.webpUrl,
    required this.aspectRatio,
  });

  factory BackgroundImageModel.fromJson(Map<String, dynamic>? json) {
    return BackgroundImageModel(
      imageType: json?['image_type'],
      imageUrl: json?['image_url'],
      assetType: json?['asset_type'],
      webpUrl: json?['webp_url'],
      aspectRatio: json?['aspect_ratio'],
    );
  }

  Object getImage({bool isDecorationImage = true}) {
    try {
      if (imageType == 'ext') {
        return isDecorationImage ? NetworkImage(imageUrl!) : Image.network(imageUrl!, errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/placeholder.png'),);
      } else {
        return isDecorationImage ? AssetImage(assetType!) : Image.asset(assetType!);
      }
    } catch (e) {
      return isDecorationImage ? const AssetImage('assets/images/placeholder.png') : Image.asset('assets/images/placeholder.png');
    }
  }
}