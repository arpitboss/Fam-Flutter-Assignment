import 'package:fam_flutter_assignment/models/main_card_model.dart';
import 'package:flutter/material.dart';

import '../../../models/hcg_model.dart';
import '../../../utils/gradient_utils.dart';

class CompactCardWidget extends StatelessWidget {
  final HCG hcGroup;

  const CompactCardWidget({super.key, required this.hcGroup});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: SizedBox(
          height: hcGroup.height * 1.3, // Adjust height for better spacing
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Make it scroll horizontally
            itemCount: hcGroup.cards.length, // Number of cards in the group
            itemBuilder: (context, index) {
              final card = hcGroup.cards[index];
              return _buildCard(context, card); // Build each card
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CardModel card) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0), // Spacing between cards
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), // Rounded corners
        child: AspectRatio(
          aspectRatio: (card.bgImage?.aspectRatio ??
              1.5), // Use provided aspect ratio or default
          child: Container(
            decoration: BoxDecoration(
              gradient: card.bgGradient != null
                  ? convertHexToGradient(
                      card.bgGradient!) // Apply gradient if available
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
