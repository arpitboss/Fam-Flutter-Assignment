import 'package:flutter/material.dart';

import 'entity_model.dart';

class FormattedText {
  final String text;
  final List<Entity> entities;

  FormattedText({
    required this.text,
    required this.entities,
  });

  factory FormattedText.fromJson(Map<String, dynamic> json) {
    return FormattedText(
      text: json['text'] ?? '',
      entities: (json['entities'] as List?)
              ?.map((e) => Entity.fromJson(e))
              .toList() ??
          [],
    );
  }

  List<TextSpan> buildTextSpans() {
    List<TextSpan> spans = [];
    List<String> parts = text.split('{}');

    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i]));
      if (i < entities.length) {
        Entity entity = entities[i];
        spans.add(entity.toTextSpan());
      }
    }
    return spans;
  }
}
