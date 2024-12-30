class ImageResource {
  final String imageType;
  final String imageUrl;
  final double aspectRatio;

  ImageResource({
    required this.imageType,
    required this.imageUrl,
    required this.aspectRatio,
  });

  factory ImageResource.fromJson(Map<String, dynamic> json) => ImageResource(
        imageType: json["image_type"] ?? '',
        imageUrl: json["image_url"] ?? '',
        aspectRatio: json["aspect_ratio"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "image_type": imageType,
        "image_url": imageUrl,
        "aspect_ratio": aspectRatio,
      };
}
