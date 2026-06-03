import 'package:flutter/material.dart';

class MoneyTitle extends StatelessWidget {
  const MoneyTitle({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'blinkit',
          style: TextStyle(
            fontSize: 24 * scale,
            fontWeight: FontWeight.w800,
            height: 0.95,
          ),
        ),
        Text(
          'MONEY',
          style: TextStyle(
            fontSize: 52 * scale,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.6 * scale,
            height: 0.9,
          ),
        ),
      ],
    );
  }
}
