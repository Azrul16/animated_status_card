import 'package:flutter/material.dart';

import '../enums/card_enums.dart';
import '../utils/card_color_helper.dart';
import 'trend_chip.dart';

class AnimatedMiniStatusCard extends StatelessWidget {
  const AnimatedMiniStatusCard({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.trendValue,
    this.trendDirection = TrendDirection.neutral,
    this.statusType = CardStatusType.info,
    this.onTap,
  });

  final String title;
  final String value;
  final IconData? icon;
  final String? trendValue;
  final TrendDirection trendDirection;
  final CardStatusType statusType;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final palette = CardColorHelper.resolve(
      context,
      statusType: statusType,
      styleType: CardStyleType.minimal,
      borderRadius: 20,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(palette.borderRadius),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: palette.backgroundColor,
            borderRadius: BorderRadius.circular(palette.borderRadius),
            border: Border.all(color: palette.borderColor),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: palette.accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: palette.accentColor, size: 20),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              if (trendValue != null)
                TrendChip(
                  direction: trendDirection,
                  label: trendValue!,
                  color: palette.accentColor,
                  foregroundColor: palette.foregroundColor,
                  compact: true,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
