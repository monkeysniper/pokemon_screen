import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_model.dart';
import 'video_repository.dart';

abstract class VideoState {}
class VideoInitial extends VideoState {}
class VideoLoading extends VideoState {}
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
      oldVideos = currentState.videos;
    }

    emit(VideoLoading());

    try {
      final newVideos = await repository.getVideos(_currentPage);
      _currentPage++;
      emit(VideoLoaded(oldVideos + newVideos, hasReachedMax: newVideos.isEmpty));
    } catch (e) {
      emit(VideoError());
    }
  }
}
