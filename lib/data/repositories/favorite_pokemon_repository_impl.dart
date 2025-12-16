
import 'package:pokeapi_banpay_test/data/datasources/local/favorite_pokemon_local_data_source.dart';
import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';
import 'package:pokeapi_banpay_test/domain/repositories/favorite_pokemon_repository.dart';


class FavoritePokemonRepositoryImpl implements FavoritePokemonRepository {
  
  final FavoritePokemonLocalDataSource dataSource;

  FavoritePokemonRepositoryImpl(this.dataSource);

  @override
  Future<List<FavoritePokemonModel>> getFavoritePokemonList() => dataSource.getFavoritePokemonList();

  @override
  Future<void> addFavoritePokemon(FavoritePokemonModel pokemon) => dataSource.addFavoritePokemon(pokemon);


  @override
  Future<void> updateFavoritePokemonNote(int id, String newNote) async {
    final list = await dataSource.getFavoritePokemonList();
    final index = list.indexWhere((p) => p.id == id);
    if (index != -1) {
      final updatedPokemon = list[index].copyWith(note: newNote);
      await dataSource.updateFavoritePokemon(updatedPokemon);
    }
  }

  @override
  Future<void> removeFavoritePokemon(int id) => dataSource.removeFavoritePokemon(id);
}