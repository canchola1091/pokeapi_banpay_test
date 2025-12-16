
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_banpay_test/domain/usecases/remove_favorite_pokemon.dart';
import 'package:pokeapi_banpay_test/domain/usecases/update_favorite_pokemon.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';
import 'package:pokeapi_banpay_test/presentation/providers/favorite_pokemon_notifier.dart';
import 'package:pokeapi_banpay_test/data/datasources/local/favorite_pokemon_local_data_source.dart';
import 'package:pokeapi_banpay_test/data/repositories/favorite_pokemon_repository_impl.dart';
import 'package:pokeapi_banpay_test/domain/repositories/favorite_pokemon_repository.dart';
import 'package:pokeapi_banpay_test/domain/usecases/add_favorite_pokemon.dart';
import 'package:pokeapi_banpay_test/domain/usecases/get_favorite_pokemon_list.dart';

//? Provider SharedPreferences
// final sharedPreferencesProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError());

//? Provider DataSource
final favoritePokemonLocalDataSourceProvider = Provider<FavoritePokemonLocalDataSource>((ref) => FavoritePokemonLocalDataSourceImpl());

//? Provider Repository
final favoritePokemonRepositoryProvider = Provider<FavoritePokemonRepository>((ref) => FavoritePokemonRepositoryImpl(ref.watch(favoritePokemonLocalDataSourceProvider)));

//? Provider Caso de Uso (Agregar favorito)
final addFavoritePokemonProvider = Provider<AddFavoritePokemon>((ref) => AddFavoritePokemon(ref.watch(favoritePokemonRepositoryProvider)));

//? Provider Caso de Uso (Obtener lista de favoritos)
final getFavoritePokemonListProvider = Provider<GetFavoritePokemonList>((ref) => GetFavoritePokemonList(ref.watch(favoritePokemonRepositoryProvider)));

//? Provider Caso de Uso (Update favorito)
final updateFavoritePokemonProvider = Provider<UpdateFavoritePokemon>((ref) => UpdateFavoritePokemon(ref.watch(favoritePokemonRepositoryProvider)));

//? Provider Caso de Uso (Eliminar favorito)
final removeFavoritePokemonProvider = Provider<RemoveFavoritePokemon>((ref) => RemoveFavoritePokemon(ref.watch(favoritePokemonRepositoryProvider)));

//? Provider Notifier de la lista de favoritos
final favoritePokemonListNotifierProvider = StateNotifierProvider<FavoritePokemonListNotifier, AsyncValue<List<FavoritePokemonModel>>>(
  (ref) => FavoritePokemonListNotifier(
    ref.watch(getFavoritePokemonListProvider),
    ref.watch(addFavoritePokemonProvider),
    ref.watch(updateFavoritePokemonProvider),
    ref.watch(removeFavoritePokemonProvider),
  ),
);