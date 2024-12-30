import 'card_image_model.dart';
import 'cta_model.dart';
import 'formatted_text_model.dart';
import 'gradient_model.dart';

class CardModel {
  final String name;
  final FormattedText? formattedTitle;
  final String? title;
  final FormattedText? formattedDescription;
  final String? description;
  final CardImage? icon;
  final String? url;
  final CardImage? bgImage;
  final String? bgColor;
  final GradientModel? bgGradient;
  final List<CTA> cta;

  CardModel({
    required this.name,
    this.formattedTitle,
    this.title,
    this.formattedDescription,
    this.description,
    this.icon,
    this.url,
    this.bgImage,
    this.bgColor,
    this.bgGradient,
    required this.cta,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      name: json['name'] ?? '',
      formattedTitle: json['formatted_title'] != null
          ? FormattedText.fromJson(json['formatted_title'])
          : null,
      title: json['title'],
      formattedDescription: json['formatted_description'] != null
          ? FormattedText.fromJson(json['formatted_description'])
          : null,
      description: json['description'],
      icon: json['icon'] != null ? CardImage.fromJson(json['icon']) : null,
      url: json['url'],
      bgImage: json['bg_image'] != null
          ? CardImage.fromJson(json['bg_image'])
          : null,
      bgColor: json['bg_color'],
      bgGradient: json['bg_gradient'] != null
          ? GradientModel.fromJson(json['bg_gradient'])
          : null,
      cta: (json['cta'] as List?)?.map((e) => CTA.fromJson(e)).toList() ?? [],
    );
  }
}
