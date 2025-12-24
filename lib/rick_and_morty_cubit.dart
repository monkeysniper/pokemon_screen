import 'package:flutter_bloc/flutter_bloc.dart';
import 'rick_and_morty_model.dart';
import 'rick_and_morty_repository.dart';

abstract class RMState {}
class RMInitial extends RMState {}
class RMLoading extends RMState {
  final List<RMCharacter> oldResults;
  final bool isFirstFetch;
  RMLoading(this.oldResults, {this.isFirstFetch = false});
}
class RMLoaded extends RMState {
  final List<RMCharacter> results;
  final bool hasReachedMax;
  RMLoaded(this.results, {this.hasReachedMax = false});
}
class RMError extends RMState {}

class RMCubit extends Cubit<RMState> {
  final RickAndMortyRepository repository;
  int _currentPage = 1;
  final List<RMCharacter> _allResults = [];

  RMCubit(this.repository) : super(RMInitial());

  Future<void> fetchCharacters() async {
    if (state is RMLoading) return;

    final currentState = state;
    if (currentState is RMLoaded && currentState.hasReachedMax) return;

    emit(RMLoading(_allResults, isFirstFetch: _currentPage == 1));

    try {
      final response = await repository.getCharacters(_currentPage);
      _allResults.addAll(response.results);
      
      final bool hasReachedMax = response.info.next == null;
      _currentPage++;
      
      emit(RMLoaded(List.from(_allResults), hasReachedMax: hasReachedMax));
    } catch (e) {
      emit(RMError());
    }
  }
}
