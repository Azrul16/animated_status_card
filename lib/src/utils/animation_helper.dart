import 'package:flutter/material.dart';

import '../enums/card_enums.dart';

class AnimationHelper {
  const AnimationHelper._();

  static Widget buildEntryTransition({
    required Widget child,
    required Animation<double> animation,
    required EntryAnimationType type,
  }) {
    if (type == EntryAnimationType.none) {
      return child;
    }

    final fade = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, transitionChild) {
        final slideOffset = Tween<Offset>(
          begin: const Offset(0, 0.12),
          end: Offset.zero,
        ).transform(animation.value);
        final scaleValue = Tween<double>(
          begin: 0.96,
          end: 1,
        ).transform(fade.value);

        return Opacity(
          opacity: type == EntryAnimationType.scale ? 1 : fade.value,
          child: Transform.translate(
            offset: type == EntryAnimationType.slideUp
                ? Offset(0, slideOffset.dy * 60)
                : Offset.zero,
            child: Transform.scale(
              scale: type == EntryAnimationType.scale ? scaleValue : 1,
              child: transitionChild,
            ),
          ),
        );
      },
    );
  }
}
