import 'package:fam_flutter_assignment/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class FamScreen extends StatelessWidget {
  const FamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset('assets/logos/fampay_logo.svg'),
      ),
    );
  }
}
