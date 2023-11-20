import 'package:flutter/material.dart' show BuildContext;

import 'package:provider/provider.dart';

import '../bloc/pokemon_notifier.dart';
import '../data/repository/fetch_list_pokemon_repository.dart';
import '../utils/logger.dart';

class FetchListPokemonService {
  const FetchListPokemonService._();

  static FetchListPokemonService instance = const FetchListPokemonService._();

  static FetchListPokemonRepository? _fetchListPokemonRepo;

  void init(FetchListPokemonRepository repo) {
    _fetchListPokemonRepo ??= repo;
  }

  Future<bool> fetchListPokemon(BuildContext context) async {
    "FetchListPokemonService fetchListPokemon start".log();
    try {
      if (_fetchListPokemonRepo == null) {
        throw Exception("FetchListPokemonRepository is null");
      }

      final results = await _fetchListPokemonRepo!.fetchListPokemon();
      if (!context.mounted) {
        return false;
      }
      context.read<PokemonNotifier>().save(results);
      return true;
    } on Exception catch (e) {
      "FetchListPokemonService fetchListPokemon Exception: $e".log();
      return false;
    } finally {
      "FetchListPokemonService fetchListPokemon finally".log();
    }
  }
}
