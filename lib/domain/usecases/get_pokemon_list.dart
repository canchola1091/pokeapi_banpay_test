
import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';
import 'package:pokeapi_banpay_test/domain/repositories/pokemon_repository.dart';

class GetPokemonList {
  
  final PokemonRepository repository;

  GetPokemonList(this.repository);

  Future<List<PokemonModel>> call() async {
    return await repository.getPokemonList();
  }
}