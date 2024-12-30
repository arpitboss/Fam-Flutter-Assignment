import 'image_resource_model.dart';

class ImagePosition {
  final ImageResource image;
  final String position;

  ImagePosition({
    required this.image,
    required this.position,
  });

  factory ImagePosition.fromJson(Map<String, dynamic> json) => ImagePosition(
        image: ImageResource.fromJson(json["image"] ?? {}),
        position: json["position"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "image": image.toJson(),
        "position": position,
      };
}
