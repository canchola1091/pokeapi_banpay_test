
import 'package:pokeapi_banpay_test/domain/repositories/favorite_pokemon_repository.dart';

class RemoveFavoritePokemon {

  final FavoritePokemonRepository repository;

  RemoveFavoritePokemon(this.repository);

  Future<void> call(int id) async => await repository.removeFavoritePokemon(id);

}