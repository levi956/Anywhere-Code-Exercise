import 'package:anywhere_code_exercise/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';

void main() async {
  await SetupVairantOne.run1stVariant();
  runApp(const ProviderScope(child: App()));
}
