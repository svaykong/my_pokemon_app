import 'dart:convert';

import '../models/pokemon.dart';
import '../../utils/app_constants.dart';
import '../../data/api/api_client.dart';
import '../../utils/logger.dart';

class FetchListPokemonRepository {
  const FetchListPokemonRepository._();

  static FetchListPokemonRepository instance = const FetchListPokemonRepository._();

  static ApiClient? _apiClient;

  void init(ApiClient apiClient) {
    _apiClient ??= apiClient;
  }

  Future<List<Pokemon>> fetchListPokemon() async {
    'FetchListPokemonRepository fetchListPokemon start'.log();
    try {
      if (_apiClient == null) {
        throw Exception("apiClient is null");
      }

      int pageIndex = 0;
      String params = "?limit=200";
      params += "&offset=${pageIndex * 200}";
      final response = await _apiClient!.get(AppConstants.HOST + AppConstants.URL + params);
      final resultStr = response.body;
      final jsonStr = json.decode(resultStr);
      final pokemonData = PokemonData.fromJson(jsonStr);
      if (pokemonData.count == 0 || pokemonData.pokemons.isEmpty) {
        return [];
      }

      return pokemonData.pokemons;
    } on Exception catch (e) {
      'FetchListPokemonRepository fetchListPokemon exception: $e'.log();
      return [];
    } finally {
      'FetchListPokemonRepository fetchListPokemon finally'.log();
    }
  }
}
