import 'package:fam_flutter_assignment/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/card_controller.dart';

class DismissButton extends StatelessWidget {
  final String id;
  const DismissButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final CardController cardController = Get.find();
    return GestureDetector(
      onTap: () => cardController.removeCard(id),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 80,
          width: 140,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                SvgPicture.asset('assets/icons/dismiss_icon.svg'),
                const SizedBox(height: 4),
                const Text(
                  "dismiss now",
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
