import 'package:anywhere_code_exercise/app/modules/characters/data/models/character_model.dart';
import 'package:anywhere_code_exercise/core/framework/navigatior.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterDetailPage extends StatelessWidget {
  final CharacterModel character;
  const CharacterDetailPage(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: character.icon.appendUrl,
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
                character.text,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
