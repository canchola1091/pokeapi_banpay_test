
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_banpay_test/presentation/pages/detail_page.dart';
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
      appBar: AppBar(title: const Text('Pokédex')),
      body: pokemonState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : pokemonState.errorMessage != null
              ? Center(child: Text('Error: ${pokemonState.errorMessage}'))
              : ListView.builder(
                  itemCount: pokemonState.pokemons?.length ?? 0,
                  itemBuilder: (context, index) {
                    final pokemon = pokemonState.pokemons![index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(pokemon.imageUrl),
                      ),
                      title: Text(pokemon.name),
                      subtitle: Text('Types: ${pokemon.types.join(', ')}'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              pokemonId: pokemon.id,
                              pokemonName: pokemon.name
                            )
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}