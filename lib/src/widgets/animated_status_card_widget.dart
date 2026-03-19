import 'dart:ui';

import 'package:flutter/material.dart';

import '../enums/card_enums.dart';
import '../models/status_card_theme_data.dart';
import '../painters/optional_background_painter.dart';
import '../utils/animation_helper.dart';
import '../utils/card_color_helper.dart';
import 'animated_status_shimmer_card.dart';
import 'trend_chip.dart';

class AnimatedStatusCard extends StatefulWidget {
  const AnimatedStatusCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.trendValue,
    this.trendDirection = TrendDirection.neutral,
    this.styleType = CardStyleType.simple,
    this.statusType = CardStatusType.info,
    this.animationType = EntryAnimationType.slideUp,
    this.duration = const Duration(milliseconds: 500),
    this.isLoading = false,
    this.animateOnValueChange = true,
    this.onTap,
    this.badge,
    this.trailing,
    this.footer,
    this.height = 208,
    this.borderRadius = 24,
    this.accentColor,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final String? trendValue;
  final TrendDirection trendDirection;
  final CardStyleType styleType;
  final CardStatusType statusType;
  final EntryAnimationType animationType;
  final Duration duration;
  final bool isLoading;
  final bool animateOnValueChange;
  final VoidCallback? onTap;
  final Widget? badge;
  final Widget? trailing;
  final Widget? footer;
  final double height;
  final double borderRadius;
  final Color? accentColor;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  State<AnimatedStatusCard> createState() => _AnimatedStatusCardState();
}

class _AnimatedStatusCardState extends State<AnimatedStatusCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entryController;

  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return AnimatedStatusShimmerCard(
        height: widget.height,
        borderRadius: widget.borderRadius,
      );
    }

    final palette = CardColorHelper.resolve(
      context,
      statusType: widget.statusType,
      styleType: widget.styleType,
      accentColor: widget.accentColor,
      backgroundColor: widget.backgroundColor,
      foregroundColor: widget.foregroundColor,
      borderRadius: widget.borderRadius,
    );

    final shadowStrength = _isPressed ? 0.10 : (_isHovered ? 0.18 : 0.12);
    final lift = _isPressed ? 0.985 : (_isHovered ? 1.015 : 1.0);
    final borderSideColor = widget.styleType == CardStyleType.outlined
        ? palette.accentColor.withValues(alpha: 0.34)
        : palette.borderColor;

    final child = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _isPressed = false;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapCancel: () => setState(() => _isPressed = false),
        onTapUp: (_) => setState(() => _isPressed = false),
        child: AnimatedScale(
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 160),
          scale: lift,
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.styleType == CardStyleType.gradient
                  ? null
                  : palette.backgroundColor,
              gradient: palette.gradient,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(color: borderSideColor),
              boxShadow: [
                BoxShadow(
                  color: palette.shadowColor.withValues(alpha: shadowStrength),
                  blurRadius: _isHovered ? 24 : 18,
                  spreadRadius: _isHovered ? 1 : 0,
                  offset: Offset(0, _isHovered ? 14 : 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: widget.styleType == CardStyleType.glass ? 14 : 0,
                  sigmaY: widget.styleType == CardStyleType.glass ? 14 : 0,
                ),
                child: CustomPaint(
                  painter: OptionalBackgroundPainter(
                    accentColor: palette.accentColor,
                    isGlass: widget.styleType == CardStyleType.glass,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isCompact =
                          constraints.maxWidth <= 320 || widget.badge != null;
                      final padding = isCompact ? 18.0 : 20.0;
                      final valueStyle =
                          (isCompact
                                  ? Theme.of(context).textTheme.headlineSmall
                                  : Theme.of(context).textTheme.headlineMedium)
                              ?.copyWith(
                                color: palette.foregroundColor,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.8,
                              );

                      return Padding(
                        padding: EdgeInsets.all(padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Header(
                              title: widget.title,
                              icon: widget.icon,
                              trailing: widget.trailing,
                              badge: widget.badge,
                              palette: palette,
                              styleType: widget.styleType,
                              compact: isCompact,
                            ),
                            const Spacer(),
                            _AnimatedValueText(
                              value: widget.value,
                              animateOnValueChange: widget.animateOnValueChange,
                              style: valueStyle,
                            ),
                            if (widget.subtitle != null) ...[
                              SizedBox(height: isCompact ? 6 : 8),
                              Text(
                                widget.subtitle!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: palette.foregroundColor.withValues(
                                        alpha: 0.74,
                                      ),
                                    ),
                              ),
                            ],
                            SizedBox(height: isCompact ? 12 : 16),
                            Row(
                              children: [
                                if (widget.trendValue != null)
                                  TrendChip(
                                    direction: widget.trendDirection,
                                    label: widget.trendValue!,
                                    color: palette.accentColor,
                                    foregroundColor:
                                        widget.styleType ==
                                            CardStyleType.gradient
                                        ? Colors.white
                                        : palette.foregroundColor,
                                    compact: isCompact,
                                  ),
                                if (widget.footer != null) ...[
                                  SizedBox(width: isCompact ? 8 : 12),
                                  Expanded(child: widget.footer!),
                                ],
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return AnimationHelper.buildEntryTransition(
      child: child,
      animation: _entryController,
      type: widget.animationType,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.icon,
    required this.trailing,
    required this.badge,
    required this.palette,
    required this.styleType,
    required this.compact,
  });

  final String title;
  final IconData? icon;
  final Widget? trailing;
  final Widget? badge;
  final StatusCardThemeData palette;
  final CardStyleType styleType;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Container(
            width: compact ? 46 : 52,
            height: compact ? 46 : 52,
            decoration: BoxDecoration(
              color: styleType == CardStyleType.gradient
                  ? Colors.white.withValues(alpha: 0.16)
                  : palette.accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(compact ? 16 : 18),
              border: Border.all(
                color: styleType == CardStyleType.gradient
                    ? Colors.white.withValues(alpha: 0.18)
                    : palette.borderColor,
              ),
            ),
            child: Icon(
              icon,
              color: styleType == CardStyleType.gradient
                  ? Colors.white
                  : palette.accentColor,
              size: compact ? 22 : 24,
            ),
          ),
        if (icon != null) SizedBox(width: compact ? 12 : 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    (compact
                            ? Theme.of(context).textTheme.titleSmall
                            : Theme.of(context).textTheme.titleMedium)
                        ?.copyWith(
                          color: palette.foregroundColor,
                          fontWeight: FontWeight.w700,
                        ),
              ),
              if (badge != null) ...[
                SizedBox(height: compact ? 8 : 10),
                badge!,
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          SizedBox(width: compact ? 10 : 12),
          trailing!,
        ],
      ],
    );
  }
}

class _AnimatedValueText extends StatefulWidget {
  const _AnimatedValueText({
    required this.value,
    required this.style,
    required this.animateOnValueChange,
  });

  final String value;
  final TextStyle? style;
  final bool animateOnValueChange;

  @override
  State<_AnimatedValueText> createState() => _AnimatedValueTextState();
}

class _AnimatedValueTextState extends State<_AnimatedValueText> {
  double? _previousNumericValue;

  @override
  void initState() {
    super.initState();
    _previousNumericValue = _ParsedDisplayValue.tryParse(
      widget.value,
    )?.numericValue;
  }

  @override
  void didUpdateWidget(covariant _AnimatedValueText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousNumericValue = _ParsedDisplayValue.tryParse(
        oldWidget.value,
      )?.numericValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.animateOnValueChange) {
      return Text(widget.value, style: widget.style);
    }

    final parsed = _ParsedDisplayValue.tryParse(widget.value);
    if (parsed != null) {
      return TweenAnimationBuilder<double>(
        key: ValueKey(widget.value),
        tween: Tween<double>(
          begin: _previousNumericValue ?? parsed.numericValue,
          end: parsed.numericValue,
        ),
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeOutCubic,
        builder: (context, value, _) {
          return Text(parsed.format(value), style: widget.style);
        },
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),
        );
      },
      child: Text(
        widget.value,
        key: ValueKey(widget.value),
        style: widget.style,
      ),
    );
  }
}

class _ParsedDisplayValue {
  const _ParsedDisplayValue({
    required this.prefix,
    required this.numericValue,
    required this.suffix,
    required this.decimalDigits,
  });

  final String prefix;
  final double numericValue;
  final String suffix;
  final int decimalDigits;

  static final RegExp _pattern = RegExp(
    r'^\s*([^0-9+\-]*)([+\-]?\d[\d,]*(?:\.\d+)?)(.*)\s*$',
  );

  static _ParsedDisplayValue? tryParse(String value) {
    final match = _pattern.firstMatch(value);
    if (match == null) {
      return null;
    }

    final numericRaw = match.group(2)?.replaceAll(',', '');
    if (numericRaw == null) {
      return null;
    }

    final numericValue = double.tryParse(numericRaw);
    if (numericValue == null) {
      return null;
    }

    final decimalDigits = numericRaw.contains('.')
        ? numericRaw.split('.').last.length
        : 0;

    return _ParsedDisplayValue(
      prefix: match.group(1) ?? '',
      numericValue: numericValue,
      suffix: match.group(3) ?? '',
      decimalDigits: decimalDigits,
    );
  }

  String format(double value) {
    final fixed = value.toStringAsFixed(decimalDigits);
    final parts = fixed.split('.');
    final whole = _addGrouping(parts.first);
    final fraction = parts.length > 1 ? '.${parts[1]}' : '';
    return '$prefix$whole$fraction$suffix';
  }

  static String _addGrouping(String value) {
    final isNegative = value.startsWith('-');
    final digits = isNegative ? value.substring(1) : value;
    final buffer = StringBuffer();

    for (var index = 0; index < digits.length; index++) {
      final reverseIndex = digits.length - index;
      buffer.write(digits[index]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write(',');
      }
    }

    return isNegative ? '-$buffer' : buffer.toString();
  }
}
