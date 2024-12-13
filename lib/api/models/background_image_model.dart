import 'package:flutter/material.dart';

class BackgroundImageModel {
  final String imageType;
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

  Image get getImage {
    if (imageType == 'ext') {
      return Image.network(imageUrl!);
    } else {
      return Image.network(assetType!);
    }
  }
}