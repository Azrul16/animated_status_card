import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedStatusCardGrid extends StatelessWidget {
  const AnimatedStatusCardGrid({
    super.key,
    required this.children,
    this.minChildWidth = 260,
    this.spacing = 20,
    this.runSpacing = 20,
  });

  final List<Widget> children;
  final double minChildWidth;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final rawCount = (constraints.maxWidth / minChildWidth).floor();
        final crossAxisCount = math.max(1, rawCount);
        final itemWidth =
            (constraints.maxWidth - (spacing * (crossAxisCount - 1))) /
            crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children
              .map((child) => SizedBox(width: itemWidth, child: child))
              .toList(),
        );
      },
    );
  }
}
