import 'package:flutter/material.dart';
import '../../widgets/common/base_layout.dart';
import 'supervisor_home.dart';
import 'supervisor_task_screen.dart';
import 'supervisor_team_screen.dart';
import 'supervisor_profile_screen.dart';

class SupervisorMainScreen extends StatefulWidget {
  const SupervisorMainScreen({super.key});

  @override
  State<SupervisorMainScreen> createState() => _SupervisorMainScreenState();
}

class _SupervisorMainScreenState extends State<SupervisorMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const SupervisorHome(),
    const SupervisorTaskScreen(),
    const SupervisorTeamScreen(),
    const SupervisorProfileScreen(),
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
      icon: Icon(Icons.group),
      label: 'Team',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Supervisor Dashboard',
      subtitle: 'Manage your team',
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
