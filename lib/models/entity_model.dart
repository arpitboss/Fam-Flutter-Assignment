import 'package:flutter/material.dart';

class Entity {
  final String text;
  final String? color;
  final String? url;
  final String? fontStyle;

  Entity({
    required this.text,
    this.color,
    this.url,
    this.fontStyle,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      text: json['text'] ?? '',
      color: json['color'],
      url: json['url'],
      fontStyle: json['font_style'],
    );
  }

  TextSpan toTextSpan() {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: color != null
            ? Color(int.parse(color!.replaceAll('#', '0xFF')))
            : null,
        decoration: fontStyle == 'underline' ? TextDecoration.underline : null,
        fontStyle: fontStyle == 'italic' ? FontStyle.italic : null,
      ),
    );
  }
}
