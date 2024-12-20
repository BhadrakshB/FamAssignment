import 'package:flutter/material.dart';

class IconModel {
  final String? imageType;
  final String? imageUrl;
  final String? assetType;
  final String? webpUrl;
  final num? aspectRatio;

  IconModel({
    required this.imageType,
    required this.imageUrl,
    required this.assetType,
    required this.webpUrl,
    required this.aspectRatio,
  });

  factory IconModel.fromJson(Map<String, dynamic>? json) {
    return IconModel(
      imageType: json?['image_type'],
      imageUrl: json?['image_url'],
      assetType: json?['asset_type'],
      webpUrl: json?['webp_url'],
      aspectRatio: json?['aspect_ratio'],
    );
  }

  @override
  String toString() {
    return 'IconModel{imageType: $imageType, imageUrl: $imageUrl, assetType: $assetType, webpUrl: $webpUrl, aspectRatio: $aspectRatio}';
  }
}
