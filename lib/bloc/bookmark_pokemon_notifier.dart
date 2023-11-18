import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../utils/logger.dart';

class BookmarkPokemonNotifier with ChangeNotifier {
  final _name = 'BookmarkPokemonNotifier';

  final Set<int> _bookmarks = {};

  Set<int> get bookmarks => _bookmarks;

  void addedBookmark(int pokemonID) {
    '$_name addedBookmark pokemonID: $pokemonID'.log();

    _bookmarks.add(pokemonID);

    notifyListeners();
  }

  void removeBookmark(int pokemonID) {
    '$_name removeBookmark pokemonID: $pokemonID'.log();

    _bookmarks.remove(pokemonID);

    notifyListeners();
  }

  void deleteAllBookmarks() {
    'delete all bookmarks'.log();

    _bookmarks.clear();

    notifyListeners();
  }
}
