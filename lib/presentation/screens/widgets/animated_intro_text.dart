import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedIntroText extends StatefulWidget {
  const AnimatedIntroText({super.key});

  @override
  State<AnimatedIntroText> createState() => _AnimatedIntroTextState();
}

class _AnimatedIntroTextState extends State<AnimatedIntroText> {
  static const _introText = 'Hi there!\n\n'
      'I\'m Jay, and I\'m delighted to see you here!\n\n'
      'Welcome to my portfolio app where I\'d love to share a bit about myself and my journey. '
      'Feel free to explore and discover more about my work and experiences.\n\n'
      'Let\'s connect and create something amazing together!';

  String _displayText = '';
  bool _showCursor = true;
  int _currentIndex = 0;
  bool _isAnimating = true;
  Timer? _typeTimer;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _blinkCursor();
  }

  void _startAnimation() {
    _typeTimer?.cancel();
    _typeTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_currentIndex < _introText.length && _isAnimating) {
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
    _cursorTimer?.cancel();
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _showCursor = !_showCursor;
        });
      }
    });
  }

  void _toggleAnimation() {
    setState(() {
      if (_currentIndex >= _introText.length) {
        _currentIndex = 0;
        _displayText = '';
        _isAnimating = true;
        _startAnimation();
      } else {
        _isAnimating = !_isAnimating;
        if (_isAnimating) {
          _startAnimation();
        }
      }
    });
  }

  void _skipAnimation() {
    setState(() {
      _currentIndex = _introText.length;
      _displayText = _introText;
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleAnimation,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer.withAlpha(26),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withAlpha(50),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: _displayText,
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.5,
                      letterSpacing: 0.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: _showCursor ? '|' : ' ',
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.5,
                      letterSpacing: 0.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (_currentIndex < _introText.length) ...[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    child: TextButton.icon(
                      onPressed: _toggleAnimation,
                      icon: Icon(
                      _isAnimating ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    label: Text(_isAnimating ? 'Pause' : 'Play', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold ),),
                  ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    child: TextButton.icon(
                      onPressed: _skipAnimation,
                      icon: const Icon(Icons.skip_next, color: Colors.white,),
                      label: const Text('Skip', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  child: TextButton.icon(
                    onPressed: _toggleAnimation,
                    icon: const Icon(Icons.replay, color: Colors.white,),
                    label: const Text('Replay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _typeTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }
} 