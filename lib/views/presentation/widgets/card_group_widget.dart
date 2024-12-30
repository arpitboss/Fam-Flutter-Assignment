import 'package:flutter/material.dart';

import '../../../models/card_group_model.dart';
import '../../../models/card_model.dart';

class CardGroupWidget extends StatelessWidget {
  final CardGroup cardGroup;

  const CardGroupWidget({
    super.key,
    required this.cardGroup,
  });

  @override
  Widget build(BuildContext context) {
    // if the card group is empty, it will return an empty widget
    if (cardGroup.cards.isEmpty) return const SizedBox.shrink();

    // here we will decide how to display the cards: 'horizontally scrollable' or 'a simple wrap'
    Widget cardList = cardGroup.isScrollable
        ? SizedBox(
            height: cardGroup.height ?? 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cardGroup.cards.length,
              itemBuilder: (context, index) => _buildCard(
                  cardGroup.cards[index]), // to build individual cards
            ),
          )
        : Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cardGroup.cards
                .map((card) => _buildCard(card))
                .toList(), // to build individual cards and wrap cards
          );

    // we will wrap the card list in padding for better layout
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: cardList,
    );
  }

  // here we will build the appropriate widget for each 'card' based on its 'design type'
  Widget _buildCard(CardModel card) {
    switch (cardGroup.designType) {
      case DesignType.smallDisplayCard:
        return SmallDisplayCard(card: card); // it shows small display card
      case DesignType.bigDisplayCard:
        return BigDisplayCard(card: card); // it shows big display card
      case DesignType.imageCard:
        return ImageCard(card: card); // it shows image card
      case DesignType.smallCardWithArrow:
        return SmallCardWithArrow(
            card: card); // it shows small card with an arrow
      case DesignType.dynamicWidthCard:
        return DynamicWidthCard(
          card: card,
          height: cardGroup.height ?? 200,
        ); // Card with dynamic width
    }
  }
}
