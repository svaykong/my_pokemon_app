import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokemon_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../bloc/pokemon_notifier.dart';
import '../screens/list_bookmark_screen.dart';
import '../screens/pokemon_detail_screen.dart';
import '../screens/pokemon_card.dart';
import '../data/api/api_client.dart';
import '../data/repository/fetch_list_pokemon_repository.dart';
import '../services/fetch_list_pokemon_service.dart';
import '../utils/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<bool> _fetchListPokemonFuture;
  final ScrollController _scrollController = ScrollController();
  bool _showBtn = false;

  @override
  void initState() {
    super.initState();
    // create api client instance
    final ApiClient apiClient = ApiClient.instance;

    // create fetch list pokemon repo instance
    final FetchListPokemonRepository fetchListPokemonRepos = FetchListPokemonRepository.instance;
    // pokemon repo initialize
    fetchListPokemonRepos.init(apiClient);

    // create fetch list pokemon service
    final FetchListPokemonService fetchListPokemonService = FetchListPokemonService.instance;
    // pokemon service initialize
    fetchListPokemonService.init(fetchListPokemonRepos);

    _fetchListPokemonFuture = fetchListPokemonService.fetchListPokemon(context);

    _scrollController.addListener(() {
      //scroll listener
      double showOffSet = 10.0; //Back to top button will show on scroll offset 10.0

      if (_scrollController.offset > showOffSet) {
        _showBtn = true;
        setState(() {
          //update state
        });
      } else {
        _showBtn = false;
        setState(() {
          //update state
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pokemon'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(ListBookmarkScreen.id),
            icon: const Icon(FontAwesomeIcons.bookmark),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<bool>(
            future: _fetchListPokemonFuture,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    'snapshot error: ${snapshot.error}'.log();
                    return const Text("Sorry, an error occur.");
                  }
                  final data = snapshot.data;
                  if (data == null) {
                    return const Text("Sorry, data is null");
                  }
                  if (!data) {
                    return const Text("Unknown error.");
                  }
                  return _buildGridView(context);
              }
            },
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 1000), //show/hide animation
        opacity: _showBtn ? 1.0 : 0.0, //set opacity to 1 on visible, or hide
        child: FloatingActionButton(
          onPressed: () {
            _scrollController.animateTo(
                //go to top of scroll
                0, //scroll offset to go
                duration: const Duration(milliseconds: 500), //duration of scroll
                curve: Curves.fastOutSlowIn //scroll type
                );
          },
          backgroundColor: Colors.grey,
          child: const Icon(
            Icons.arrow_upward,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  Widget _buildGridView(BuildContext context) {
    var pokemons = context.read<PokemonNotifier>().pokemons;
    return GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.4,
        ),
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              'pokemon name: ${pokemons[index].name}'.log();
              Navigator.of(context).pushNamed(
                PokemonDetailScreen.id,
                arguments: PokemonDetailScreenArguments(pokemon: pokemons[index]),
              );
            },
            child: PokemonCard(
              id: pokemons[index].id,
              imageURL: pokemons[index].imageURL,
              name: pokemons[index].name,
            ),
          );
        });
  }
}
