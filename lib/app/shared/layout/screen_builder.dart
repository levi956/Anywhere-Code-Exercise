import 'package:flutter/material.dart';

class ScreenBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, LayoutSize size) builder;
  const ScreenBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return builder(
          context,
          getSize(context),
        );
      },
    );
  }

  LayoutSize getSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    bool isSmall = width <= 900.0;
    bool isSmaller = width <= 535.0;
    LayoutSize size = LayoutSize.large;
    if (isSmaller) {
      size = LayoutSize.min;
    } else if (isSmall) {
      size = LayoutSize.mid;
    }
    return size;
  }
}

enum LayoutSize { min, mid, large }
