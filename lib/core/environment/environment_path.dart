import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentPaths {
  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }
}

const nullString = 'NULL';
