
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';
import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';

import 'package:pokeapi_banpay_test/presentation/pages/detail_page.dart';
import 'package:pokeapi_banpay_test/presentation/pages/favorites_page.dart';
import 'package:pokeapi_banpay_test/presentation/providers/favorite_pokemon_provider.dart';
import 'package:pokeapi_banpay_test/presentation/providers/pokemon_provider.dart';
class ListPage extends ConsumerStatefulWidget {

  const ListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pokemonListNotifierProvider.notifier).loadPokemonList();
    });
  }

  @override
  Widget build(BuildContext context) {

    final pokemonState = ref.watch(pokemonListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pokemones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FavoritesPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: (pokemonState.isLoading)
          ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
              SizedBox(height: 15.0),
              Text('Cargando, espere un momento...'),
            ],
          )
          : (pokemonState.errorMessage != null)
              ? Center(child: Text('Error: ${pokemonState.errorMessage}'))
              : ListView.builder(
                  itemCount: pokemonState.pokemons?.length ?? 0,
                  itemBuilder: (context, index) {

                    final PokemonModel pokemon = pokemonState.pokemons![index];
                    final String formatName = pokemon.name[0].toUpperCase() + pokemon.name.substring(1);

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(pokemon.imageUrl),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          log('Favorite button pressed for ${pokemon.name}');
                          final favoritePokemon = FavoritePokemonModel.fromPokemonModel(pokemon);
                          ref.read(favoritePokemonListNotifierProvider.notifier).addFavorite(favoritePokemon);
                        },
                        icon: const Icon(Icons.favorite_border)
                      ),
                      title: Text(formatName),
                      subtitle: Text('Types: ${pokemon.types.join(', ')}'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              pokemonId: pokemon.id,
                              pokemonName: formatName
                            )
                          ),
                        );
                      },
                    );
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.refresh),
                  onPressed: () => ref.read(pokemonListNotifierProvider.notifier).loadPokemonList()
                ),
    );
  }
}