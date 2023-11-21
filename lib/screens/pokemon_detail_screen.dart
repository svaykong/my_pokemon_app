import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../bloc/bookmark_pokemon_notifier.dart';
import '../utils/app_routes.dart';
import '../utils/common.dart';

class PokemonDetailScreen extends StatelessWidget {
  static const String id = 'pokemon_detail_screen';

  const PokemonDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as PokemonDetailScreenArguments;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var bookmarkNotifier = Provider.of<BookmarkPokemonNotifier>(context, listen: true);
    var isContain = bookmarkNotifier.bookmarks.contains(args.pokemon.id);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox.fromSize(
                size: Size(width * 0.9, height * 0.2),
                child: Card(
                  child: Hero(
                    tag: args.tag.isEmpty ? args.pokemon.id : args.tag,
                    child: CachedNetworkImage(
                      imageUrl: args.pokemon.imageURL,
                      fit: BoxFit.fitHeight,
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
                  args.pokemon.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      if (isContain) {
                        bookmarkNotifier.removeBookmark(args.pokemon.id);
                        showSnackBar(context, 'success removed');
                      } else {
                        bookmarkNotifier.addedBookmark(args.pokemon.id);
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
