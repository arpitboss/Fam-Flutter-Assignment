import 'dart:convert';

import 'hcg_model.dart';
import 'text_format_model.dart';

enum DesignType {
  HC1,
  HC3,
  HC5,
  HC6,
  HC9;

  factory DesignType.fromString(String type) {
    return DesignType.values.firstWhere(
      (e) => e.toString() == 'DesignType.$type',
      orElse: () => HC1,
    );
  }
}

List<CardGroup> contextualCardsFromJson(String str) =>
    List<CardGroup>.from(json.decode(str).map((x) => CardGroup.fromJson(x)));

String contextualCardsToJson(List<CardGroup> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardGroup {
  final int id;
  final String slug;
  final String? title;
  final FormattedText? formattedTitle;
  final String? description;
  final FormattedText? formattedDescription;
  final Map<String, dynamic>? assets;
  final List<HCG> hcGroups;

  CardGroup({
    required this.id,
    required this.slug,
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.assets,
    required this.hcGroups,
  });

  CardGroup copyWith({
    int? id,
    String? slug,
    String? title,
    FormattedText? formattedTitle,
    String? description,
    FormattedText? formattedDescription,
    Map<String, dynamic>? assets,
    List<HCG>? hcGroups,
  }) =>
      CardGroup(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        title: title ?? this.title,
        formattedTitle: formattedTitle ?? this.formattedTitle,
        description: description ?? this.description,
        formattedDescription: formattedDescription ?? this.formattedDescription,
        assets: assets ?? this.assets,
        hcGroups: hcGroups ?? this.hcGroups,
      );

  factory CardGroup.fromJson(Map<String, dynamic> json) => CardGroup(
        id: json['id'],
        slug: json['slug'],
        title: json['title'],
        formattedTitle: json["formatted_title"] != null
            ? FormattedText.fromJson(json["formatted_title"])
            : null,
        description: json['description'] ?? '',
        formattedDescription: json["formatted_description"] != null
            ? FormattedText.fromJson(json["formatted_description"])
            : null,
        assets: json['assets'] ?? {},
        hcGroups: (json['hc_groups'] as List?)
                ?.map((group) => HCG.fromJson(group))
                .toList() ??
            [],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "formatted_title": formattedTitle?.toJson(),
        "description": description,
        "formatted_description": formattedDescription?.toJson(),
        "assets": assets,
        "hc_groups": List<dynamic>.from(hcGroups.map((x) => x.toJson())),
      };
}
