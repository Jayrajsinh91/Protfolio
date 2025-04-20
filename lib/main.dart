import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'presentation/screens/home_screen.dart';

void main() async { 
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  runApp(const PortfolioApp());
  FlutterNativeSplash.remove();
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jay's Portfolio",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF4A00E0),     // Deep Purple
          secondary: const Color(0xFF8E2DE2),    // Medium Purple
          surface: Colors.white.withOpacity(0.1),
          background: Colors.transparent,
          onSurface: Colors.white,
          onBackground: Colors.white,
        ),
        cardColor: Colors.white.withOpacity(0.1),
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
