
import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';
import 'package:pokeapi_banpay_test/domain/repositories/favorite_pokemon_repository.dart';

class AddFavoritePokemon {

  final FavoritePokemonRepository repository;

  AddFavoritePokemon(this.repository);

  Future<void> call(FavoritePokemonModel pokemon) async => await repository.addFavoritePokemon(pokemon);

}