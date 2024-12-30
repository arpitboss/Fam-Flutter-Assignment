import 'package:fam_flutter_assignment/models/main_card_model.dart';
import 'package:flutter/material.dart';

import '../../../models/hcg_model.dart';
import '../../../models/services/url_service.dart';
import '../../../utils/color_utils.dart';
import '../clicks/dismiss_button.dart';
import '../clicks/remind_button.dart';
import '../widgets/big_card_dynamic_text.dart';

class FlexibleCardWidget extends StatefulWidget {
  final HCG hcGroup;

  const FlexibleCardWidget({super.key, required this.hcGroup});

  @override
  State<FlexibleCardWidget> createState() => _FlexibleCardWidgetState();
}

class _FlexibleCardWidgetState extends State<FlexibleCardWidget> {
  bool showOptions = false;

  @override
  Widget build(BuildContext context) {
    if (widget.hcGroup.cards.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Fixed Buttons on the Left
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: showOptions ? 120 : 0,
                  curve: Curves.easeInOut,
                  child: showOptions
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RemindLaterButton(
                                id: widget.hcGroup.cards[0].id.toString()),
                            const SizedBox(height: 20),
                            DismissButton(
                                id: widget.hcGroup.cards[0].id.toString()),
                          ],
                        )
                      : null,
                ),

                // Scrollable Cards
                Row(
                  children: widget.hcGroup.cards
                      .map((card) => GestureDetector(
                            onLongPress: () {
                              setState(() {
                                showOptions = true;
                              });
                            },
                            child: _buildCard(context, card),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CardModel card) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width - 16,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                card.bgImage?.imageUrl ?? "",
                fit: BoxFit.cover,
                width: MediaQuery.sizeOf(context).width - 16,
              ),
            ),

            // Text Overlay
            Positioned(
              left: 40,
              right: 10,
              top: 150,
              child: DynamicFormattedText(
                formattedTitle: card.formattedTitle!,
              ),
            ),

            // CTA Buttons
            Positioned(
              left: 40,
              bottom: 20,
              child: Row(
                children: card.cta.map((cta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        await urlLauncher(card.url ?? "https://google.com");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: convertHexToColor(cta.bgColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        cta.text,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
