import 'package:bloc/bloc.dart';
import 'package:bloc_app/data/models/characters.dart';
import 'package:bloc_app/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  Future<void> getAllCharacters() async {
    final characters = await charactersRepository.getAllCharacters();
    emit(CharactersLoaded(characters));
    this.characters = characters;
  }
}
