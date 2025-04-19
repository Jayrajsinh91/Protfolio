import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedIntroText extends StatefulWidget {
  const AnimatedIntroText({super.key});

  @override
  State<AnimatedIntroText> createState() => _AnimatedIntroTextState();
}

class _AnimatedIntroTextState extends State<AnimatedIntroText> {
  static const _introText = "Hi there! 👋\n\n"
      "I'm Jay, and I'm delighted to see you here! ✨\n\n"
      "Welcome to my portfolio app where I'd love to share a bit about myself and my journey. "
      "Feel free to explore and discover more about my work and experiences. 🚀\n\n"
      "Let's connect and create something amazing together! 💫";

  String _displayText = '';
  bool _showCursor = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _blinkCursor();
  }

  void _startAnimation() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_currentIndex < _introText.length) {
        setState(() {
          _displayText = _introText.substring(0, _currentIndex + 1);
          _currentIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _blinkCursor() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _showCursor = !_showCursor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$_displayText${_showCursor ? '|' : ''}',
        style: const TextStyle(
          fontSize: 20,
          height: 1.5,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
} 