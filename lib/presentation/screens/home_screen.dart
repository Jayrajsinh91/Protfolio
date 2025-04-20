import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import '../../config/responsive.dart';
import '../../utils/tutorial_manager.dart';
import 'widgets/app_bar_content.dart';
import 'widgets/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final menuKey = GlobalKey();
  final heroKey = GlobalKey();
  final aboutKey = GlobalKey();
  final contactKey = GlobalKey();
  late TutorialManager tutorialManager;
  final ScrollController _scrollController = ScrollController();

  void _scrollToSection(GlobalKey key) {
      Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 300), () {
      final keyContext = key.currentContext;
      if (keyContext != null) {
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tutorialManager = TutorialManager(
        context: context,
        widgetKeys: [menuKey, heroKey],
      );
      tutorialManager.showTutorial();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _showExitConfirmationDialog(String site, Function() onConfirm) async {
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

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF2A1862),   
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: const Color(0xFF4A00E0).withOpacity(0.3), 
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white.withOpacity(0.1),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/me1.jpeg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            accountName: const Text(
              'Jayrajsinh Thakor',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              'Software Developer',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFF2A1862),  
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    icon: Icons.home_outlined,
                    title: 'Home',
                    onTap: () => _scrollToSection(heroKey),
                  ),
                  _buildDrawerItem(
                    icon: Icons.person_outline,
                    title: 'About',
                    onTap: () => _scrollToSection(aboutKey),
                  ),
                  _buildDrawerItem(
                    icon: Icons.work_outline,
                    title: 'Projects',
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: Icons.mail_outline,
                    title: 'Contact',
                    onTap: () => _scrollToSection(contactKey),
                  ),
                  const Divider(),
                  _buildDrawerItem(
                    icon: Icons.code,
                    title: 'GitHub',
                    onTap: () async {
                      _showExitConfirmationDialog('GitHub', () async {
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
                  _buildDrawerItem(
                    icon: Icons.work,
                    title: 'LinkedIn',
                    onTap: () async {
                      _showExitConfirmationDialog('LinkedIn', () async {
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: SizedBox(
        width: 32,
        child: Icon(
          icon, 
          color: Colors.white,
          size: 22,
        ),
      ),
      title: Text(
        title, 
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          height: 1.2,
        ),
      ),
      onTap: onTap,
      dense: true,
      visualDensity: VisualDensity.compact, 
      horizontalTitleGap: 8,  
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,  
        vertical: 5,     
      ),
      hoverColor: Colors.white.withOpacity(0.1),
      minLeadingWidth: 0, 
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: Responsive.isMobile(context) || isLandscape
            ? Builder(
                builder: (context) => IconButton(
                  key: menuKey,
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              )
            : null,
        title: const Text(
          'My Portfolio',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          
            AppBarContent(
              onSectionSelected: _scrollToSection,
              homeKey: heroKey,
              aboutKey: aboutKey,
            ),
        ],
      ),
      drawer: (Responsive.isMobile(context) || isLandscape) ? _buildDrawer() : null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF4A00E0).withAlpha(204), 
              const Color(0xFF8E2DE2).withAlpha(128), 
              Colors.white.withAlpha(26),             
            ],
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Hero(
                tag: 'hero_section',
                key: heroKey,
                child: const HeroSection(),
              ),
              const SizedBox(height: 20),
              Container(key: aboutKey, child: const AboutSection()),
              const SizedBox(height: 30),
              Container(key: contactKey, child: const ContactSection()),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
