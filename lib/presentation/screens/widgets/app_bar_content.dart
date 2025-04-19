import 'package:flutter/material.dart';
import '../../../config/responsive.dart';

class AppBarContent extends StatelessWidget {
  final void Function(GlobalKey) onSectionSelected;
  final GlobalKey homeKey;
  final GlobalKey aboutKey;

  const AppBarContent({
    super.key,
    required this.onSectionSelected,
    required this.homeKey,
    required this.aboutKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: Responsive.isMobile(context)
          ? []
          : <Widget>[
              TextButton(
                onPressed: () => onSectionSelected(homeKey),
                child: const Text('Home'),
              ),
              TextButton(
                onPressed: () => onSectionSelected(aboutKey),
                child: const Text('About'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Projects'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Contact'),
              ),
            ],
    );
  }
} 