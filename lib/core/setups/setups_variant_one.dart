import 'package:anywhere_code_exercise/core/environment/environment_path.dart';
import 'package:flutter/material.dart';

import '../environment/environment.dart';

class SetupVairantOne {
  static Future<void> run1stVariant() async {
    WidgetsFlutterBinding.ensureInitialized();
    EnvironmentPaths.load();
    Environment.init(
      flavor: BuildFlavor.simpsons,
      queryUrl: 'simpsons characters',
      defaultImage: simpsonsDefaultImage,
    );
  }
}

const simpsonsDefaultImage =
    'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/The_Simpsons_yellow_logo.svg/440px-The_Simpsons_yellow_logo.svg.png';
