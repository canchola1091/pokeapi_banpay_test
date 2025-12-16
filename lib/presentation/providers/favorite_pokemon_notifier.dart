
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';
import 'package:pokeapi_banpay_test/domain/usecases/add_favorite_pokemon.dart';
import 'package:pokeapi_banpay_test/domain/usecases/get_favorite_pokemon_list.dart';
import 'package:pokeapi_banpay_test/domain/usecases/remove_favorite_pokemon.dart';
import 'package:pokeapi_banpay_test/domain/usecases/update_favorite_pokemon.dart';

class FavoritePokemonListNotifier extends StateNotifier<AsyncValue<List<FavoritePokemonModel>>> {

  final GetFavoritePokemonList _getFavoritePokemonList;
  final AddFavoritePokemon _addFavoritePokemon;
  final UpdateFavoritePokemon _updateFavoritePokemon;
  final RemoveFavoritePokemon _removeFavoritePokemon;

  FavoritePokemonListNotifier(
    this._getFavoritePokemonList,
    this._addFavoritePokemon,
    this._updateFavoritePokemon,
    this._removeFavoritePokemon
  ): super(const AsyncValue.loading()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    state = const AsyncValue.loading();
    try {
      final favorites = await _getFavoritePokemonList();
      state = AsyncValue.data(favorites);
    } catch (e, stk) {
      state = AsyncValue.error(e, stk);
    }
  }

  Future<void> addFavorite(FavoritePokemonModel pokemon) async {
    try {
      await _addFavoritePokemon(pokemon);
      await loadFavorites();
    } catch (e) {
      log('Error adding favorite: $e');
    }
  }

  Future<void> updateFavorite(int id, String newNote) async {
    try {
      await _updateFavoritePokemon(id, newNote);
      await loadFavorites();
    } catch (e) {
      log('Error update favorite: $e');
    }
  }

  Future<void> removeFavorite(int id) async {
    try {
      await _removeFavoritePokemon(id);
      await loadFavorites();
    } catch (e) {
      log('Error removing favorite: $e');
    }
  }
}