import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'rick_and_morty_cubit.dart';
import 'rick_and_morty_repository.dart';
import 'rick_and_morty_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty Pagination',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => RMCubit(RickAndMortyRepository())..fetchCharacters(),
        child: const CharacterListScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      context.read<RMCubit>().fetchCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Characters'),
      ),
      body: BlocBuilder<RMCubit, RMState>(
        builder: (context, state) {
          if (state is RMInitial || (state is RMLoading && state.isFirstFetch)) {
            return const Center(child: CircularProgressIndicator());
          }

          List<RMCharacter> characters = [];
          bool isLoading = false;
          bool hasReachedMax = false;

          if (state is RMLoading) {
            characters = state.oldResults;
            isLoading = true;
          } else if (state is RMLoaded) {
            characters = state.results;
            hasReachedMax = state.hasReachedMax;
          } else if (state is RMError) {
            return const Center(child: Text('Error loading characters'));
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: characters.length + (hasReachedMax ? 0 : 1),
            itemBuilder: (context, index) {
              if (index < characters.length) {
                final character = characters[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(character.image),
                  ),
                  title: Text(character.name),
                  subtitle: Text('${character.species} - ${character.status}'),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
