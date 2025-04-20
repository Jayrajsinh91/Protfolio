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
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
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
        'Swipe to see more photos',
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
  return Wrap(
    spacing: 12,
    runSpacing: 12,
    children: [
      _buildRoleChip(
        context: context,
        icon: Icons.code,
        label: 'Flutter Developer',
        color: Theme.of(context).colorScheme.primary,
      ),
      _buildRoleChip(
        context: context,
        icon: Icons.android,
        label: 'Android Developer',
        color: Theme.of(context).colorScheme.primary,
      ),
      _buildRoleChip(
        context: context,
        icon: Icons.design_services,
        label: 'UI/UX Enthusiast',
        color: Theme.of(context).colorScheme.secondary,
      ),
      _buildRoleChip(
        context: context,
        icon: Icons.mobile_friendly,
        label: 'Mobile App Developer',
        color: Theme.of(context).colorScheme.primary,
      ),
      _buildRoleChip(
        context: context,
        icon: Icons.web,
        label: 'Web Developer',
        color: Theme.of(context).colorScheme.secondary,
      ),
      _buildRoleChip(
        context: context,
        icon: Icons.cloud_done,
        label: 'AWS Developer',
        color: Theme.of(context).colorScheme.tertiary,
      ),
    ],
  );
}

Widget _buildRoleChip({
  required BuildContext context,
  required IconData icon,
  required String label,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.white.withOpacity(0.2),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
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
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A00E0).withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: false,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                ),
              ),
            ],
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          childrenPadding: const EdgeInsets.all(16),
          children: [
            SingleChildScrollView(
              child: _buildRichContent(context, content),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRichContent(BuildContext context, String content) {
    final sections = content.split('\n\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.map((section) {
        final lines = section.split('\n');
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lines.map((line) {
              if (line.startsWith('•')) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          line.substring(1).trim(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                height: 1.4,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (line.contains('—')) {
                final parts = line.split('—');
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        parts[0].trim(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        ' — ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        parts[1].trim(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    line,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: line.endsWith(':') ? FontWeight.bold : FontWeight.normal,
                          color: line.endsWith(':') ? Colors.white : null,
                        ),
                  ),
                );
              }
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
} 