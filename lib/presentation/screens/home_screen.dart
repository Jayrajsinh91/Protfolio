import 'package:flutter/material.dart';
import '../../config/responsive.dart';
import '../../utils/tutorial_manager.dart';
import 'widgets/app_bar_content.dart';
import 'widgets/hero_section.dart';
import 'sections/about_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final menuKey = GlobalKey();
  final heroKey = GlobalKey();
  final aboutKey = GlobalKey();
  late TutorialManager tutorialManager;
  final ScrollController _scrollController = ScrollController();

  void _scrollToSection(GlobalKey key) {
    final keyContext = key.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      if (Responsive.isMobile(context)) {
        Navigator.pop(context);
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Responsive.isMobile(context)
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
        title: const Text('My Portfolio'),
        actions: [
          AppBarContent(
            onSectionSelected: _scrollToSection,
            homeKey: heroKey,
            aboutKey: aboutKey,
          ),
        ],
      ),
      drawer: Responsive.isMobile(context)
          ? Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(
                    child: Text(
                      'Portfolio Menu',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  ListTile(
                    title: const Text('Home'),
                    onTap: () => _scrollToSection(heroKey),
                  ),
                  ListTile(
                    title: const Text('About'),
                    onTap: () => _scrollToSection(aboutKey),
                  ),
                  ListTile(
                    title: const Text('Projects'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Contact'),
                    onTap: () {},
                  ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Hero(
              tag: 'hero_section',
              key: heroKey,
              child: const HeroSection(),
            ),
            Container(
              key: aboutKey,
              child: const AboutSection(),
            ),
          ],
        ),
      ),
    );
  }
} 