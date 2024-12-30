import 'package:fam_flutter_assignment/models/main_card_model.dart';
import 'package:flutter/material.dart';

import '../../../models/hcg_model.dart';
import '../../../utils/color_utils.dart';

class LargeCardWidget extends StatelessWidget {
  final HCG hcGroup;

  const LargeCardWidget({super.key, required this.hcGroup});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: hcGroup.height * 1.3,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: hcGroup.cards.length,
          itemBuilder: (context, index) {
            final card = hcGroup.cards[index];
            return _buildCard(context, card);
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CardModel card) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: 64,
        width: hcGroup.isScrollable
            ? MediaQuery.sizeOf(context).width - 20
            : (MediaQuery.sizeOf(context).width - 20) / 2,
        decoration: BoxDecoration(
          color: convertHexToColor(card.bgColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  card.icon?.imageUrl ??
                      "https://hok.famapp.co.in/hok-assets/feedMedia/ext/5435b4ee-a962-4531-95d5-889e4038eece-1734193661283.webp",
                  fit: BoxFit.cover,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (card.formattedTitle != null)
                      Text(
                        card.formattedTitle?.entities.first.text ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    if (card.formattedDescription != null)
                      Text(
                        card.formattedDescription?.entities.first.text ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
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
