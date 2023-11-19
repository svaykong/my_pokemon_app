import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../bloc/bookmark_pokemon_notifier.dart';
import '../data/models/pokemon.dart';
import '../utils/common.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var bookmarkNotifier = Provider.of<BookmarkPokemonNotifier>(context, listen: true);
    var isContain = bookmarkNotifier.bookmarks.contains(pokemon.id);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox.fromSize(
                size: Size(width * 0.9, height * 0.4),
                child: Card(
                  child: Hero(
                    tag: pokemon.id,
                    child: CachedNetworkImage(
                      imageUrl: pokemon.imageURL,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  pokemon.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (isContain) {
                        bookmarkNotifier.removeBookmark(pokemon.id);
                        showSnackBar(context, 'success removed');
                      } else {
                        bookmarkNotifier.addedBookmark(pokemon.id);
                        showSnackBar(context, 'success added');
                      }
                    },
                    child: Row(
                      children: [
                        Text(isContain ? 'Removed from bookmark' : 'Add to Bookmark'),
                        const Icon(Icons.bookmark),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
