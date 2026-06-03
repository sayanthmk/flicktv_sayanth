import 'package:flutter/material.dart';

import '../shared/theme/app_theme.dart';
import '../features/blinkit_money/presentation/screens/blinkit_screen.dart';

class sayanthApp extends StatelessWidget {
  const sayanthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sayanth',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const BlinkitMoneyScreen(),
    );
  }
}
