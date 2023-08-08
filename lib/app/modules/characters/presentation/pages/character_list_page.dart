import 'package:anywhere_code_exercise/app/modules/characters/data/models/character_model.dart';
import 'package:anywhere_code_exercise/app/modules/characters/presentation/atoms/character_list_tile_atom.dart';
import 'package:anywhere_code_exercise/app/modules/characters/presentation/components/character_detail_component.dart';
import 'package:anywhere_code_exercise/app/shared/layout/screen_builder.dart';
import 'package:anywhere_code_exercise/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/provider/characters_provider.dart';
import '../atoms/app_title_atom.dart';
import 'character_detail_page.dart';

class CharacterListPage extends HookConsumerWidget {
  const CharacterListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charactersNotifier = ref.useProvider(getCharactersNotifierProvider);

    final selectedIndex = useState(-1);

    filtered(String query, List<CharacterModel> data) {
      final searched = data.where((d) {
        final k = d.text.toLowerCase();
        final i = query.toLowerCase();
        return k.contains(i);
      }).toList();
      return searched;
    }

    final query = useState('');

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ScreenBuilder(
              builder: (context, size) {
                if (size == LayoutSize.mid) {
                  return charactersNotifier.when(
                    done: (characters) {
                      final queriedCharacters =
                          filtered(query.value, characters);
                      if (queriedCharacters.isEmpty) {
                        return const Text('No characters');
                      }
                      return Column(
                        children: [
                          const SizedBox(height: 30),
                          const AppTitileAtom(),
                          TextField(
                            onChanged: (v) {
                              query.value = v;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Search Character',
                            ),
                          ),
                          Container(
                            height: 30,
                          ),
                          const SizedBox(height: 40),
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  flex: 1,
                                  child: ListView.separated(
                                    separatorBuilder: (_, index) =>
                                        const SizedBox(height: 10),
                                    itemCount: queriedCharacters.length,
                                    itemBuilder: (_, index) {
                                      final character =
                                          queriedCharacters[index];
                                      return CharacterListTileAtom(
                                        character,
                                        tileColor: selectedIndex.value == index
                                            ? Colors.red.withOpacity(.5)
                                            : Colors.grey.withOpacity(.4),
                                        onTap: () {
                                          selectedIndex.value = index;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: CharacterDetailComponent(
                                    selectedIndex: selectedIndex.value,
                                    characters: characters,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    error: (e) => Text(e.toString()),
                    loading: () => const CircularProgressIndicator.adaptive(),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const AppTitileAtom(),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (v) {
                        query.value = v;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Character',
                      ),
                    ),
                    const SizedBox(height: 20),
                    charactersNotifier.when(
                      done: (characters) {
                        final queriedCharacters =
                            filtered(query.value, characters);
                        if (queriedCharacters.isEmpty) {
                          return const Text('No characters');
                        }
                        return Expanded(
                          child: ListView.separated(
                            separatorBuilder: (_, index) =>
                                const Divider(height: 5),
                            itemCount: queriedCharacters.length,
                            itemBuilder: (_, index) {
                              final character = queriedCharacters[index];
                              return CharacterListTileAtom(
                                character,
                                onTap: () => pushTo(
                                  context,
                                  CharacterDetailPage(character),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      error: (e) => Text(
                        e.toString(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      loading: () => const CircularProgressIndicator.adaptive(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
