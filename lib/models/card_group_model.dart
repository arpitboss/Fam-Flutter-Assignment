import 'card_model.dart';

enum DesignType {
  smallDisplayCard('HC1'),
  bigDisplayCard('HC3'),
  imageCard('HC5'),
  smallCardWithArrow('HC6'),
  dynamicWidthCard('HC9');

  final String value;
  const DesignType(this.value);

  factory DesignType.fromString(String value) {
    return DesignType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => DesignType.smallDisplayCard,
    );
  }
}

class CardGroup {
  final DesignType designType;
  final String name;
  final List<CardModel> cards;
  final double? height;
  final bool isScrollable;

  CardGroup({
    required this.designType,
    required this.name,
    required this.cards,
    this.height,
    required this.isScrollable,
  });

  factory CardGroup.fromJson(Map<String, dynamic> json) {
    return CardGroup(
      designType: DesignType.fromString(json['design_type'] ?? ''),
      name: json['name'] ?? '',
      cards: (json['cards'] as List?)
              ?.map((e) => CardModel.fromJson(e))
              .toList() ??
          [],
      height: json['height']?.toDouble(),
      isScrollable: json['is_scrollable'] ?? false,
    );
  }
}
