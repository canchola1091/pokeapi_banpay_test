
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
      appBar: AppBar(title: const Text('Pokemones Favoritos')),
      body: favoritesState.when(
        data: (favorites) => ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final pokemon = favorites[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(pokemon.imageUrl)),
                title: Text(pokemon.name),
                subtitle: Text(pokemon.note.isEmpty ? 'Sin notas' : pokemon.note),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref.read(favoritePokemonListNotifierProvider.notifier).removeFavorite(pokemon.id);
                  },
                ),
                onTap: () {
                  _showEditNoteDialog(context, ref, pokemon);
                },
              ),
            );
          },
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
              // await ref.read(updateFavoritePokemonProvider.notifier).updateFavorite(pokemon.copyWith(note: controller.text));
              await ref.read(favoritePokemonListNotifierProvider.notifier).updateFavorite(pokemon.id, pokemon.note = controller.text);
              // ref.read(favoritePokemonListNotifierProvider.notifier).loadFavorites();
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
