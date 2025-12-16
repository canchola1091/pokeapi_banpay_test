
import 'package:pokeapi_banpay_test/domain/repositories/favorite_pokemon_repository.dart';

class UpdateFavoritePokemon {

  final FavoritePokemonRepository repository;

  UpdateFavoritePokemon(this.repository);

  Future<void> call(int id, String newNote) async => await repository.updateFavoritePokemonNote(id, newNote);

}