import 'package:anywhere_code_exercise/app/modules/characters/data/models/character_model.dart';
import 'package:anywhere_code_exercise/core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterDetailComponent extends StatelessWidget {
  final int selectedIndex;
  final List<CharacterModel> characters;
  const CharacterDetailComponent({
    super.key,
    required this.selectedIndex,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    final content = selectedIndex != -1
        ? 'Detail for Item ${characters[selectedIndex].text}'
        : 'No item selected';

    final image = selectedIndex != -1
        ? characters[selectedIndex].icon.appendUrl
        : env.defaultImage;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: image,
            alignment: Alignment.center,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'About',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            content,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}
