import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_model.dart';
import 'video_repository.dart';

abstract class VideoState {}
class VideoInitial extends VideoState {}
class VideoLoading extends VideoState {
  final List<VideoModel> oldVideos;
  final bool isFirstFetch;
  VideoLoading(this.oldVideos, {this.isFirstFetch = false});
}
class VideoLoaded extends VideoState {
  final List<VideoModel> videos;
  final bool hasReachedMax;
  VideoLoaded(this.videos, {this.hasReachedMax = false});
}
class VideoError extends VideoState {}

class VideoCubit extends Cubit<VideoState> {
  final VideoRepository repository;
  int _currentPage = 1;

  VideoCubit(this.repository) : super(VideoInitial());

  Future<void> fetchVideos() async {
    if (state is VideoLoading) return;

    final currentState = state;
    List<VideoModel> oldVideos = [];
    if (currentState is VideoLoaded) {
      if (currentState.hasReachedMax) return;
      oldVideos = currentState.videos;
    }

    emit(VideoLoading(oldVideos, isFirstFetch: _currentPage == 1));

    try {
      final newVideos = await repository.getVideos(_currentPage);
      _currentPage++;
      final allVideos = oldVideos + newVideos;
      emit(VideoLoaded(allVideos, hasReachedMax: newVideos.isEmpty));
    } catch (e) {
      emit(VideoError());
    }
  }
}
