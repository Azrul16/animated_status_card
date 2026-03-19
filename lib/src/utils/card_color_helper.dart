import 'package:flutter/material.dart';

import '../enums/card_enums.dart';
import '../models/status_card_theme_data.dart';

class CardColorHelper {
  const CardColorHelper._();

  static StatusCardThemeData resolve(
    BuildContext context, {
    required CardStatusType statusType,
    required CardStyleType styleType,
    Color? accentColor,
    Color? backgroundColor,
    Color? foregroundColor,
    double borderRadius = 24,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final brightness = theme.brightness;

    final Color seed =
        accentColor ??
        switch (statusType) {
          CardStatusType.success => const Color(0xFF22C55E),
          CardStatusType.warning => const Color(0xFFF59E0B),
          CardStatusType.danger => const Color(0xFFEF4444),
          CardStatusType.info => const Color(0xFF3B82F6),
          CardStatusType.neutral => const Color(0xFF64748B),
        };

    final baseBackground =
        backgroundColor ??
        (brightness == Brightness.dark
            ? Color.alphaBlend(seed.withValues(alpha: 0.10), scheme.surface)
            : Colors.white);

    final baseForeground =
        foregroundColor ??
        (styleType == CardStyleType.gradient
            ? Colors.white
            : theme.textTheme.bodyLarge?.color ?? scheme.onSurface);

    final borderColor = styleType == CardStyleType.outlined
        ? seed.withValues(alpha: 0.35)
        : seed.withValues(alpha: brightness == Brightness.dark ? 0.20 : 0.14);

    final shadowColor =
        styleType == CardStyleType.gradient || styleType == CardStyleType.glass
        ? seed.withValues(alpha: 0.20)
        : Colors.black.withValues(
            alpha: brightness == Brightness.dark ? 0.16 : 0.08,
          );

    final gradient = switch (styleType) {
      CardStyleType.gradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          seed.withValues(alpha: 0.96),
          Color.lerp(seed, Colors.black, 0.18)!,
        ],
      ),
      CardStyleType.glass => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(
            alpha: brightness == Brightness.dark ? 0.08 : 0.54,
          ),
          seed.withValues(alpha: brightness == Brightness.dark ? 0.16 : 0.12),
        ],
      ),
      _ => null,
    };

    return StatusCardThemeData(
      backgroundColor: baseBackground,
      foregroundColor: baseForeground,
      accentColor: seed,
      borderColor: borderColor,
      shadowColor: shadowColor,
      gradient: gradient,
      borderRadius: borderRadius,
    );
  }
}
