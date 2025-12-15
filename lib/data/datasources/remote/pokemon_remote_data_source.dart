
import 'package:dio/dio.dart';

import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> getPokemonList();
  Future<PokemonModel> getPokemonById(int id);
  Future<PokemonDetailModel> getPokemonDetailById(int id);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  
  final Dio _dio;

  PokemonRemoteDataSourceImpl(this._dio);

  @override
  Future<List<PokemonModel>> getPokemonList() async {

    final response = await _dio.get('/pokemon', queryParameters: {'limit': 100});
    final results = response.data['results'] as List;

    final List<int> ids = [];
    for (var res in results) {
      final List<String> urlParts = res['url'].split('/');
      ids.add(int.parse(urlParts[urlParts.length - 2]));
    }

    final List<PokemonModel> pokemonList = [];
    for (int id in ids) {
      try {
        final detailsResponse = await _dio.get('/pokemon/$id');
        pokemonList.add(PokemonModel.fromJson(detailsResponse.data));
      } catch (e) {
        continue;
      }
    }

    return pokemonList;
  }

  @override
  Future<PokemonModel> getPokemonById(int id) async {
    final response = await _dio.get('/pokemon/$id');
    return PokemonModel.fromJson(response.data);
  }
  
  @override
  Future<PokemonDetailModel> getPokemonDetailById(int id) async {
    final response = await _dio.get('/pokemon/$id');
    return PokemonDetailModel.fromJson(response.data);
  }

}