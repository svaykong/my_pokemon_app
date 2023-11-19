import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '/bloc/pokemon_notifier.dart';
import '/utils/logger.dart';
import '../utils/common.dart';
import '../bloc/bookmark_pokemon_notifier.dart';

class ListBookmarkScreen extends StatelessWidget {
  const ListBookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                var pokemons = pokemonNotifier.filterResults;
                return ListView.builder(
                    padding: const EdgeInsets.all(6.0),
                    itemCount: pokemons.length,
                    itemBuilder: (_, index) {
                      var pokemonID = pokemons.elementAt(index).id;
                      return Card(
                        child: ListTile(
                          title: Text('Bookmark ID: $pokemonID'),
                          trailing: IconButton(
                            icon: const Icon(FontAwesomeIcons.trash),
                            onPressed: () {
                              bookmarkNotifier.removeBookmark(pokemonID);
                              showSnackBar(context, 'success removed');
                            },
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
