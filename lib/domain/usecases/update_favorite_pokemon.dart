
import 'package:pokeapi_banpay_test/domain/repositories/favorite_pokemon_repository.dart';

class UpadteFavoritePokemon {

  final FavoritePokemonRepository repository;

  UpadteFavoritePokemon(this.repository);

  Future<void> call(int id, String newNote) async => await repository.updateFavoritePokemonNote(id, newNote);

}