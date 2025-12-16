import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'character_model.dart';

class CharacterRepository {
  final Dio _dio = Dio();
  final String _url = 'https://hp-api.onrender.com/api/characters';
  final Box<HPCharacter> _characterBox = Hive.box<HPCharacter>('characters');

  Future<List<HPCharacter>> fetchCharactersFromApi() async {
    try {
      final response = await _dio.get(_url);
      final List<dynamic> data = response.data;
      return data
          .map((json) => HPCharacter.fromJson(json))
          .where((character) => character.imageUrl.isNotEmpty)
          .toList();
    } catch (error) {
      throw Exception('Failed to load characters from API: $error');
    }
  }

  List<HPCharacter> getCachedCharacters() {
    return _characterBox.values.toList();
  }

  Future<void> cacheCharacters(List<HPCharacter> characters) async {
    await _characterBox.clear();
    await _characterBox.addAll(characters);
  }
}
