
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';
import 'package:pokeapi_banpay_test/presentation/providers/favorite_pokemon_provider.dart';

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
            final pokemon = favorites[index];
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

                  Image.network( pokemon.imageUrl ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            ref.read(favoritePokemonListNotifierProvider.notifier).removeFavorite(pokemon.id);
                          }
                        )
                      ]
                    )
                  ),
                  const SizedBox(height: 5.0),

                  GestureDetector(
                    onTap: () => _showEditNoteDialog(context, ref, pokemon),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              (pokemon.note.isEmpty) ? 'Sin notas' : pokemon.note,
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
        ),
        error: (error, stack) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
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
