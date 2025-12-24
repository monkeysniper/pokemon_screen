import 'package:flutter/material.dart';
import 'package:pokemon_screen/character_model.dart';
import 'package:pokemon_screen/character_detail_screen.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<HPCharacter> characters = [
       HPCharacter(
        name: 'Harry Potter',
        house: 'Gryffindor',
        imageUrl: 'https://hp-api.herokuapp.com/images/harry.jpg',
        description: 'The boy who lived.',
        wand: '11" Holly, phoenix feather core',
        patronus: 'Stag',
      ),
      HPCharacter(
        name: 'Hermione Granger',
        house: 'Gryffindor',
        imageUrl: 'https://hp-api.herokuapp.com/images/hermione.jpeg',
        description: 'The brightest witch of her age.',
        wand: '10¾" vine wood, dragon heartstring core',
        patronus: 'Otter',
      ),
      HPCharacter(
        name: 'Ron Weasley',
        house: 'Gryffindor',
        imageUrl: 'https://hp-api.herokuapp.com/images/ron.jpg',
        description: 'King of our hearts.',
        wand: '14" Willow, unicorn tail hair core',
        patronus: 'Jack Russell terrier',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
      ),
      body: ListView.separated(
        itemCount: characters.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return CharacterCard(character: characters[index]);
        },
      ),
    );
  }
}

class CharacterCard extends StatelessWidget {
  final HPCharacter character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailScreen(character: character),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Hero(
                tag: character.imageUrl,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    character.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.person));
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    character.house,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
