import 'package:flutter/material.dart';

class OptionalBackgroundPainter extends CustomPainter {
  const OptionalBackgroundPainter({
    required this.accentColor,
    required this.isGlass,
  });

  final Color accentColor;
  final bool isGlass;

  @override
  void paint(Canvas canvas, Size size) {
    final topGlow = Paint()
      ..shader =
          RadialGradient(
            colors: [
              accentColor.withValues(alpha: isGlass ? 0.22 : 0.16),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.8, 0),
              radius: size.width * 0.45,
            ),
          );

    final bottomGlow = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Colors.white.withValues(alpha: isGlass ? 0.10 : 0.04),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawCircle(
      Offset(size.width * 0.82, size.height * 0.14),
      size.width * 0.30,
      topGlow,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.55,
          size.height * 0.56,
          size.width * 0.35,
          size.height * 0.24,
        ),
        const Radius.circular(40),
      ),
      bottomGlow,
    );
  }

  @override
  bool shouldRepaint(covariant OptionalBackgroundPainter oldDelegate) {
    return oldDelegate.accentColor != accentColor ||
        oldDelegate.isGlass != isGlass;
  }
}
