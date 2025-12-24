import 'package:dio/dio.dart';
import 'rick_and_morty_model.dart';

class RickAndMortyRepository {
  final Dio _dio = Dio();

  Future<CharacterResponse> getCharacters(int page) async {
    try {
      final response = await _dio.get(
        'https://rickandmortyapi.com/api/character',
        queryParameters: {'page': page},
      );
      return CharacterResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load characters');
    }
  }
}
