import 'package:example/photo_hero.dart';
import 'package:floaty_nav_bar/floaty_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

const imagePath = 'https://i.pravatar.cc/250?u=mail@ashallendesign.co.uk';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floaty Nav Bar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  late List<FloatyTab> floatyTabs;
  int selectedTab = 0;

  List<Widget> get tabs {
    return [
      const Center(child: Text('Home')),
      const Center(child: Text('Search')),
      const Center(child: Text('Settings')),
      const Center(child: Text('Profile')),
    ];
  }

  void changeTab(int index) {
    _pageController.jumpToPage(index);
    setState(() => selectedTab = index);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: const SquircleShape().shapeBorder,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Widget _buildMenuItem(IconData icon, Color color, String label) {
    return GestureDetector(
      onTap: () => showSnackBar('$label tapped'),
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.teal,
      appBar: AppBar(
          backgroundColor: Colors.teal, title: const Text('Floaty Nav Bar')),
      body: PageView(
        controller: _pageController,
        children: tabs,
        onPageChanged: (index) => setState(() => selectedTab = index),
      ),
      bottomNavigationBar: FloatyNavBar(
        height: 45,
        selectedTab: selectedTab,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: Colors.orangeAccent,
        glassEffect: const FloatyGlassEffect.light(),
        menu: FloatyMenu(
          selectedColor: Colors.white.withValues(alpha: 0.3),
          unselectedColor: Colors.transparent,
          borderRadius: BorderRadius.circular(32),
          icon: const HugeIcon(
            size: 18,
            icon: HugeIcons.strokeRoundedSettings01,
            color: Colors.white,
          ),
          title: 'Settings',
          titleStyle: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
          // height: 250,
          selectedDisplayMode: FloatyTabDisplayMode.iconAndTitle,
          unselectedDisplayMode: FloatyTabDisplayMode.iconOnly,
          labelPosition: FloatyLabelPosition.bottom,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _buildMenuItem(Icons.description_outlined, Colors.blue, 'Docs'),
                _buildMenuItem(Icons.videocam_outlined, Colors.purple, 'Clips'),
                _buildMenuItem(
                    Icons.dashboard_outlined, Colors.orange, 'Dashboard'),
                _buildMenuItem(Icons.note_alt_outlined, Colors.teal, 'Notepad'),
                _buildMenuItem(Icons.event_outlined, Colors.green, 'Planner'),
                _buildMenuItem(Icons.chat_bubble_outline, Colors.pink, 'Chats'),
              ],
            ),
          ),
        ),
        tabs: [
          FloatyTab(
            isSelected: selectedTab == 0,
            margin: EdgeInsets.zero,
            selectedDisplayMode: FloatyTabDisplayMode.iconAndTitle,
            unselectedDisplayMode: FloatyTabDisplayMode.iconOnly,
            selectedColor: Colors.white.withValues(alpha: 0.3),
            labelPosition: FloatyLabelPosition.bottom,
            unselectedColor: Colors.transparent,
            titleStyle: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            onTap: () => changeTab(0),
            title: 'Home',
            icon: const HugeIcon(
              size: 18,
              icon: HugeIcons.strokeRoundedHome01,
              color: Colors.white,
            ),
            floatyActionButton: FloatyActionButton(
              icon: const Icon(Icons.add),
              onTap: () => showSnackBar('Add button tapped'),
            ),
          ),
          FloatyTab(
            iconSize: 16,
            isSelected: selectedTab == 1,
            margin: EdgeInsets.zero,
            selectedDisplayMode: FloatyTabDisplayMode.iconAndTitle,
            unselectedDisplayMode: FloatyTabDisplayMode.iconOnly,
            selectedColor: Colors.white.withValues(alpha: 0.3),
            unselectedColor: Colors.transparent,
            labelPosition: FloatyLabelPosition.bottom,
            titleStyle: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            onTap: () => changeTab(1),
            title: 'Search',
            icon: const HugeIcon(
              size: 20,
              icon: HugeIcons.strokeRoundedSearch01,
              color: Colors.white,
            ),
          ),
          FloatyTab(
            iconSize: 16,
            isSelected: selectedTab == 2,
            margin: EdgeInsets.zero,
            selectedDisplayMode: FloatyTabDisplayMode.iconAndTitle,
            unselectedDisplayMode: FloatyTabDisplayMode.iconOnly,
            selectedColor: Colors.green.withValues(alpha: 0.8),
            unselectedColor: Colors.transparent,
            labelPosition: FloatyLabelPosition.bottom,
            titleStyle: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            onTap: () => changeTab(2),
            title: 'Profile',
            icon: const HugeIcon(
              size: 20,
              icon: HugeIcons.strokeRoundedProfile02,
              color: Colors.white,
            ),
            floatyActionButton: FloatyActionButton(
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              heroTag: imagePath,
              icon: ClipOval(
                child: Image.asset(
                  'assets/profile.jpg',
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PhotoHero(photo: imagePath),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
