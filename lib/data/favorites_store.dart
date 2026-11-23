
import 'package:flutter/foundation.dart';

class FavoritesStore {
  static final List<Map<String, dynamic>> places = [];

  static final ValueNotifier<int> notifier = ValueNotifier(0);

  static bool contains(String name) {
    return places.any((place) => place['name'] == name);
  }

  static void toggle(Map<String, dynamic> place) {
    final name = place['name'];

    if (contains(name)) {
      places.removeWhere((item) => item['name'] == name);
    } else {
      places.add(place);
    }

    notifier.value++;
  }
}
