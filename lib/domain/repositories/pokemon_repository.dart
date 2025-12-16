
import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';

abstract class PokemonRepository {
  Future<List<PokemonModel>> getPokemonList();
  Future<PokemonDetailModel> getPokemonDetailById(int id);
}