import 'package:fam_flutter_assignment/models/main_card_model.dart';
import 'package:flutter/material.dart';

import '../../../models/hcg_model.dart';

class ImageCardWidget extends StatelessWidget {
  final HCG hcGroup;

  const ImageCardWidget({super.key, required this.hcGroup});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170, // Fixed height for the card list
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Make it scroll horizontally
        itemCount: hcGroup.cards.length, // Number of cards in the group
        itemBuilder: (context, index) {
          final card = hcGroup.cards[index];
          return _buildCard(context, card); // Build each card
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, CardModel card) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        card.bgImage?.imageUrl ?? "", // Use provided image or fallback
        fit: BoxFit.cover, // Ensure the image covers the entire card
        width:
            MediaQuery.sizeOf(context).width - 16, // Full width minus padding
      ),
    );
  }
}
