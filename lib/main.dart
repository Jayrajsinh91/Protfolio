import 'package:flutter/material.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ).copyWith(
          secondary: const Color(0xFF625B71),
          tertiary: const Color(0xFF7D5260),
          background: const Color(0xFFFFFBFE),
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
