import '../data/models/pokemon.dart';
import '../data/repository/fetch_list_pokemon_repository.dart';
import '../utils/logger.dart';

class FetchListPokemonService {
  const FetchListPokemonService._();

  static FetchListPokemonService instance = const FetchListPokemonService._();

  static FetchListPokemonRepository? _fetchListPokemonRepo;

  void init(FetchListPokemonRepository repo) {
    _fetchListPokemonRepo ??= repo;
  }

  Future<List<Pokemon>> fetchListPokemon() async {
    "FetchListPokemonService fetchListPokemon start".log();
    try {
      if (_fetchListPokemonRepo == null) {
        throw Exception("FetchListPokemonRepository is null");
      }

      // delayed 300 milliseconds
      // await Future.delayed(const Duration(milliseconds: 300), () {});
      return await _fetchListPokemonRepo!.fetchListPokemon();
    } on Exception catch (e) {
      "FetchListPokemonService fetchListPokemon Exception: $e".log();
      return [];
    } finally {
      "FetchListPokemonService fetchListPokemon finally".log();
    }
  }
}
