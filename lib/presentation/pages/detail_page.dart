import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_banpay_test/data/models/pokemon_model.dart';
import 'package:pokeapi_banpay_test/presentation/providers/pokemon_provider.dart';

class DetailPage extends ConsumerStatefulWidget {

  final int pokemonId;
  final String pokemonName;

  const DetailPage({super.key, required this.pokemonId, required this.pokemonName});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pokemonDetailNotifierProvider(widget.pokemonId).notifier).loadPokemonDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonDetailState = ref.watch(pokemonDetailNotifierProvider(widget.pokemonId));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemonName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: (pokemonDetailState.isLoading)
          ? const Center(child: CircularProgressIndicator())
          : (pokemonDetailState.errorMessage != null)
              ? Center(child: Text('Error: ${pokemonDetailState.errorMessage}'))
              : (pokemonDetailState.pokemon == null)
                  ? const Center(child: Text('No hay datos disponibles'))
                  : _buildDetailContent(pokemonDetailState.pokemon!),
    );
  }

  Widget _buildDetailContent(PokemonDetailModel pokemon) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                pokemon.imageUrl,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 100,);
                }
              )
            ),

            Text(
              'ID: ${pokemon.id}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),

            Text(
              'Altura: ${(pokemon.height / 10).toStringAsFixed(1)} m | Peso: ${(pokemon.weight).toStringAsFixed(2)} kg',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),

            if (pokemon.types.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tipos:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: pokemon.types.map((type) {
                      return Chip(
                        label: Text(type),
                        backgroundColor: _getTypeColor(type),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),

            Text(
              'Estadisticas:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ...pokemon.stats.map((stat) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${_formatStatName(stat.name)}:'),
                      Text(stat.baseStat.toString()),
                    ],
                  ),
                )),
            const SizedBox(height: 20),

            Text(
              'Habilidades:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ...pokemon.abilities.map((ability) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: [
                      Text(ability.name),
                      if (ability.isHidden)
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('(Hidden)', style: TextStyle(color: Colors.grey)),
                        ),
                    ],
                  ),
                )),
            const SizedBox(height: 20),

            Text(
              'Movimientos:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Wrap(
              spacing: 8.0,
              children: pokemon.moves.take(10).map((move) => Chip(label: Text(move.name))).toList(),
            )
          ]
        )
      )
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return Colors.grey;
      case 'fire':
        return Colors.red.shade300;
      case 'water':
        return Colors.blue.shade300;
      case 'electric':
        return Colors.yellow.shade300;
      case 'grass':
        return Colors.green.shade300;
      case 'ice':
        return Colors.cyan.shade300;
      case 'fighting':
        return Colors.orange.shade300;
      case 'poison':
        return Colors.purple.shade300;
      case 'ground':
        return Colors.amber.shade300;
      case 'flying':
        return Colors.indigo.shade300;
      case 'psychic':
        return Colors.pink.shade300;
      case 'bug':
        return Colors.lightGreen.shade300;
      case 'rock':
        return Colors.yellow.shade800;
      case 'ghost':
        return Colors.deepPurple.shade300;
      case 'dragon':
        return Colors.indigo.shade800;
      case 'dark':
        return Colors.brown.shade300;
      case 'steel':
        return Colors.blueGrey.shade300;
      case 'fairy':
        return Colors.pink.shade100;
      default:
        return Colors.grey.shade300;
    }
  }

  String _formatStatName(String statName) {
    log('Formatting stat name: $statName');
    return statName.split('-').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
  }
}