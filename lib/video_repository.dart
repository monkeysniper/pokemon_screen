import 'package:dio/dio.dart';
import 'video_model.dart';

class VideoRepository {
  final Dio _dio = Dio();
  final String _apiKey = 'YOUR_PEXELS_API_KEY';

  Future<List<VideoModel>> getVideos(int page) async {
    try {
      final response = await _dio.get(
        'https://api.pexels.com/videos/popular',
        queryParameters: {'page': page, 'per_page': 10},
        options: Options(headers: {'Authorization': _apiKey}),
      );
      
      final List data = response.data['videos'];
      return data.map((json) => VideoModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load videos');
    }
  }
}
