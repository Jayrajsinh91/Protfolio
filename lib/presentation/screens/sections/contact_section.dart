import 'package:flutter/material.dart';
import '../../../config/responsive.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
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
          'Get In Touch',
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

class _ContactForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  _ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send Message',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _nameController,
            label: 'Name',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _messageController,
            label: 'Message',
            icon: Icons.message_outlined,
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: Implement send message functionality
                }
              },
              icon: const Icon(Icons.send),
              label: const Text('Send Message'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (label == 'Email' && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}

class _ContactInfo extends StatelessWidget {
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
              onPressed: () async {
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
              },
            ),
            const SizedBox(width: 12),
            _buildSocialButton(
              icon: Icons.work,
              label: 'LinkedIn',
              onPressed: () async {
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
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
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
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
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
    );
  }
} 