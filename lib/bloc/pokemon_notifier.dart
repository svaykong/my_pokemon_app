import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../data/models/pokemon.dart';

class PokemonNotifier with ChangeNotifier {
  final _name = 'PokemonNotifier';
  final List<Pokemon> _pokemons = [];

  List<Pokemon> get pokemons => _pokemons;

  final Set<Pokemon> _filterResults = {};

  Set<Pokemon> get filterResults => _filterResults;

  void save(List<Pokemon> listPokemons) {
    _pokemons.addAll(listPokemons);
    notifyListeners();
  }

  void filterPokemons(Set<int> pokemonIDs) {
    for (var i = 0; i < pokemonIDs.length; i++) {
      for (var j = 0; j < _pokemons.length; j++) {
        if (pokemonIDs.elementAt(i) == pokemons[j].id) {
          filterResults.add(pokemons[j]);
        }
      }
    }
  }

  void removeFilterPokemons(int pokemonID) {
    _filterResults.removeWhere((pokemon) => pokemon.id == pokemonID);
    notifyListeners();
  }

  void clear() {
    _pokemons.clear();
    notifyListeners();
  }
}
