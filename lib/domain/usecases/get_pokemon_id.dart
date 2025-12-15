
import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';
import 'package:pokeapi_banpay_test/domain/repositories/pokemon_repository.dart';

class GetPokemonById {
  final PokemonRepository repository;

  GetPokemonById(this.repository);

  Future<PokemonModel> call(int id) async {
    return await repository.getPokemonById(id);
  }
}