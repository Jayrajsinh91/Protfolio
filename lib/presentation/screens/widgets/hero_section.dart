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
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 40.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '👋 Hello World!',
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 16 : 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Welcome to My Portfolio',
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 32 : 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Software Developer',
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 18 : 24,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
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