import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'core/core.dart';

void main() async {
  await SetupVairantTwo.run2ndVariant();
  runApp(const ProviderScope(child: App()));
}
