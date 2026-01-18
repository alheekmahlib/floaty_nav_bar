import 'package:example/photo_hero.dart';
import 'package:floaty_nav_bar/floaty_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        selectedTab: selectedTab,
        glassEffect: const FloatyGlassEffect.light(),
        tabs: [
          FloatyTab(
            isSelected: selectedTab == 0,
            selectedDisplayMode: FloatyTabDisplayMode.titleOnly,
            unselectedDisplayMode: FloatyTabDisplayMode.iconOnly,
            selectedColor: Colors.white.withValues(alpha: 0.3),
            unselectedColor: Colors.transparent,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            onTap: () => changeTab(0),
            title: 'Home',
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome01,
              color: selectedTab == 0 ? Colors.black87 : Colors.black87,
            ),
            floatyActionButton: FloatyActionButton(
              icon: const Icon(Icons.add),
              onTap: () => showSnackBar('Add button tapped'),
            ),
          ),
          FloatyTab(
            isSelected: selectedTab == 1,
            selectedDisplayMode: FloatyTabDisplayMode.titleOnly,
            unselectedDisplayMode: FloatyTabDisplayMode.iconOnly,
            selectedColor: Colors.white.withValues(alpha: 0.3),
            unselectedColor: Colors.transparent,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            onTap: () => changeTab(1),
            title: 'Search',
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
              color: selectedTab == 1 ? Colors.white : Colors.black87,
            ),
          ),
          FloatyTab(
            isSelected: selectedTab == 2,
            selectedDisplayMode: FloatyTabDisplayMode.titleOnly,
            unselectedDisplayMode: FloatyTabDisplayMode.iconOnly,
            selectedColor: Colors.white.withValues(alpha: 0.3),
            unselectedColor: Colors.transparent,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            onTap: () => changeTab(2),
            title: 'Watt',
            icon: SvgPicture.asset(
              'assets/wat.svg',
              width: 24,
              height: 24,
              colorFilter: selectedTab == 2
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
            ),
          ),
          FloatyTab(
            isSelected: selectedTab == 3,
            selectedDisplayMode: FloatyTabDisplayMode.titleOnly,
            unselectedDisplayMode: FloatyTabDisplayMode.iconOnly,
            selectedColor: Colors.green.withValues(alpha: 0.8),
            unselectedColor: Colors.transparent,
            titleStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            onTap: () => changeTab(3),
            title: 'Profile',
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedProfile02,
              color: selectedTab == 3 ? Colors.white : Colors.black87,
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
