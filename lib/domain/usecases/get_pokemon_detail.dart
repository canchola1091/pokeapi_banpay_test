
import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';
import 'package:pokeapi_banpay_test/domain/repositories/pokemon_repository.dart';

class GetPokemonDetail {
  final PokemonRepository repository;

  GetPokemonDetail(this.repository);

  Future<PokemonDetailModel> call(int id) async {
    return await repository.getPokemonDetailById(id);
  }
}