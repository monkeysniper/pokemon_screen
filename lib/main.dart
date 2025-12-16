import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'character_bloc.dart';
import 'character_repository.dart';
import 'character_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HPCharacterAdapter());
  await Hive.openBox<HPCharacter>('characters');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CharacterRepository characterRepository = CharacterRepository();

  MyApp({super.key});

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
      home: BlocProvider(
        create: (context) => CharacterBloc(repository: characterRepository)..add(FetchCharacters()),
        child: const CharacterListScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading || state is CharacterInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CharacterError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is CharacterLoaded) {
            return ListView.separated(
              itemCount: state.characters.length,
              separatorBuilder: (context, index) => const Divider(height: 1, indent: 82, endIndent: 16),
              itemBuilder: (context, index) {
                return CharacterCard(character: state.characters[index]);
              },
            );
          }
          return const Center(child: Text('Something went wrong!'));
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
