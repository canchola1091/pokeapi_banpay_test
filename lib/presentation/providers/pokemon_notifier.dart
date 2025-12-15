
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';
import 'package:pokeapi_banpay_test/domain/usecases/get_pokemon_list.dart';


class PokemonState {
  final bool isLoading;
  final List<PokemonModel>? pokemons;
  final String? errorMessage;

  const PokemonState({
    this.isLoading = false,
    this.pokemons,
    this.errorMessage,
  });

  PokemonState copyWith({
    bool? isLoading,
    List<PokemonModel>? pokemons,
    String? errorMessage,
  }) {
    return PokemonState(
      isLoading: isLoading ?? this.isLoading,
      pokemons: pokemons ?? this.pokemons,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  PokemonState loading() => copyWith(isLoading: true, errorMessage: null);
  PokemonState data(List<PokemonModel> pokemons) => copyWith(isLoading: false, pokemons: pokemons, errorMessage: null);
  PokemonState error(String message) => copyWith(isLoading: false, pokemons: null, errorMessage: message);
}

class PokemonListNotifier extends StateNotifier<PokemonState> {
  final GetPokemonList _getPokemonList;

  PokemonListNotifier(this._getPokemonList) : super(const PokemonState());

  Future<void> loadPokemonList() async {
    state = state.loading();

    try {
      final pokemons = await _getPokemonList();
      state = state.data(pokemons);
    } catch (e) {
      state = state.error(e.toString());
    }
  }
}