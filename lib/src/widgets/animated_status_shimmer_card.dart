import 'package:flutter/material.dart';

class AnimatedStatusShimmerCard extends StatefulWidget {
  const AnimatedStatusShimmerCard({
    super.key,
    this.height = 208,
    this.borderRadius = 24,
  });

  final double height;
  final double borderRadius;

  @override
  State<AnimatedStatusShimmerCard> createState() =>
      _AnimatedStatusShimmerCardState();
}

class _AnimatedStatusShimmerCardState extends State<AnimatedStatusShimmerCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = Color.alphaBlend(
      scheme.primary.withValues(alpha: 0.04),
      scheme.surfaceContainerHighest.withValues(alpha: 0.65),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: base,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (bounds) {
                final progress = _controller.value;
                return LinearGradient(
                  begin: Alignment(-1.2 + (progress * 2.4), -0.2),
                  end: Alignment(-0.2 + (progress * 2.4), 0.2),
                  colors: [
                    Colors.white.withValues(alpha: 0.00),
                    Colors.white.withValues(alpha: 0.28),
                    Colors.white.withValues(alpha: 0.00),
                  ],
                  stops: const [0.15, 0.5, 0.85],
                ).createShader(bounds);
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _block(width: 48, height: 48),
                        const Spacer(),
                        _block(width: 72, height: 24),
                      ],
                    ),
                    const Spacer(),
                    _block(width: 110, height: 14),
                    const SizedBox(height: 14),
                    _block(width: 160, height: 32),
                    const SizedBox(height: 10),
                    _block(width: 140, height: 12),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _block({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
