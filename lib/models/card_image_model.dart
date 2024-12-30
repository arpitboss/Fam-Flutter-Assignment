class CardImage {
  final String imageType;
  final String? assetType;
  final String? imageUrl;
  final double? aspectRatio;

  CardImage({
    required this.imageType,
    this.assetType,
    this.imageUrl,
    this.aspectRatio,
  });

  factory CardImage.fromJson(Map<String, dynamic> json) {
    return CardImage(
      imageType: json['image_type'] ?? '',
      assetType: json['asset_type'],
      imageUrl: json['image_url'],
      aspectRatio: json['aspect_ratio']?.toDouble(),
    );
  }
}
