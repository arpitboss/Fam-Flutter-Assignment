import 'package:fam_flutter_assignment/models/main_card_model.dart';
import 'package:flutter/material.dart';

import '../../../models/hcg_model.dart';
import '../../../utils/color_utils.dart';

class ArrowCardWidget extends StatelessWidget {
  final HCG hcGroup;

  const ArrowCardWidget({super.key, required this.hcGroup});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 12.0),
      child: SizedBox(
        height: hcGroup.height * 2, // Adjust height based on the group’s height
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // Make it scroll horizontally
          itemCount: hcGroup.cards.length, // Number of cards in the group
          itemBuilder: (context, index) {
            final card = hcGroup.cards[index];
            return _buildCard(context, card); // Build each card
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CardModel card) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 16, // Full width minus padding
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 24,
        ),
        tileColor: convertHexToColor(card.bgColor), // Set background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            card.icon?.imageUrl ?? "", // Use provided icon or fallback
            fit: BoxFit.cover,
            width: ((card.iconSize)?.toDouble() ?? 16) * 2, // Adjust icon size
            height: (card.iconSize?.toDouble() ?? 16) * 2,
          ),
        ),
        title: card.formattedTitle != null
            ? Text(
                card.formattedTitle?.entities.first.text ?? "", // Display title
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        trailing: const Icon(Icons.arrow_forward_ios_rounded), // Arrow icon
      ),
    );
  }
}
