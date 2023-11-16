import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class PokemonCard extends StatelessWidget {
  final int id;
  final String name;
  final String imageURL;

  const PokemonCard({
    Key? key,
    required this.id,
    required this.name,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        children: [
          Expanded(
            child: Hero(
              tag: id,
              child: CachedNetworkImage(
                imageUrl: imageURL,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
