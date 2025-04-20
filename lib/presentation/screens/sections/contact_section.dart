import 'package:flutter/material.dart';
import '../../../config/responsive.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
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
          'Get In Touch',
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
        // Expanded(
        //   child: _ContactForm(),
        // ),
        const SizedBox(width: 40),
        Expanded(
          child: _ContactInfo(),
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
        _ContactInfo(),
        const SizedBox(height: 40),
        // _ContactForm(),
      ],
    );
  }
}
class _ContactInfo extends StatelessWidget {
  Future<void> _showExitConfirmationDialog(BuildContext context, String site, Function() onConfirm) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A1862),
        title: Text('Open $site?', style: const TextStyle(color: Colors.white)),
        content: Text(
          'You will be redirected to $site.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text('Continue', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _launchEmail(BuildContext context, String email) async {
    _showExitConfirmationDialog(context, 'Email Client', () async {
      final Uri emailUri = Uri.parse(
        'mailto:$email?subject=${Uri.encodeComponent("Hello from Portfolio Visitor")}'
      );
      try {
        if (!await url_launcher.launchUrl(emailUri)) {
          throw 'Could not launch email client';
        }
      } catch (e) {
        debugPrint('Error launching email: $e');
      }
    });
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.1),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        side: BorderSide(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        _buildContactItem(
          context: context,
          icon: Icons.email,
          title: 'Email',
          content: 'jayrajsinh9199@gmail.com',
        ),
        _buildContactItem(
          context: context,
          icon: Icons.location_on,
          title: 'Location',
          content: 'Bengaluru, India',
        ),
        const SizedBox(height: 30),
        Text(
          'Social Media',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSocialButton(
              icon: Icons.code,
              label: 'GitHub',
              onPressed: () {
                _showExitConfirmationDialog(context, 'GitHub', () async {
                  final Uri githubUrl = Uri.parse('https://github.com/Jayrajsinh91');
                  try {
                    if (!await url_launcher.launchUrl(
                      githubUrl,
                      mode: url_launcher.LaunchMode.inAppWebView,
                    )) {
                      throw 'Could not launch $githubUrl';
                    }
                  } catch (e) {
                    debugPrint('Error launching URL: $e');
                  }
                });
              },
            ),
            const SizedBox(width: 12),
            _buildSocialButton(
              icon: Icons.work,
              label: 'LinkedIn',
              onPressed: () {
                _showExitConfirmationDialog(context, 'LinkedIn', () async {
                  final Uri linkedinAppUrl = Uri.parse('linkedin://profile/jayrajsinh-thakor-41a66b190');
                  final Uri linkedinWebUrl = Uri.parse('https://www.linkedin.com/in/jayrajsinh-thakor-41a66b190/');
                  try {
                    if (await url_launcher.canLaunchUrl(linkedinAppUrl)) {
                      await url_launcher.launchUrl(linkedinAppUrl);
                    } else {
                      if (!await url_launcher.launchUrl(
                        linkedinWebUrl,
                        mode: url_launcher.LaunchMode.externalApplication,
                      )) {
                        throw 'Could not launch LinkedIn';
                      }
                    }
                  } catch (e) {
                    debugPrint('Error launching URL: $e');
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String content,
  }) {
    return InkWell(
      onTap: title == 'Email' ? () => _launchEmail(context, content) : null,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(
                    color: title == 'Email' 
                        ? Colors.blue[200]
                        : Colors.white,
                    decoration: title == 'Email' 
                        ? TextDecoration.underline
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 