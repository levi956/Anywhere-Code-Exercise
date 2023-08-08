import 'package:anywhere_code_exercise/app/shared/shared.dart';
import 'package:anywhere_code_exercise/core/core.dart';

class CharacterModel {
  String firstUrl;
  IconData icon;
  String result;
  String text;

  String get getCharacterName => removePrefix(firstUrl).replaceAll('_', ' ');

  CharacterModel({
    required this.firstUrl,
    required this.icon,
    required this.result,
    required this.text,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        firstUrl: json["FirstURL"],
        icon: IconData.fromJson(json["Icon"]),
        result: json["Result"],
        text: json["Text"],
      );
}

class IconData {
  String height;
  String? url;
  String width;

  String get appendUrl =>
      url!.isNotEmpty ? '$imageBaseUrl$url' : env.defaultImage;

  IconData({
    required this.height,
    this.url,
    required this.width,
  });

  factory IconData.fromJson(Map<String, dynamic> json) => IconData(
        height: json["Height"],
        url: json["URL"] ?? env.defaultImage,
        width: json["Width"],
      );
}

const imageBaseUrl = 'https://duckduckgo.com';
