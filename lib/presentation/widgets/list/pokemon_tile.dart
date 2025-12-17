
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';
import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';
import 'package:pokeapi_banpay_test/presentation/pages/detail_page.dart';
import 'package:pokeapi_banpay_test/presentation/providers/favorite_pokemon_provider.dart';

class PokemonTile extends ConsumerWidget {

  final PokemonModel pokemonModel;
  final bool isFavoritePokemon;
  
  const PokemonTile({
    required this.pokemonModel,
    required this.isFavoritePokemon,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final String formatName = pokemonModel.name[0].toUpperCase() + pokemonModel.name.substring(1);

    return ListTile(
      leading: Hero(
        tag: '${pokemonModel.id}',
        child: CircleAvatar(
          backgroundImage: NetworkImage(pokemonModel.imageUrl),
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          final favoritePokemon = FavoritePokemonModel.fromPokemonModel(pokemonModel);
          if (isFavoritePokemon) {
            ref.read(favoritePokemonListNotifierProvider.notifier).removeFavorite(pokemonModel.id);
          } else {
            ref.read(favoritePokemonListNotifierProvider.notifier).addFavorite(favoritePokemon);
          }
        },
        icon: Icon(Icons.favorite, color: (isFavoritePokemon) ? Colors.red : Colors.grey)
      ),
      title: Text(formatName),
      subtitle: Text('Tipos: ${pokemonModel.types.join(', ')}'),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPage(
              pokemonId: pokemonModel.id,
              pokemonName: formatName
            )
          )
        );
      }
    );
  }
}