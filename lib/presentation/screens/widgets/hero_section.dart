import 'package:flutter/material.dart';
import '../../../config/responsive.dart';
import 'animated_intro_text.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: Responsive.isMobile(context) ? 500 : 700,
      ),
      color: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 40.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to My Portfolio',
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 32 : 48,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Flutter Developer | UI/UX Enthusiast',
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 18 : 24,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const AnimatedIntroText(),
            ],
          ),
        ),
      ),
    );
  }
} 