class IconModel {
  final String? imageType;
  final String? imageUrl;
  final String? webpUrl;
  final num? aspectRatio;

  IconModel({
    required this.imageType,
    required this.imageUrl,
    required this.webpUrl,
    required this.aspectRatio,
  });

  factory IconModel.fromJson(Map<String, dynamic>? json) {
    return IconModel(
      imageType: json?['image_type'],
      imageUrl: json?['image_url'],
      webpUrl: json?['webp_url'],
      aspectRatio: json?['aspect_ratio'],
    );
  }
}
