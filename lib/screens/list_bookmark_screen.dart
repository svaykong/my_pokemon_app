import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../screens/pokemon_detail_screen.dart';
import '../bloc/pokemon_notifier.dart';
import '../utils/common.dart';
import '../bloc/bookmark_pokemon_notifier.dart';

class ListBookmarkScreen extends StatelessWidget {
  const ListBookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const name = 'ListBookmarkScreen';
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Bookmarks'),
      ),
      body: SafeArea(
        child: Center(
          child: Consumer2<BookmarkPokemonNotifier, PokemonNotifier>(
            builder: (_, bookmarkNotifier, pokemonNotifier, __) {
              if (bookmarkNotifier.bookmarks.isEmpty) {
                return const Text('You don\'t have any bookmarks');
              } else {
                var bookmarks = bookmarkNotifier.bookmarks;
                pokemonNotifier.filterPokemons(bookmarks);
                var pokemons = pokemonNotifier.filterResults.toList();
                return ListView.builder(
                    padding: const EdgeInsets.all(6.0),
                    itemCount: pokemons.length,
                    itemBuilder: (_, index) {
                      var pokemonID = pokemons[index].id;
                      return Card(
                        margin: const EdgeInsets.all(6.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PokemonDetailScreen(
                                  pokemon: pokemons[index],
                                  tag: pokemons[index].id.toString() + name,
                                ),
                              ),
                            );
                          },
                          leading: Hero(
                            tag: pokemons[index].id.toString() + name,
                            child: CachedNetworkImage(
                              imageUrl: pokemons[index].imageURL,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(pokemons[index].name),
                          trailing: Builder(
                            builder: (context) => IconButton(
                                icon: const Icon(FontAwesomeIcons.ellipsis),
                                onPressed: () async {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          width: double.infinity,
                                          height: height * 0.08,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              TextButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  fixedSize: const Size(200, 50),
                                                ),
                                                label: const Text('Removed'),
                                                icon: const Icon(FontAwesomeIcons.trash),
                                                onPressed: () {
                                                  bookmarkNotifier.removeBookmark(pokemonID);
                                                  pokemonNotifier.removeFilterPokemons(pokemonID);
                                                  showSnackBar(context, 'success removed');
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                }),
                          ),
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
