enum BuildFlavor { simpsons, wire }

Environment get env => _env!;
Environment? _env;

class Environment {
  final String queryPathUrl;
  final BuildFlavor flavor;
  final String defaultImage;

  Environment._init({
    required this.flavor,
    required this.queryPathUrl,
    required this.defaultImage,
  });

  static void init(
      {required BuildFlavor flavor,
      required String queryUrl,
      required String defaultImage}) {
    _env ??= Environment._init(
      flavor: flavor,
      queryPathUrl: queryUrl,
      defaultImage: defaultImage,
    );
  }
}
