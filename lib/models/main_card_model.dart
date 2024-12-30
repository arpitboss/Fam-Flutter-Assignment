import 'package:fam_flutter_assignment/models/gradient_model.dart';
import 'package:fam_flutter_assignment/models/image_position_model.dart';

import 'call_to_action_model.dart';
import 'component_structure_model.dart';
import 'image_resource_model.dart';
import 'text_format_model.dart';

class CardModel {
  final int id;
  final String name;
  final String slug;
  final String? title;
  final FormattedText? formattedTitle;
  final List<ImagePosition> positionalImages;
  final List<ComponentStructure> components;
  final String? url;
  final ImageResource? bgImage;
  final List<CTA> cta;
  final bool isDisabled;
  final bool isShareable;
  final bool isInternal;
  final ImageResource? icon;
  final String? bgColor;
  final int? iconSize;
  final GradientModel? bgGradient;
  final String? description;
  final FormattedText? formattedDescription;

  CardModel({
    required this.id,
    required this.name,
    required this.slug,
    this.title,
    this.formattedTitle,
    required this.positionalImages,
    required this.components,
    this.url,
    this.bgImage,
    required this.cta,
    required this.isDisabled,
    required this.isShareable,
    required this.isInternal,
    this.icon,
    this.bgColor,
    this.iconSize,
    this.bgGradient,
    this.description,
    this.formattedDescription,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        slug: json["slug"] ?? "",
        title: json["title"] ?? "",
        formattedTitle: json["formatted_title"] != null
            ? FormattedText.fromJson(json["formatted_title"])
            : null,
        positionalImages: json["positional_images"] != null
            ? List<ImagePosition>.from(
                json["positional_images"].map((x) => ImagePosition.fromJson(x)))
            : [],
        components: json["components"] != null
            ? List<ComponentStructure>.from(
                json["components"].map((x) => ComponentStructure.fromJson(x)))
            : [],
        url: json["url"],
        bgImage: json["bg_image"] != null
            ? ImageResource.fromJson(json["bg_image"])
            : null,
        cta: json["cta"] != null
            ? List<CTA>.from(json["cta"].map((x) => CTA.fromJson(x)))
            : [],
        isDisabled: json["is_disabled"] ?? false,
        isShareable: json["is_shareable"] ?? false,
        isInternal: json["is_internal"] ?? false,
        icon:
            json["icon"] != null ? ImageResource.fromJson(json["icon"]) : null,
        bgColor: json["bg_color"] ?? "",
        iconSize: json["icon_size"] ?? 0,
        bgGradient: json["bg_gradient"] != null
            ? GradientModel.fromJson(json["bg_gradient"])
            : null,
        description: json["description"] ?? "",
        formattedDescription: json["formatted_description"] != null
            ? FormattedText.fromJson(json["formatted_description"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "title": title,
        "formatted_title": formattedTitle?.toJson(),
        "positional_images":
            List<dynamic>.from(positionalImages.map((x) => x.toJson())),
        "components": List<dynamic>.from(components.map((x) => x.toJson())),
        "url": url,
        "bg_image": bgImage?.toJson(),
        "cta": List<dynamic>.from(cta.map((x) => x.toJson())),
        "is_disabled": isDisabled,
        "is_shareable": isShareable,
        "is_internal": isInternal,
        "icon": icon?.toJson(),
        "bg_color": bgColor,
        "icon_size": iconSize,
        "bg_gradient": bgGradient?.toJson(),
        "description": description,
        "formatted_description": formattedDescription?.toJson(),
      };
}
