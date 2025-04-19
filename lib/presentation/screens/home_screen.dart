import 'package:flutter/material.dart';
import '../../config/responsive.dart';
import '../../utils/tutorial_manager.dart';
import 'widgets/app_bar_content.dart';
import 'widgets/hero_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final menuKey = GlobalKey();
  final heroKey = GlobalKey();
  late TutorialManager tutorialManager;

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
        actions: const [AppBarContent()],
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
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('About'),
                    onTap: () {},
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
        child: Column(
          children: [
            Hero(
              tag: 'hero_section',
              key: heroKey,
              child: const HeroSection(),
            ),
          ],
        ),
      ),
    );
  }
} 