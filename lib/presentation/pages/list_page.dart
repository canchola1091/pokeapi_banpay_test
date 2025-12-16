
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';
import 'package:pokeapi_banpay_test/presentation/pages/favorites_page.dart';
import 'package:pokeapi_banpay_test/presentation/providers/favorite_pokemon_provider.dart';
import 'package:pokeapi_banpay_test/presentation/providers/pokemon_notifier.dart';
import 'package:pokeapi_banpay_test/presentation/providers/pokemon_provider.dart';
import 'package:pokeapi_banpay_test/presentation/widgets/list/pokemon_tile.dart';
import 'package:pokeapi_banpay_test/presentation/widgets/shared/loading_widget.dart';
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

    final PokemonState pokemonState = ref.watch(pokemonListNotifierProvider);
    final Set<int> favoriteIds = ref.watch(favoritePokemonIdsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Lista de Pokemones'),
        centerTitle: true,
        actions: (favoriteIds.isNotEmpty)
        ? [
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.red,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FavoritesPage(),
                ),
              );
            }
          )
        ] : [],
      ),
      body: (pokemonState.isLoading)
      ? const LoadingWidget()
      : (pokemonState.errorMessage != null)
        ? Center(child: Text('Error: ${pokemonState.errorMessage}'))
        : ListView.builder(
          physics: const BouncingScrollPhysics(),
            itemCount: pokemonState.pokemons?.length ?? 0,
            itemBuilder: (context, index) {

              final PokemonModel pokemon = pokemonState.pokemons![index];
              final isFavorite = favoriteIds.contains(pokemon.id);

              return PokemonTile(
                pokemonModel: pokemon,
                isFavoritePokemon: isFavorite
              );
            }
          ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () => ref.read(pokemonListNotifierProvider.notifier).loadPokemonList()
      )
    );
  }
}