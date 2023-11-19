import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'bloc/pokemon_notifier.dart';
import 'bloc/bookmark_pokemon_notifier.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BookmarkPokemonNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => PokemonNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Pokemon App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
