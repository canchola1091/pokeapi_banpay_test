
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';
import 'package:pokeapi_banpay_test/domain/usecases/get_pokemon_detail.dart';

class PokemonDetailState {
  final bool isLoading;
  final PokemonDetailModel? pokemon;
  final String? errorMessage;

  const PokemonDetailState({
    this.isLoading = false,
    this.pokemon,
    this.errorMessage,
  });

  PokemonDetailState copyWith({
    bool? isLoading,
    PokemonDetailModel? pokemon,
    String? errorMessage,
  }) {
    return PokemonDetailState(
      isLoading: isLoading ?? this.isLoading,
      pokemon: pokemon ?? this.pokemon,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  PokemonDetailState loading() => copyWith(isLoading: true, errorMessage: null);
  PokemonDetailState data(PokemonDetailModel pokemon) => copyWith(isLoading: false, pokemon: pokemon, errorMessage: null);
  PokemonDetailState error(String message) => copyWith(isLoading: false, pokemon: null, errorMessage: message);
}

class PokemonDetailNotifier extends StateNotifier<PokemonDetailState> {
  final GetPokemonDetail _getPokemonDetail;
  final int id;

  PokemonDetailNotifier(this._getPokemonDetail, this.id) : super(const PokemonDetailState());

  Future<void> loadPokemonDetail() async {
    state = state.loading();

    try {
      final pokemon = await _getPokemonDetail(id);
      state = state.data(pokemon);
    } catch (e) {
      state = state.error(e.toString());
    }
  }
}