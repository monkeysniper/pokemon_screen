import 'package:flutter/material.dart';
import 'package:pokemon_screen/pokemon_model.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pokemon.color,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: -50, right: -50, child: Image.asset('assets/pokeball.png', width: 200, color: Colors.white.withOpacity(0.2))),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(pokemon.name, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                        Text(pokemon.id, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Image.network(
                        pokemon.imageUrl,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: pokemon.types.map((type) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Chip(label: Text(type), backgroundColor: pokemon.color.withOpacity(0.5)),
                              )).toList(),
                            ),
                            const SizedBox(height: 16),
                            Text('About', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: pokemon.color)),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InfoColumn(title: 'Weight', value: '${pokemon.weight} kg'),
                                InfoColumn(title: 'Height', value: '${pokemon.height} m'),
                                InfoColumn(title: 'Moves', value: pokemon.moves.join('\n')),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(pokemon.description, textAlign: TextAlign.center, style: const TextStyle(height: 1.5)),
                            const SizedBox(height: 16),
                             Text('Base Stats', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: pokemon.color)),
                            const SizedBox(height: 16),
                            ...pokemon.stats.entries.map((entry) => StatRow(statName: entry.key, statValue: entry.value, color: pokemon.color)).toList(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const InfoColumn({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class StatRow extends StatelessWidget {
  final String statName;
  final int statValue;
  final Color color;

  const StatRow({super.key, required this.statName, required this.statValue, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(statName, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 40,
            child: Text(statValue.toString().padLeft(3, '0')),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: statValue / 100,
              color: color,
              backgroundColor: color.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
