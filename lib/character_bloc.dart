import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'character_repository.dart';
import 'character_model.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();
  @override
  List<Object> get props => [];
}

class FetchCharacters extends CharacterEvent {}

abstract class CharacterState extends Equatable {
  const CharacterState();
  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<HPCharacter> characters;
  const CharacterLoaded(this.characters);
  @override
  List<Object> get props => [characters];
}

class CharacterError extends CharacterState {
  final String message;
  const CharacterError(this.message);
  @override
  List<Object> get props => [message];
}

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository repository;

  CharacterBloc({required this.repository}) : super(CharacterInitial()) {
    on<FetchCharacters>((event, emit) async {
      try {
        final cachedCharacters = repository.getCachedCharacters();
        if (cachedCharacters.isNotEmpty) {
          emit(CharacterLoaded(cachedCharacters));
        }
      } catch (e) {

      }

      try {
        emit(CharacterLoading());
        final characters = await repository.fetchCharactersFromApi();
        await repository.cacheCharacters(characters);
        emit(CharacterLoaded(characters));
      } catch (e) {
        final cachedCharacters = repository.getCachedCharacters();
        if (cachedCharacters.isNotEmpty) {
          emit(CharacterLoaded(cachedCharacters));
        } else {
          emit(CharacterError(e.toString()));
        }
      }
    });
  }
}
