import 'package:fam_flutter_assignment/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../models/entity_structure_model.dart';
import '../../../models/text_format_model.dart';
import '../../../utils/color_utils.dart';

class DynamicFormattedText extends StatelessWidget {
  final FormattedText formattedTitle;

  const DynamicFormattedText({super.key, required this.formattedTitle});

  @override
  Widget build(BuildContext context) {
    // Grab the raw text and the list of styled entities
    String text = formattedTitle.text;
    List<Entity> entities = formattedTitle.entities;

    // This will hold all the text pieces, both plain and styled
    List<InlineSpan> textSpans = [];
    int entityIndex = 0;

    // Split the text by "{}" to separate plain text from the styled parts
    text.split("{}").forEach((segment) {
      // Add the plain text segment if it’s not empty
      if (segment.isNotEmpty) {
        textSpans.add(_buildTextSpan(segment, true));
        // Add a little space to make things look nicer
        textSpans.add(const WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: SizedBox(height: 40),
        ));
      }

      // If there’s a styled entity, add it to the text
      if (entityIndex < entities.length) {
        final entity = entities[entityIndex];
        textSpans.add(_buildTextSpan(entity.text!, false, entity));
        entityIndex++; // Move to the next entity
      }
    });

    // Wrap everything with the correct alignment and return it
    return Align(
      alignment: _getAlignment(formattedTitle.align),
      child: RichText(
        text: TextSpan(children: textSpans),
        textAlign: _getTextAlign(formattedTitle.align),
      ),
    );
  }

  // Helper to create a TextSpan, either plain or styled
  TextSpan _buildTextSpan(String text, bool isPlainText, [Entity? entity]) {
    TextStyle style = isPlainText
        ? const TextStyle(
            fontSize: 30,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold)
        : TextStyle(
            color:
                convertHexToColor(entity?.color ?? ""), // Convert hex to color
            fontSize: (entity?.fontSize as num?)?.toDouble(), // Set font size
            fontWeight: (entity?.fontFamily?.contains("bold") ?? false)
                ? FontWeight.bold
                : FontWeight.normal, // Make it bold if needed
          );
    return TextSpan(text: text, style: style);
  }

  // Figure out the alignment based on the string value
  Alignment _getAlignment(String? align) {
    switch (align) {
      case "left":
        return Alignment.centerLeft;
      case "right":
        return Alignment.centerRight;
      case "center":
        return Alignment.center;
      default:
        return Alignment.centerLeft; // Default to left if nothing matches
    }
  }

  // Figure out the text alignment based on the string value
  TextAlign _getTextAlign(String? align) {
    switch (align) {
      case "left":
        return TextAlign.left;
      case "right":
        return TextAlign.right;
      case "center":
        return TextAlign.center;
      default:
        return TextAlign.left; // Default to left if nothing matches
    }
  }
}
