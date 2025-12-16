
import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';

class FavoritePokemonModel {
  
  final int id;
  final String name;
  final String imageUrl;
  final String note;

  const FavoritePokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.note = '',
  });

  factory FavoritePokemonModel.fromPokemonModel(PokemonModel pokemon) {
    return FavoritePokemonModel(
      id       : pokemon.id,
      name     : pokemon.name,
      imageUrl : pokemon.imageUrl,
    );
  }

  Map<String, dynamic> toJson() => {
        'id'       : id,
        'name'     : name,
        'imageUrl' : imageUrl,
        'note'     : note,
      };

  factory FavoritePokemonModel.fromJson(Map<String, dynamic> json) {
    return FavoritePokemonModel(
      id       : json['id'],
      name     : json['name'],
      imageUrl : json['imageUrl'],
      note     : json['note'] ?? '',
    );
  }

  FavoritePokemonModel copyWith({String? note}) {
    return FavoritePokemonModel(
      id       : id,
      name     : name,
      imageUrl : imageUrl,
      note     : note ?? this.note,
    );
  }
  
}