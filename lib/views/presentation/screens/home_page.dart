import 'package:fam_flutter_assignment/views/presentation/screens/small_card_with_arrow.dart';
import 'package:fam_flutter_assignment/views/presentation/screens/small_display_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/card_controller.dart';
import '../../../models/card_group_model.dart';
import '../../../models/hcg_model.dart';
import 'big_display_card.dart';
import 'dynamic_width_card.dart';
import 'image_card.dart';

class FamScreen extends StatefulWidget {
  const FamScreen({super.key});

  @override
  _FamScreenState createState() => _FamScreenState();
}

class _FamScreenState extends State<FamScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _showNormalUI = false;

  final CardController _cardController = Get.find<CardController>();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward().then((_) {
      setState(() {
        _showNormalUI = true;
      });
      // Fetch cards when the animation completes
      _cardController.retrieveCards();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _showNormalUI ? const Color(0xFFF7F6F3) : Colors.transparent,
      body: Stack(
        children: [
          // Loading screen with animation
          if (!_showNormalUI) _buildLoadingScreen(),

          // Main UI after animation completion
          if (_showNormalUI) _buildMainUI(),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E3A8A), // Dark blue
            Color(0xFF3B82F6), // Light blue
            Color(0xFF93C5FD), // Lighter blue
          ],
        ),
      ),
      child: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SvgPicture.asset(
            'assets/logos/fampay_logo.svg',
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
  }

  Widget _buildMainUI() {
    return Column(
      children: [
        _buildAppBar(),
        Expanded(
          child: Obx(() {
            if (_cardController.isFetching.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orangeAccent,
                ),
              );
            } else if (_cardController.errorMsg.isNotEmpty) {
              return _buildErrorState();
            } else if (_cardController.cardList.isEmpty) {
              return _buildNoCardsState();
            } else {
              return _buildCardList();
            }
          }),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: SvgPicture.asset(
        'assets/logos/fampay_logo.svg',
        height: 25,
        width: 25,
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _cardController.errorMsg.value,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _cardController.reloadCards(),
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildNoCardsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No more cards available.',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _cardController.reloadCards(),
            child: const Text("Show Cards"),
          ),
        ],
      ),
    );
  }

  Widget _buildCardList() {
    final hcGroups = _cardController.cardList.first.hcGroups;

    final sortedHcGroups = [
      ...hcGroups.where((group) => group.designType == DesignType.HC3),
      ...hcGroups.where((group) => group.designType == DesignType.HC6),
      ...hcGroups.where((group) => group.designType == DesignType.HC5),
      ...hcGroups.where((group) => group.designType == DesignType.HC9),
      ...hcGroups.where((group) => group.designType == DesignType.HC1),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          await _cardController.reloadCards();
        },
        child: ListView.builder(
          itemCount: sortedHcGroups.length,
          itemBuilder: (context, index) {
            final hcGroup = sortedHcGroups[index];
            return _buildCardWidget(hcGroup);
          },
        ),
      ),
    );
  }

  Widget _buildCardWidget(HCG hcGroup) {
    switch (hcGroup.designType) {
      case DesignType.HC1:
        return LargeCardWidget(hcGroup: hcGroup);
      case DesignType.HC3:
        return FlexibleCardWidget(hcGroup: hcGroup);
      case DesignType.HC5:
        return ImageCardWidget(hcGroup: hcGroup);
      case DesignType.HC6:
        return ArrowCardWidget(hcGroup: hcGroup);
      case DesignType.HC9:
        return CompactCardWidget(hcGroup: hcGroup);
      default:
        return SizedBox(); // Fallback widget
    }
  }
}
