import 'package:flutter/material.dart';
import '../../../config/responsive.dart';

class AppBarContent extends StatelessWidget {
  const AppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: Responsive.isMobile(context)
          ? []
          : <Widget>[
              TextButton(
                onPressed: () {},
                child: const Text('Home'),
              ),
              TextButton(
                onPressed: () {},
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