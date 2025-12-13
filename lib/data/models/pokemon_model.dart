
class PokemonModel {

  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;

  const PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id       : json['id'],
      name     : json['name'],
      imageUrl : json['sprites']['front_default'] ?? '',
      types    : (json['types'] as List).map((type) => type['type']['name'] as String).toList(),
    );
  }

}


class PokemonDetailModel {

  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final List<PokemonStat> stats;
  final List<PokemonAbility> abilities;
  final List<PokemonMove> moves;

  const PokemonDetailModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.stats,
    required this.abilities,
    required this.moves,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailModel(
      id         : json['id'],
      name       : json['name'],
      imageUrl   : json['sprites']['front_default'] ?? '',
      types      : (json['types'] as List).map((type) => type['type']['name'] as String).toList(),
      height     : json['height'],
      weight     : json['weight'],
      stats      : (json['stats'] as List).map((stat) => PokemonStat.fromJson(stat)).toList(),
      abilities  : (json['abilities'] as List).map((ability) => PokemonAbility.fromJson(ability)).toList(),
      moves      : (json['moves'] as List).map((move) => PokemonMove.fromJson(move)).toList(),
    );
  }

}


class PokemonStat {

  final String name;
  final int baseStat;
  final int effort;

  const PokemonStat({
    required this.name,
    required this.baseStat,
    required this.effort,
  });

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      name     : json['stat']['name'],
      baseStat : json['base_stat'],
      effort   : json['effort'],
    );
  }

}


class PokemonAbility {

  final String name;
  final bool isHidden;

  const PokemonAbility({
    required this.name,
    required this.isHidden,
  });

  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    return PokemonAbility(
      name     : json['ability']['name'],
      isHidden : json['is_hidden'],
    );
  }

}


class PokemonMove {

  final String name;

  const PokemonMove({required this.name});

  factory PokemonMove.fromJson(Map<String, dynamic> json) {
    return PokemonMove(
      name: json['move']['name'],
    );
  }

}