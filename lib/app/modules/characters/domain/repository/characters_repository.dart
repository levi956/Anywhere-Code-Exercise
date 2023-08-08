import 'package:anywhere_code_exercise/app/modules/characters/domain/services/character_services.dart';
import 'package:anywhere_code_exercise/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/models/character_model.dart';

final characterRepositoryProvider = Provider<CharactersRepository>((ref) {
  return CharactersRepository(ref);
});

class CharactersRepository {
  ProviderRef ref;

  CharactersRepository(this.ref);

  FutureNotifierState<List<CharacterModel>> getCharacters() async {
    return convert(CharacterServices.getCharacters);
  }
}
