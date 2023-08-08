import 'dart:convert';

import 'package:anywhere_code_exercise/app/modules/characters/data/models/character_model.dart';
import 'package:anywhere_code_exercise/app/shared/shared.dart';
import 'package:anywhere_code_exercise/core/core.dart';

class CharacterServices {
  static FutureHandler<List<CharacterModel>> getCharacters() {
    return serveFuture<List<CharacterModel>>(
      function: (fail) async {
        final r = await HTTP.get();
        if (r.is200 || r.is201) {
          final response = jsonDecode(r.data);
          List<dynamic> body = response['RelatedTopics'];
          final s = body.map((e) => CharacterModel.fromJson(e)).toList();
          return s;
        }
        return fail('Something went wrong ¯_(ツ)_/¯');
      },
    );
  }
}
