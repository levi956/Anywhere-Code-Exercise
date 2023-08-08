import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class AppTitileAtom extends StatelessWidget {
  const AppTitileAtom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'The ${env.flavor.name.toUpperCase()} Show Characters',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }
}
