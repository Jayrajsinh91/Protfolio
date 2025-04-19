import 'package:flutter/material.dart';
import '../../../config/responsive.dart';
import '../widgets/image_carousel.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Text(
            'About Me',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 40),
          Responsive.isMobile(context)
              ? const _MobileLayout()
              : const _DesktopLayout(),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildContent(context),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: _buildImage(),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImage(),
        const SizedBox(height: 30),
        _buildContent(context),
      ],
    );
  }
}

Widget _buildImage() {
  final List<String> images = [
    "assets/images/me1.jpeg",
    "assets/images/me2.jpeg",
    "assets/images/me3.jpeg",
    "assets/images/me4.jpeg",
  ];

  return ImageCarousel(
    imageUrls: images,
    height: 300,
  );
}

Widget _buildContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Flutter Developer & UI/UX Enthusiast',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
      const SizedBox(height: 20),
      const _InfoCard(
        title: 'Background',
        content:
            'With 2+ years of experience in mobile app development, I specialize in creating beautiful and functional applications using Flutter. My journey in software development started during my college years, and I\'ve been passionate about creating user-centric solutions ever since.',
      ),
      const SizedBox(height: 20),
      const _InfoCard(
        title: 'Skills',
        content: 
            '• Flutter & Dart\n'
            '• UI/UX Design\n'
            '• Firebase\n'
            '• RESTful APIs\n'
            '• Git & Version Control\n'
            '• Responsive Design\n'
            '• State Management\n'
            '• Clean Architecture',
      ),
      const SizedBox(height: 20),
      const _InfoCard(
        title: 'Education',
        content: 
            'Bachelor of Engineering in Information & Technology\n'
            'SVIT Vasad, Gujarat - 2022\n\n'
            'Relevant Coursework:\n'
            '• Mobile Application Development\n'
            '• Software Engineering\n'
            '• Database Management\n'
            '• Web Technologies',
      ),
    ],
  );
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const _InfoCard({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withAlpha(26),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
} 