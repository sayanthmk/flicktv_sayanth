import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ConfettiBackground extends StatelessWidget {
  const ConfettiBackground({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(painter: _ConfettiPainter(progress: progress)),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final random = math.Random(21);
    final leftSideOrigin = Offset(-8, size.height * 0.5);
    final rightSideOrigin = Offset(size.width + 8, size.height * 0.5);
    const launchParticles = 56;
    const rainParticles = 52;
    const launchPhaseEnd = 0.44;
    const rainPhaseStart = 0.42;

    // Phase 1: splash from middle to left/right and vanish at top.
    for (var i = 0; i < launchParticles; i++) {
      final lane = (i % 16) / 16.0;
      final fromLeft = i.isEven;
      final side = fromLeft ? 1.0 : -1.0;
      final origin = fromLeft ? leftSideOrigin : rightSideOrigin;
      final spreadDelay = 0.01 + lane * 0.16 + random.nextDouble() * 0.05;
      final spreadT =
          ((progress - spreadDelay) / (launchPhaseEnd - spreadDelay)).clamp(
            0.0,
            1.0,
          );
      if (spreadT <= 0) continue;

      final spreadXAmount = size.width * (0.3 + random.nextDouble() * 0.28);
      final apexX = origin.dx + side * spreadXAmount;
      final apexY = -18 - random.nextDouble() * 42;

      final x = _lerp(origin.dx, apexX, spreadT);
      final arc = math.sin(spreadT * math.pi) * (26 + random.nextDouble() * 30);
      final y = _lerp(origin.dy, apexY, spreadT) - arc;
      final center = Offset(x, y);

      if (center.dy > size.height + 24 ||
          center.dx < -30 ||
          center.dx > size.width + 30) {
        continue;
      }

      final rect = Rect.fromCenter(
        center: center,
        width: 8 + random.nextDouble() * 6,
        height: 3 + random.nextDouble() * 5,
      );

      final fadeOutTop = (1.0 - ((spreadT - 0.8) / 0.2).clamp(0.0, 1.0));
      paint.color = AppColors.confetti[i % AppColors.confetti.length]
          .withValues(
            alpha: (0.2 + (1 - center.dy / size.height) * 0.65) * fadeOutTop,
          );
      canvas.save();
      canvas.translate(rect.center.dx, rect.center.dy);
      canvas.rotate(progress * 8 + (i * 0.35));
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: rect.width,
            height: rect.height,
          ),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }

    // Phase 2: after splash, rain across full width and fall naturally.
    for (var i = 0; i < rainParticles; i++) {
      final lane = (i % 14) / 14.0;
      final rainDelay =
          rainPhaseStart + lane * 0.34 + random.nextDouble() * 0.14;
      final rainT = ((progress - rainDelay) / (1 - rainDelay)).clamp(0.0, 1.0);
      if (rainT <= 0) continue;

      final startX = random.nextDouble() * size.width;
      final drift = (random.nextDouble() - 0.5) * 92 * rainT;
      final y = -24 + (rainT * rainT) * (size.height + 150);
      final center = Offset(startX + drift, y);

      if (center.dy > size.height + 24 ||
          center.dx < -30 ||
          center.dx > size.width + 30) {
        continue;
      }

      final rect = Rect.fromCenter(
        center: center,
        width: 8 + random.nextDouble() * 6,
        height: 3 + random.nextDouble() * 5,
      );

      final fadeOutTail = (1.0 - ((progress - 0.95) / 0.05).clamp(0.0, 1.0));
      paint.color = AppColors.confetti[(i + 2) % AppColors.confetti.length]
          .withValues(
            alpha: (0.22 + (1 - center.dy / size.height) * 0.7) * fadeOutTail,
          );
      canvas.save();
      canvas.translate(rect.center.dx, rect.center.dy);
      canvas.rotate(progress * 7.4 + (i * 0.5));
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: rect.width,
            height: rect.height,
          ),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;
}
