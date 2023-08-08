import 'package:anywhere_code_exercise/app/modules/characters/data/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CharacterListTileAtom extends HookConsumerWidget {
  final VoidCallback onTap;
  final CharacterModel character;
  final Color? tileColor;
  const CharacterListTileAtom(
    this.character, {
    super.key,
    required this.onTap,
    this.tileColor,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          character.getCharacterName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
