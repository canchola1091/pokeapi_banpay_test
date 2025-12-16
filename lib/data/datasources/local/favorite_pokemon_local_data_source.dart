
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:pokeapi_banpay_test/data/models/favorite_pokemon_model.dart';

abstract class FavoritePokemonLocalDataSource {
  Future<List<FavoritePokemonModel>> getFavoritePokemonList();
  Future<void> addFavoritePokemon(FavoritePokemonModel pokemon);
  Future<void> updateFavoritePokemon(FavoritePokemonModel pokemon);
  Future<void> removeFavoritePokemon(int id);
}

class FavoritePokemonLocalDataSourceImpl implements FavoritePokemonLocalDataSource {
  static const _key = 'favorite_pokemon_list';

  @override
  Future<List<FavoritePokemonModel>> getFavoritePokemonList() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = prefs.getString(_key) ?? '[]';
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((json) => FavoritePokemonModel.fromJson(json)).toList();
  }

  @override
  Future<void> addFavoritePokemon(FavoritePokemonModel pokemon) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getFavoritePokemonList();
    
    // Evita duplicados
    if (!list.any((p) => p.id == pokemon.id)) {
      list.add(pokemon);
      await prefs.setString(_key, json.encode(list));
    }else {
      log('El Pokémon con id ${pokemon.id} ya está en favoritos.');
    }
  }

  @override
  Future<void> updateFavoritePokemon(FavoritePokemonModel pokemon) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getFavoritePokemonList();
    final index = list.indexWhere((p) => p.id == pokemon.id);

    if (index != -1) {
      list[index] = pokemon;
      await prefs.setString(_key, json.encode(list));
    }
  }

  @override
  Future<void> removeFavoritePokemon(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getFavoritePokemonList();
    list.removeWhere((p) => p.id == id);
    await prefs.setString(_key, json.encode(list));
  }
}