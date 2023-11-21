import '../data/models/pokemon.dart';

class PokemonDetailScreenArguments {
  final Pokemon pokemon;
  final String tag;
  const PokemonDetailScreenArguments({required this.pokemon, this.tag = ''});
}