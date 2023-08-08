import 'package:anywhere_code_exercise/app/modules/characters/presentation/pages/character_list_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CharacterListPage(),
    );
  }
}
