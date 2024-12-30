import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _dismissedCardsKey = 'dismissed_cards';
  static const String _remindLaterCardsKey = 'remind_later_cards';
  static const String _remindLaterTimePrefix = 'remind_later_time_';

  // late initialization of 'SharedPreferences' object to be used later
  late final SharedPreferences _prefs;

  // it initializes the 'SharedPreferences' object
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // function to get the list of 'dismissed cards',or an empty list if none
  Future<List<String>> getDismissedCards() async {
    return _prefs.getStringList(_dismissedCardsKey) ?? [];
  }

  // function to add a card to the dismissed list
  Future<void> addDismissedCard(String cardName) async {
    final dismissedCards = await getDismissedCards();
    dismissedCards.add(cardName); // add the new card
    await _prefs.setStringList(
        _dismissedCardsKey, dismissedCards); // save updated list
  }

  // function to get list of cards to remind later,or an empty list if none
  Future<List<String>> getRemindLaterCards() async {
    return _prefs.getStringList(_remindLaterCardsKey) ?? [];
  }

  // function to add a card to remind later list and store the current time
  Future<void> addRemindLaterCard(String cardName) async {
    final remindLaterCards = await getRemindLaterCards();
    remindLaterCards.add(cardName); // add the new card
    await _prefs.setStringList(
        _remindLaterCardsKey, remindLaterCards); // save updated list
    await _setRemindLaterTime(cardName); // store the time for later reminder
  }

  // function to save the current time when a card is added to remind later
  Future<void> _setRemindLaterTime(String cardName) async {
    await _prefs.setString(
      _remindLaterTimePrefix + cardName, // key is card name with time prefix
      DateTime.now().toIso8601String(), // save current time as string
    );
  }

  // function to get the saved time when the card was added for remind later
  DateTime? getRemindLaterTime(String cardName) {
    final timeStr = _prefs.getString(_remindLaterTimePrefix + cardName);
    return timeStr != null
        ? DateTime.parse(timeStr)
        : null; // return the time or null if not found
  }
}
