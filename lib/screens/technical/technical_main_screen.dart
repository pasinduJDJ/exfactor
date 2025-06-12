import 'package:flutter/material.dart';
import '../../widgets/common/base_layout.dart';
import 'technical_home.dart';
import 'technical_task_screen.dart';
import 'technical_report_screen.dart';
import 'technical_profile_screen.dart';

class TechnicalMainScreen extends StatefulWidget {
  const TechnicalMainScreen({super.key});

  @override
  State<TechnicalMainScreen> createState() => _TechnicalMainScreenState();
}

class _TechnicalMainScreenState extends State<TechnicalMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const TechnicalHome(),
    const TechnicalTaskScreen(),
    const TechnicalReportScreen(),
    const TechnicalProfileScreen(),
  ];

  final List<BottomNavigationBarItem> _navigationItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.checklist),
      label: 'Tasks',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.assessment),
      label: 'Reports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Technical Dashboard',
      subtitle: 'Manage your tasks',
      profileImage: 'assets/images/avatar.png',
      onProfileTap: () {
        // TODO: Implement profile action
      },
      body: _screens[_currentIndex],
      currentIndex: _currentIndex,
      onIndexChanged: (index) => setState(() => _currentIndex = index),
      navigationItems: _navigationItems,
    );
  }
}
