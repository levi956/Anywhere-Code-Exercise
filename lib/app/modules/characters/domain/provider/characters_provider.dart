import 'package:anywhere_code_exercise/app/modules/characters/domain/repository/characters_repository.dart';
import 'package:anywhere_code_exercise/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/models/character_model.dart';

final getCharactersNotifierProvider = StateNotifierProvider<
    GetCharactersNotifier, NotifierState<List<CharacterModel>>>((ref) {
  final repo = ref.read(characterRepositoryProvider);
  return GetCharactersNotifier(repo);
});

class GetCharactersNotifier extends BaseNotifier<List<CharacterModel>> {
  final CharactersRepository _repo;

  GetCharactersNotifier(this._repo);

  @override
  void onInit() {
    getCharacters();
    super.onInit();
  }

  Future<void> getCharacters() async {
    setLoading();
    state = await _repo.getCharacters();
  }

  void reload() async {
    final refreshed = await _repo.getCharacters();
    state = notifyData(value: refreshed.data);
  }
}
