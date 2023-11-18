import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
          child: Consumer<BookmarkPokemonNotifier>(
            builder: (_, bookmarkNotifier, __) {
              if (bookmarkNotifier.bookmarks.isEmpty) {
                return const Text('You don\'t have any bookmarks');
              } else {
                var bookmarks = bookmarkNotifier.bookmarks;
                return ListView.builder(
                    padding: const EdgeInsets.all(6.0),
                    itemCount: bookmarks.length,
                    itemBuilder: (_, index) {
                      var pokemonID = bookmarks.elementAt(index);
                      return Card(
                        child: ListTile(
                          title: Text('Bookmark ID: $pokemonID'),
                          trailing: IconButton(
                            icon: const Icon(FontAwesomeIcons.trash),
                            onPressed: () {
                              bookmarkNotifier.removeBookmark(pokemonID);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Bookmark removed success'),
                                ),
                              );
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
