import 'package:fam_flutter_assignment/models/card_group_model.dart';
import 'package:get/get.dart';

import '../models/hcg_model.dart';
import '../models/main_card_model.dart';
import '../models/services/api_service.dart';
import '../models/services/storage_service.dart';

class CardController extends GetxController {
  final ApiHandler apiHandler;
  final LocalStorage localStorage;

  CardController({required this.apiHandler, required this.localStorage});

  // Reactive state for cards
  var cardList = <CardGroup>[].obs;

  // Reactive state for loading
  var isFetching = false.obs;

  // Reactive state for error messages
  var errorMsg = ''.obs;

  // Fetch cards
  Future<void> retrieveCards() async {
    isFetching.value = true;
    errorMsg.value = '';
    try {
      final fetchedCards = await apiHandler.getCards();
      final dismissedCards = localStorage.getDismissedCards();
      final remindLaterCards = localStorage.getRemindLaterCards();

      List<CardGroup> filteredCards = [];

      for (var cardGroup in fetchedCards) {
        List<HCG> filteredHcGroups = [];

        for (var hcGroup in cardGroup.hcGroups) {
          List<CardModel> filteredHcGroupCards = hcGroup.cards.where((card) {
            return !dismissedCards.contains(card.id.toString()) &&
                !remindLaterCards.contains(card.id.toString());
          }).toList();

          HCG updatedHcGroup = hcGroup.copyWith(cards: filteredHcGroupCards);
          filteredHcGroups.add(updatedHcGroup);
        }

        filteredCards.add(cardGroup.copyWith(hcGroups: filteredHcGroups));
      }

      if (filteredCards.isEmpty) {
        errorMsg.value = 'No cards available.';
      } else {
        cardList.value = filteredCards;
      }
    } on Exception catch (e) {
      errorMsg.value = e.toString();
    } finally {
      isFetching.value = false;
    }
  }

  // Dismiss a card
  Future<void> removeCard(String cardId) async {
    localStorage.saveCardState(cardId: cardId, state: 'dismissed');
    await _refreshCards();
  }

  // Remind later for a card
  Future<void> postponeCard(String cardId) async {
    localStorage.saveCardState(cardId: cardId, state: 'remind_later');
    await _refreshCards();
  }

  // Refresh cards
  Future<void> reloadCards() async {
    await retrieveCards();
  }

  // Clear all remind later cards
  Future<void> clearPostponedCards() async {
    await localStorage.clearAllRemindLaterCards();
  }

  // Update cards after dismiss or remind later
  Future<void> _refreshCards() async {
    final dismissedCards = localStorage.getDismissedCards();
    final remindLaterCards = localStorage.getRemindLaterCards();
    final currentCards = await apiHandler.getCards();
    List<CardGroup> filteredCards = [];

    for (var cardGroup in currentCards) {
      List<HCG> filteredHcGroups = [];

      for (var hcGroup in cardGroup.hcGroups) {
        List<CardModel> filteredHcGroupCards = hcGroup.cards.where((card) {
          return !dismissedCards.contains(card.id.toString()) &&
              !remindLaterCards.contains(card.id.toString());
        }).toList();

        HCG updatedHcGroup = hcGroup.copyWith(cards: filteredHcGroupCards);
        filteredHcGroups.add(updatedHcGroup);
      }

      filteredCards.add(cardGroup.copyWith(hcGroups: filteredHcGroups));
    }

    cardList.value = filteredCards;
  }
}
