import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../bloc/bookmark_pokemon_notifier.dart';
import '../data/models/pokemon.dart';
import '../utils/logger.dart';

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
              bookmarkNotifier.bookmarks.contains(pokemon.id)
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Add to Bookmark'),
                        IconButton(
                          onPressed: () {
                            'bookmark pressed...'.log();
                            // call BookmarkPokemonNotifier -> bookmark
                            bookmarkNotifier.addedBookmark(pokemon.id);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Bookmark success'),
                            ));
                          },
                          icon: const Icon(Icons.bookmark),
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
