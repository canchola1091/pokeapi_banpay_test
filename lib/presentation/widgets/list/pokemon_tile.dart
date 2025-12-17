
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';
import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';
import 'package:pokeapi_banpay_test/presentation/pages/detail_page.dart';
import 'package:pokeapi_banpay_test/presentation/providers/favorite_pokemon_provider.dart';

class PokemonTile extends ConsumerStatefulWidget {

  final PokemonModel pokemonModel;
  final bool isFavoritePokemon;
  
  const PokemonTile({
    required this.pokemonModel,
    required this.isFavoritePokemon,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget>  createState() => _PokemonItemState();
}

class _PokemonItemState extends ConsumerState<PokemonTile> {

  @override
  Widget build(BuildContext context) {

    final String formatName = widget.pokemonModel.name[0].toUpperCase() + widget.pokemonModel.name.substring(1);

    return ListTile(
      leading: Hero(
        tag: '${widget.pokemonModel.id}',
        child: CircleAvatar(
          backgroundImage: NetworkImage(widget.pokemonModel.imageUrl),
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          final favoritePokemon = FavoritePokemonModel.fromPokemonModel(widget.pokemonModel);
          if (widget.isFavoritePokemon) {
            ref.read(favoritePokemonListNotifierProvider.notifier).removeFavorite(widget.pokemonModel.id);
          } else {
            ref.read(favoritePokemonListNotifierProvider.notifier).addFavorite(favoritePokemon);
          }
        },
        icon: Icon(Icons.favorite, color: (widget.isFavoritePokemon) ? Colors.red : Colors.grey)
      ),
      title: Text(formatName),
      subtitle: Text('Tipos: ${widget.pokemonModel.types.join(', ')}'),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPage(
              pokemonId: widget.pokemonModel.id,
              pokemonName: formatName
            )
          )
        );
      }
    );
  }
}