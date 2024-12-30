import 'package:flutter/material.dart';

import '../../../models/entity_structure_model.dart';
import '../../../models/text_format_model.dart';
import '../../../utils/color_utils.dart';

class DynamicFormattedText extends StatelessWidget {
  final FormattedText formattedTitle;

  const DynamicFormattedText({super.key, required this.formattedTitle});

  @override
  Widget build(BuildContext context) {
    String text = formattedTitle.text;
    List<Entity> entities = formattedTitle.entities;

    List<InlineSpan> textSpans = [];
    int entityIndex = 0;

    // Split text by "{}" and process each segment
    text.split("{}").forEach((segment) {
      // Add the plain text segment
      if (segment.isNotEmpty) {
        textSpans.add(_buildTextSpan(segment, true));
        textSpans.add(const WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: SizedBox(height: 40),
        ));
      }

      // Add styled text from entities
      if (entityIndex < entities.length) {
        final entity = entities[entityIndex];
        textSpans.add(_buildTextSpan(entity.text!, false, entity));
        entityIndex++;
      }
    });

    // Wrap with alignment and return RichText
    return Align(
      alignment: _getAlignment(formattedTitle.align),
      child: RichText(
        text: TextSpan(children: textSpans),
        textAlign: _getTextAlign(formattedTitle.align),
      ),
    );
  }

  // Helper method to create a TextSpan for plain or styled text
  TextSpan _buildTextSpan(String text, bool isPlainText, [Entity? entity]) {
    TextStyle style = isPlainText
        ? const TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)
        : TextStyle(
            color: convertHexToColor(entity?.color ?? ""),
            fontSize: (entity?.fontSize as num?)?.toDouble(),
            fontWeight: (entity?.fontFamily?.contains("bold") ?? false)
                ? FontWeight.bold
                : FontWeight.normal,
          );

    return TextSpan(text: text, style: style);
  }

  // Helper: Map align to Flutter alignment
  Alignment _getAlignment(String? align) {
    switch (align) {
      case "left":
        return Alignment.centerLeft;
      case "right":
        return Alignment.centerRight;
      case "center":
        return Alignment.center;
      default:
        return Alignment.centerLeft;
    }
  }

  // Helper: Map align to text alignment
  TextAlign _getTextAlign(String? align) {
    switch (align) {
      case "left":
        return TextAlign.left;
      case "right":
        return TextAlign.right;
      case "center":
        return TextAlign.center;
      default:
        return TextAlign.left;
    }
  }
}
