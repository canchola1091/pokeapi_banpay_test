
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';
import 'package:pokeapi_banpay_test/presentation/providers/favorite_pokemon_provider.dart';

class PokemonFavoriteCard extends ConsumerWidget {

  final FavoritePokemonModel pokemonFavoriteModel;

  const PokemonFavoriteCard({
    required this.pokemonFavoriteModel,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.6),
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Image.network( pokemonFavoriteModel.imageUrl ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pokemonFavoriteModel.name[0].toUpperCase() + pokemonFavoriteModel.name.substring(1),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref.read(favoritePokemonListNotifierProvider.notifier).removeFavorite(pokemonFavoriteModel.id);
                  }
                )
              ]
            )
          ),
          const SizedBox(height: 5.0),

          GestureDetector(
            onTap: () => _showEditNoteDialog(context, ref, pokemonFavoriteModel),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      (pokemonFavoriteModel.note.isEmpty) ? 'Sin notas' : pokemonFavoriteModel.note,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                      overflow: TextOverflow.ellipsis
                    )
                  ),
                  const Icon(Icons.edit)
                ]
              )
            )
          )
        ]
      )
    );
  }

  void _showEditNoteDialog(BuildContext context, WidgetRef ref, FavoritePokemonModel pokemon) {
    TextEditingController controller = TextEditingController(text: pokemon.note);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Agrega/Edita una nota para ${pokemon.name}'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Add a note...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.read(favoritePokemonListNotifierProvider.notifier).updateFavorite(pokemon.id, pokemon.note = controller.text);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          )
        ]
      )
    );
  }
  
}