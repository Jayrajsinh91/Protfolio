import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialManager {
  static const String _tutorialShownKey = 'tutorial_shown';
  final List<GlobalKey> widgetKeys;
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  TutorialManager({
    required this.context,
    required this.widgetKeys,
  });

  void _showOverlay(BuildContext context, GlobalKey key) {
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black54,
            ),
          ),
          Positioned(
            left: position.dx - 10,
            top: position.dy - 10,
            child: Container(
              width: renderBox.size.width + 20,
              height: renderBox.size.height + 20,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Positioned(
            left: position.dx + renderBox.size.width + 20,
            top: position.dy,
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Start Exploring!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Click here to access the menu and discover more about my portfolio.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      _overlayEntry?.remove();
                      _overlayEntry = null;
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool(_tutorialShownKey, true);
                    },
                    child: const Text('Got it!'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Future<void> showTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    final tutorialShown = prefs.getBool(_tutorialShownKey) ?? false;

    if (!tutorialShown && widgetKeys.isNotEmpty) {
      // Delay to ensure widgets are rendered
      await Future.delayed(const Duration(milliseconds: 500));
      _showOverlay(context, widgetKeys[0]);
    }
  }
} 