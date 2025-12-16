import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HPCharacter {
  final String name;
  final String house;
  final String imageUrl;

  const HPCharacter({
    required this.name,
    required this.house,
    required this.imageUrl,
  });

  factory HPCharacter.fromJson(Map<String, dynamic> json) {
    return HPCharacter(
      name: json['name'] ?? 'Unknown Name',
      house: json['house'] ?? 'No House',
      imageUrl: json['image'] ?? '',
    );
  }
}

class CharacterRepository {
  final Dio _dio = Dio();
  final String _url = 'https://hp-api.onrender.com/api/characters';

  Future<List<HPCharacter>> getCharacters() async {
    try {
      final response = await _dio.get(_url);
      final List<dynamic> data = response.data;
      return data
          .map((json) => HPCharacter.fromJson(json))
          .where((character) => character.imageUrl.isNotEmpty)
          .toList();
    } catch (error) {
      throw Exception('Failed to load characters: $error');
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harry Potter Characters',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: CharacterListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CharacterListScreen extends StatefulWidget {
  CharacterListScreen({super.key});

  final CharacterRepository _repository = CharacterRepository();

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late Future<List<HPCharacter>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _charactersFuture = widget._repository.getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
      ),
      body: FutureBuilder<List<HPCharacter>>(
        future: _charactersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No characters found.'));
          }

          final characters = snapshot.data!;
          return ListView.separated(
            itemCount: characters.length,
            separatorBuilder: (context, index) => const Divider(height: 1, indent: 82, endIndent: 16),
            itemBuilder: (context, index) {
              return CharacterCard(character: characters[index]);
            },
          );
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
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
        ],
      ),
    );
  }
}
