
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokeapi_banpay_test/data/datasources/remote/pokemon_remote_data_source.dart';
import 'package:pokeapi_banpay_test/data/repositories/pokemon_repository_impl.dart';
import 'package:pokeapi_banpay_test/domain/repositories/pokemon_repository.dart';
import 'package:pokeapi_banpay_test/domain/usecases/get_pokemon_detail.dart';
import 'package:pokeapi_banpay_test/domain/usecases/get_pokemon_id.dart';
import 'package:pokeapi_banpay_test/domain/usecases/get_pokemon_list.dart';
import 'package:pokeapi_banpay_test/presentation/providers/pokemon_detail_notifier.dart';
import 'pokemon_notifier.dart';

//? Provider Dio
final dioProvider = Provider<Dio>((ref) {

  Dio dioResponse =  Dio(BaseOptions(
    baseUrl: 'https://pokeapi.co/api/v2/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  return dioResponse;
});

//? Provider DataSource
final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>((ref) => PokemonRemoteDataSourceImpl(ref.watch(dioProvider)));

//? Provider Repositorio
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) => PokemonRepositoryImpl(ref.watch(pokemonRemoteDataSourceProvider)));

//? Provider Caso de Uso (obtener lista)
final getPokemonListProvider = Provider<GetPokemonList>((ref) => GetPokemonList(ref.watch(pokemonRepositoryProvider)));

//? Provider Caso de Uso (obtener por ID)
final getPokemonByIdProvider = Provider<GetPokemonById>((ref) => GetPokemonById(ref.watch(pokemonRepositoryProvider)));

//? Provider Caso de Uso (obtener detalles)
final getPokemonDetailProvider = Provider<GetPokemonDetail>((ref) => GetPokemonDetail(ref.watch(pokemonRepositoryProvider)));

//? Provider Notifier
final pokemonListNotifierProvider = StateNotifierProvider<PokemonListNotifier, PokemonState>(
  (ref) => PokemonListNotifier( ref.watch(getPokemonListProvider) )
);

//? Provider Notifier Detalle
final pokemonDetailNotifierProvider = StateNotifierProvider.family<PokemonDetailNotifier, PokemonDetailState, int>(
  (ref, id) => PokemonDetailNotifier( ref.watch(getPokemonDetailProvider),id ),
);
