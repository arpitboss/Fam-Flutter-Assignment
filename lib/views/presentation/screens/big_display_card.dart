import 'package:flutter/material.dart';

import '../../../models/hcg_model.dart';
import '../../../models/main_card_model.dart';
import '../../../utils/color_utils.dart';

class LargeCardWidget extends StatelessWidget {
  final HCG hcGroup;

  const LargeCardWidget({super.key, required this.hcGroup});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        // Adjust the height slightly for better spacing
        height: hcGroup.height * 1.3,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        // Adjust width based on whether the card group is scrollable
        height: 64,
        width: hcGroup.isScrollable
            ? MediaQuery.sizeOf(context).width - 20 // Full width for scrollable
            : (MediaQuery.sizeOf(context).width - 20) /
                2, // Half width otherwise
        decoration: BoxDecoration(
          color: convertHexToColor(card.bgColor), // Set background color
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Card icon on the left
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  card.icon?.imageUrl ?? // Use provided image or a fallback
                      "https://hok.famapp.co.in/hok-assets/feedMedia/ext/5435b4ee-a962-4531-95d5-889e4038eece-1734193661283.webp",
                  fit: BoxFit.cover,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
            const SizedBox(width: 8), // Spacer between icon and text
            // Card title and description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (card.formattedTitle != null) // Show title if available
                      Text(
                        card.formattedTitle?.entities.first.text ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1, // Ensure it doesn’t overflow
                      ),
                    if (card.formattedDescription !=
                        null) // Show description if available
                      Text(
                        card.formattedDescription?.entities.first.text ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2, // Limit to two lines
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
