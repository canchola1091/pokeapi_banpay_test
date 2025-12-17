
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';
import 'package:pokeapi_banpay_test/presentation/providers/favorite_pokemon_provider.dart';
import 'package:pokeapi_banpay_test/presentation/widgets/favorites/pokemon_favorite_card.dart';

class FavoritesPage extends ConsumerWidget {

  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final favoritesState = ref.watch(favoritePokemonListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokemones Favoritos',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white
          )
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white)
        )
      ),
      body: favoritesState.when(
        data: (favorites) => GridView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0
          ),
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.9
          ),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final FavoritePokemonModel pokemon = favorites[index];
            return FadeIn(
              delay: Duration(milliseconds: index * 100),
              child: PokemonFavoriteCard(pokemonFavoriteModel: pokemon)
            );
          }
        ),
        error: (error, stack) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      )
    );
  }

}
