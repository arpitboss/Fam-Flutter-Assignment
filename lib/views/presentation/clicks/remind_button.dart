import 'package:fam_flutter_assignment/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/card_controller.dart';

class RemindLaterButton extends StatelessWidget {
  final String id;
  const RemindLaterButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final CardController cardController =
        Get.find(); // Get the card controller instance
    return GestureDetector(
      onTap: () =>
          cardController.postponeCard(id), // Postpone the card when tapped
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 80,
          width: 140,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor, // Set background color
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15), // Spacer at the top
                SvgPicture.asset(
                    'assets/icons/bell_icon.svg'), // Remind later icon
                const SizedBox(height: 4), // Spacer between icon and text
                const Text(
                  "remind later", // Button label
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
