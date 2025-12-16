
import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';

abstract class FavoritePokemonRepository {
  Future<List<FavoritePokemonModel>> getFavoritePokemonList();
  Future<void> addFavoritePokemon(FavoritePokemonModel pokemon);
  Future<void> updateFavoritePokemonNote(int id, String newNote);
  Future<void> removeFavoritePokemon(int id);
}