import 'package:exfactor/screens/admin/admin_add_user.dart';
import 'package:flutter/material.dart';
import '../../widgets/common/base_layout.dart';
import 'admin_home.dart';
import 'admin_task_screen.dart';
import 'admin_notification_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const AdminHome(),
    const AdminTaskScreen(),
    const AdminNotificationScreen(),
    const AddUserScreen(),
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
      icon: Icon(Icons.notifications),
      label: 'Notifications',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.supervised_user_circle),
      label: 'Manage',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Chamuly D.',
      subtitle: 'CEO & Founder',
      profileImage: 'assets/images/man-avatar.jpg',
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
