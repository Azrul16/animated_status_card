import 'package:flutter/material.dart';

import '../enums/card_enums.dart';

class TrendChip extends StatelessWidget {
  const TrendChip({
    super.key,
    required this.direction,
    required this.label,
    required this.color,
    required this.foregroundColor,
    this.compact = false,
  });

  final TrendDirection direction;
  final String label;
  final Color color;
  final Color foregroundColor;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final icon = switch (direction) {
      TrendDirection.up => Icons.north_east_rounded,
      TrendDirection.down => Icons.south_east_rounded,
      TrendDirection.neutral => Icons.remove_rounded,
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 5 : 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: compact ? 14 : 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
