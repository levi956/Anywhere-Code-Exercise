import 'package:anywhere_code_exercise/core/environment/environment_path.dart';
import 'package:flutter/material.dart';

import '../environment/environment.dart';

class SetupVairantTwo {
  static Future<void> run2ndVariant() async {
    WidgetsFlutterBinding.ensureInitialized();
    EnvironmentPaths.load();
    Environment.init(
      flavor: BuildFlavor.wire,
      queryUrl: 'the wire characters',
      defaultImage: wireDefaultImage,
    );
  }
}

const wireDefaultImage =
    'https://upload.wikimedia.org/wikipedia/en/2/2d/The_Wire_-_Season_1.jpg';
