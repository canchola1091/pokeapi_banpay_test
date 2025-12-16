
import 'package:pokeapi_banpay_test/data/datasources/remote/pokemon_remote_data_source.dart';
import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';
import 'package:pokeapi_banpay_test/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {

  final PokemonRemoteDataSource _dataSource;

  PokemonRepositoryImpl(this._dataSource);

  @override
  Future<List<PokemonModel>> getPokemonList() {
    return _dataSource.getPokemonList();
  }

  @override
  Future<PokemonModel> getPokemonById(int id) {
    return _dataSource.getPokemonById(id);
  }

  @override
  Future<PokemonDetailModel> getPokemonDetailById(int id) {
    return _dataSource.getPokemonDetailById(id);
  }
}