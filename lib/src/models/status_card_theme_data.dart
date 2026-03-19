import 'package:flutter/material.dart';

@immutable
class StatusCardThemeData {
  const StatusCardThemeData({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.accentColor,
    required this.borderColor,
    required this.shadowColor,
    this.gradient,
    this.borderRadius = 24,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color accentColor;
  final Color borderColor;
  final Color shadowColor;
  final Gradient? gradient;
  final double borderRadius;

  StatusCardThemeData copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? accentColor,
    Color? borderColor,
    Color? shadowColor,
    Gradient? gradient,
    double? borderRadius,
  }) {
    return StatusCardThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      accentColor: accentColor ?? this.accentColor,
      borderColor: borderColor ?? this.borderColor,
      shadowColor: shadowColor ?? this.shadowColor,
      gradient: gradient ?? this.gradient,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
