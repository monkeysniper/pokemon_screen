import 'package:flutter/material.dart';
import 'package:pokemon_screen/pokemon_model.dart';
import 'package:pokemon_screen/pokemon_detail_screen.dart';

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Pokemon> pokemons = [
      const Pokemon(name: 'Bulbasaur', id: '#001', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png', color: Colors.green, types: ['Grass', 'Poison'], weight: 6.9, height: 0.7, moves: ['Chlorophyll', 'Overgrow'], description: 'There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.', stats: {'HP': 45, 'ATK': 49, 'DEF': 49, 'SATK': 65, 'SDEF': 65, 'SPD': 45}),
      const Pokemon(name: 'Charmander', id: '#004', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png', color: Colors.orange, types: ['Fire'], weight: 8.5, height: 0.6, moves: ['Mega-Punch', 'Fire-Punch'], description: 'It has a preference for hot things. When it rains, steam is said to spout from the tip of its tail.', stats: {'HP': 39, 'ATK': 52, 'DEF': 43, 'SATK': 60, 'SDEF': 50, 'SPD': 65}),
      const Pokemon(name: 'Squirtle', id: '#007', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png', color: Colors.blue, types: ['Water'], weight: 9.0, height: 0.5, moves: ['Torrent', 'Rain-Dish'], description: 'When it retracts its long neck into its shell, it squirts out water with vigorous force.', stats: {'HP': 44, 'ATK': 48, 'DEF': 65, 'SATK': 50, 'SDEF': 64, 'SPD': 43}),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: pokemons.length,
          itemBuilder: (context, index) {
            return PokemonCard(pokemon: pokemons[index]);
          },
        ),
      ),
    );
  }
}

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailScreen(pokemon: pokemon),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: pokemon.color.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(pokemon.imageUrl, height: 80),
            const SizedBox(height: 10),
            Text(pokemon.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
