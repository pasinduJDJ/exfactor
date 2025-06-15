import 'package:exfactor/widgets/common/custom_app_bar_with_icon.dart';
import 'package:flutter/material.dart';
import '../../widgets/common/base_layout.dart';
import 'technical_home.dart';
import 'technical_task_screen.dart';
import 'technical_notification_screen.dart';
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
    const TaskTrackingBody(),
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
      icon: Icon(Icons.notifications),
      label: 'Notification',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  PreferredSizeWidget? _getCustomAppBar() {
    switch (_currentIndex) {
      case 1:
        return const CustomAppBarWithIcon(title: 'Epic Task Tracking', icon: Icons.list_alt);
      case 2:
        return const CustomAppBarWithIcon(title: 'Notifications', icon: Icons.notifications_active);
      case 3:
        return const CustomAppBarWithIcon(title: 'My Profile', icon: Icons.account_circle);
      default:
        return null; // use default avatar header for Home
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Technical Dashboard',
      subtitle: 'Manage your tasks',
      profileImage: 'assets/images/man-avatar.jpg',
      onProfileTap: () {},
      body: _screens[_currentIndex],
      currentIndex: _currentIndex,
      onIndexChanged: (index) => setState(() => _currentIndex = index),
      navigationItems: _navigationItems,
      customAppBar: _getCustomAppBar(),
    );
  }
}
