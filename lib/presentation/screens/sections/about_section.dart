import 'package:flutter/material.dart';
import '../../../config/responsive.dart';
import '../widgets/image_carousel.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 40),
          Responsive.isMobile(context)
              ? const _MobileLayout()
              : const _DesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'About Me',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
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
  ];

  return Column(
    children: [
      ImageCarousel(
        imageUrls: images,
        height: 300,
      ),
      const SizedBox(height: 15),
      Text(
        'Swipe or click arrows to see more photos',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
    ],
  );
}

Widget _buildContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildRoleSection(context),
      const SizedBox(height: 20),
      _buildInfoCards(context),
    ],
  );
}

Widget _buildRoleSection(BuildContext context) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.code,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Flutter Developer',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 12),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.design_services,
              size: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 8),
            Text(
              'UI/UX Enthusiast',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildInfoCards(BuildContext context) {
  return Column(
    children: [
      _InfoCard(
        title: 'Experience',
        icon: Icons.work_outline,
        content: _buildExperienceContent(),
        color: Theme.of(context).colorScheme.primary,
      ),
      const SizedBox(height: 20),
      _InfoCard(
        title: 'Skills',
        icon: Icons.stars_outlined,
        content: _buildSkillsContent(),
        color: Theme.of(context).colorScheme.secondary,
      ),
      const SizedBox(height: 20),
      _InfoCard(
        title: 'Education',
        icon: Icons.school_outlined,
        content: _buildEducationContent(),
        color: Theme.of(context).colorScheme.tertiary,
      ),
    ],
  );
}

String _buildSkillsContent() {
  return '''
Technical Skills:
• Flutter & Dart
• Kotlin
• Java
• XML
• Web Technologies: HTML, CSS, JavaScript
• RESTful APIs & Firebase
• Git & Version Control
• Clean Architecture & State Management

Tools & Platforms:
• GitHub
• VS Code
• Android Studio
• Cursor
• AWS
• Slack
• Nifty

Soft Skills:
• Problem Solving
• Team Collaboration
• Agile Development
• UI/UX Design
• Responsive Design''';
}

String _buildEducationContent() {
  return '''
Bachelor of Engineering in Information & Technology
SVIT Vasad, Gujarat - 2022

Relevant Coursework:
• Mobile Application Development
• Software Engineering
• Database Management
• Web Technologies''';
}

String _buildExperienceContent() {
  return '''
Nosh Robotics, Bangalore — Software Development Engineer
December 2023 - Present
• Leading mobile app development (Flutter), managing maintenance and deployment on Play Store and App Store
• Building and optimizing device-side app features using Kotlin
• Developing Quality Control (QC) app for device validation in manufacturing
• Working through DVT (Design Validation Testing) phase

Nosh Robotics, Bangalore — SDE Intern
August 2023 - December 2023
• Implemented UI features during EVT (Engineering Validation Testing)
• Developed front-end features using Kotlin and Flutter
• Collaborated with cross-functional teams for UI/UX improvements
• Contributed to device application development''';
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;
  final Color color;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.content,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.1),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: false,
          title: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
              ),
            ],
          ),
          iconColor: color,
          collapsedIconColor: color,
          childrenPadding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          children: [
            Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
} 