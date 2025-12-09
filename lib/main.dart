
import 'package:flutter/material.dart';
import 'package:pokemon_screen/pokemon_detail_screen.dart';
import 'package:pokemon_screen/pokemon_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const PokedexScreen(),
    );
  }
}

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Pokemon> pokemons = [
      const Pokemon(name: 'Bulbasaur', id: '#001', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png', color: Colors.green, types: ['Grass', 'Poison'], weight: 6.9, height: 0.7, moves: ['Chlorophyll', 'Overgrow'], description: 'There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.', stats: {'HP': 45, 'ATK': 49, 'DEF': 49, 'SATK': 65, 'SDEF': 65, 'SPD': 45}),
      const Pokemon(name: 'Charmander', id: '#004', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png', color: Colors.orange, types: ['Fire'], weight: 8.5, height: 0.6, moves: ['Mega-Punch', 'Fire-Punch'], description: 'It has a preference for hot things. When it rains, steam is said to spout from the tip of its tail.', stats: {'HP': 39, 'ATK': 52, 'DEF': 43, 'SATK': 60, 'SDEF': 50, 'SPD': 65}),
      const Pokemon(name: 'Squirtle', id: '#007', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png', color: Colors.blue, types: ['Water'], weight: 9.0, height: 0.5, moves: ['Torrent', 'Rain-Dish'], description: 'When it retracts its long neck into its shell, it squirts out water with vigorous force.', stats: {'HP': 44, 'ATK': 48, 'DEF': 65, 'SATK': 50, 'SDEF': 64, 'SPD': 43}),
      const Pokemon(name: 'Butterfree', id: '#012', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/12.png', color: Colors.indigo, types: ['Bug', 'Flying'], weight: 32.0, height: 1.1, moves: ['Compound-Eyes', 'Tinted-Lens'], description: 'In battle, it flaps its wings at great speed to release highly toxic dust into the air.', stats: {'HP': 60, 'ATK': 45, 'DEF': 50, 'SATK': 90, 'SDEF': 80, 'SPD': 70}),
      const Pokemon(name: 'Pikachu', id: '#025', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png', color: Colors.yellow, types: ['Electric'], weight: 6.0, height: 0.4, moves: ['Mega-Punch', 'Pay-Day'], description: 'Pikachu that can generate powerful electricity have cheek sacs that are extra soft and super stretchy.', stats: {'HP': 35, 'ATK': 55, 'DEF': 40, 'SATK': 50, 'SDEF': 50, 'SPD': 90}),
      const Pokemon(name: 'Gastly', id: '#092', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/92.png', color: Colors.purple, types: ['Ghost', 'Poison'], weight: 0.1, height: 1.3, moves: ['Levitate'], description: 'Born from gases, anyone would faint if engulfed by its gaseous body, which contains poison.', stats: {'HP': 30, 'ATK': 35, 'DEF': 30, 'SATK': 100, 'SDEF': 35, 'SPD': 80}),
      const Pokemon(name: 'Ditto', id: '#132', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png', color: Colors.grey, types: ['Normal'], weight: 4.0, height: 0.3, moves: ['Limber', 'Imposter'], description: 'It can reconstitute its entire cellular structure to change into what it sees, but it returns to normal when it relaxes.', stats: {'HP': 48, 'ATK': 48, 'DEF': 48, 'SATK': 48, 'SDEF': 48, 'SPD': 48}),
      const Pokemon(name: 'Mew', id: '#151', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/151.png', color: Colors.pink, types: ['Psychic'], weight: 4.0, height: 0.4, moves: ['Synchronize'], description: 'When viewed through a microscope, this Pokémon’s short, fine, delicate hair can be seen.', stats: {'HP': 100, 'ATK': 100, 'DEF': 100, 'SATK': 100, 'SDEF': 100, 'SPD': 100}),
      const Pokemon(name: 'Aron', id: '#304', imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/304.png', color: Colors.blueGrey, types: ['Steel', 'Rock'], weight: 60.0, height: 0.4, moves: ['Sturdy', 'Rock-Head'], description: 'It eats iron ore - and sometimes railroad tracks - to build up the steel armor that protects its body.', stats: {'HP': 50, 'ATK': 70, 'DEF': 100, 'SATK': 40, 'SDEF': 40, 'SPD': 30}),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pokédex',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '#',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_downward),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
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
            ],
          ),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0),
              child: Text(
                pokemon.id,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Image.network(
                pokemon.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: pokemon.color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Text(
                pokemon.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
