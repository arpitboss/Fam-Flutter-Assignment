import 'package:shared_preferences/shared_preferences.dart';

abstract interface class LocalStorage {
  Future<void> saveCardState({required String cardId, required String state});
  String? getCardState({required String cardId});
  Future<void> clearCardState({required String cardId});
  List<String> getDismissedCards();
  List<String> getRemindLaterCards();
  Future<void> clearAllRemindLaterCards();
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences sharedPreferences;

  LocalStorageImpl({required this.sharedPreferences});

  // Save the state of a card (e.g., "dismissed" or "remind_later")
  @override
  Future<void> saveCardState(
      {required String cardId, required String state}) async {
    await sharedPreferences.setString(cardId, state);
  }

  // Retrieve the state of a card
  @override
  String? getCardState({required String cardId}) {
    return sharedPreferences.getString(cardId);
  }

  // Clear the state of a card (e.g., when it’s marked as active again)
  @override
  Future<void> clearCardState({required String cardId}) async {
    await sharedPreferences.remove(cardId);
  }

  // Get a list of all dismissed cards
  @override
  List<String> getDismissedCards() {
    final keys = sharedPreferences.getKeys();
    return keys
        .where((key) => sharedPreferences.getString(key) == 'dismissed')
        .toList();
  }

  // Get a list of all cards marked for reminder
  @override
  List<String> getRemindLaterCards() {
    final keys = sharedPreferences.getKeys();
    return keys
        .where((key) => sharedPreferences.getString(key) == 'remind_later')
        .toList();
  }

  // Clear all cards marked for reminder and their associated timestamps
  @override
  Future<void> clearAllRemindLaterCards() async {
    final keys = sharedPreferences.getKeys();

    // Find all keys with the 'remind_later' state
    final remindLaterKeys =
        keys.where((key) => sharedPreferences.getString(key) == 'remind_later');

    // Remove both the state and timestamp entries for each remind later card
    for (final key in remindLaterKeys) {
      await sharedPreferences.remove(key);
      await sharedPreferences.remove('${key}_timestamp');
    }
  }
}
