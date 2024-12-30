import 'package:fam_flutter_assignment/models/main_card_model.dart';
import 'package:flutter/material.dart';

import '../../../models/hcg_model.dart';

class ImageCardWidget extends StatelessWidget {
  final HCG hcGroup;

  const ImageCardWidget({super.key, required this.hcGroup});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hcGroup.cards.length,
        itemBuilder: (context, index) {
          final card = hcGroup.cards[index];
          return _buildCard(context, card);
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, CardModel card) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        card.bgImage?.imageUrl ?? "",
        fit: BoxFit.cover,
        width: MediaQuery.sizeOf(context).width - 16,
      ),
    );
  }
}
