
import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';
import 'package:pokeapi_banpay_test/domain/repositories/favorite_pokemon_repository.dart';

class GetFavoritePokemonList {

  final FavoritePokemonRepository repository;

  GetFavoritePokemonList(this.repository);

  Future<List<FavoritePokemonModel>> call() async => await repository.getFavoritePokemonList();

}