import 'dart:math' as math;

import 'package:flutter/material.dart';

class BlinkitMoneyAnimations {
  BlinkitMoneyAnimations({required TickerProvider vsync})
    : masterController = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 5000),
      ) {
    confettiProgress = CurvedAnimation(
      parent: masterController,
      curve: const Interval(0.22, 1.0, curve: Curves.easeOut),
    );

    // Start after 0.5s, then drop in next 0.5s.
    logoDropOffsetFactor = Tween<double>(begin: 0.0, end: 0.012).animate(
      CurvedAnimation(
        parent: masterController,
        curve: const Interval(0.10, 0.20, curve: Curves.easeOutCubic),
      ),
    );

    logoScale = ConstantTween<double>(1.0).animate(masterController);

    logoTopOffsetFactor = Tween<double>(begin: 0.0, end: -0.10).animate(
      CurvedAnimation(
        parent: masterController,
        curve: const Interval(0.62, 0.82, curve: Curves.easeInOutCubic),
      ),
    );

    titleSlide = Tween<double>(begin: 720, end: 0).animate(
      CurvedAnimation(
        parent: masterController,
        curve: const Interval(0.32, 0.52, curve: Curves.easeOutCubic),
      ),
    );

    titleOpacity = CurvedAnimation(
      parent: masterController,
      curve: const Interval(0.36, 0.52, curve: Curves.easeIn),
    );

    cardsOpacity = CurvedAnimation(
      parent: masterController,
      curve: const Interval(0.72, 0.94, curve: Curves.easeOut),
    );

    const starts = [0.74, 0.79, 0.84, 0.89, 0.92];
    staggeredItemOpacity = starts
        .map(
          (start) => CurvedAnimation(
            parent: masterController,
            curve: Interval(
              start,
              math.min(start + 0.14, 0.98),
              curve: Curves.easeOutCubic,
            ),
          ),
        )
        .toList(growable: false);

    staggeredItemSlide = staggeredItemOpacity
        .map((animation) => Tween<double>(begin: 10, end: 0).animate(animation))
        .toList(growable: false);
  }

  final AnimationController masterController;

  late final Animation<double> confettiProgress;
  late final Animation<double> logoDropOffsetFactor;
  late final Animation<double> logoScale;
  late final Animation<double> logoTopOffsetFactor;
  late final Animation<double> titleSlide;
  late final Animation<double> titleOpacity;
  late final Animation<double> cardsOpacity;
  late final List<Animation<double>> staggeredItemOpacity;
  late final List<Animation<double>> staggeredItemSlide;

  Listenable get merged => masterController;

  void start() {
    masterController.forward();
  }

  void dispose() {
    masterController.dispose();
  }
}
