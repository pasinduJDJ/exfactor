import 'package:exfactor/widgets/common/custom_app_bar_with_icon.dart';
import 'package:flutter/material.dart';
import '../../widgets/common/base_layout.dart';
import 'technical_home.dart';
import 'technical_task_screen.dart';
import 'technical_notification_screen.dart';
import 'technical_profile_screen.dart';
import 'package:exfactor/models/user_model.dart';

class TechnicalMainScreen extends StatefulWidget {
  final UserModel user;
  const TechnicalMainScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<TechnicalMainScreen> createState() => _TechnicalMainScreenState();
}

class _TechnicalMainScreenState extends State<TechnicalMainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      TechnicalHome(user: widget.user),
      TaskTrackingBody(user: widget.user),
      const TechnicalReportScreen(),
      TechnicalProfileScreen(user: widget.user),
    ];
  }

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
        return const CustomAppBarWithIcon(
            title: 'Epic Task Tracking', icon: Icons.list_alt);
      case 2:
        return const CustomAppBarWithIcon(
            title: 'Notifications', icon: Icons.notifications_active);
      case 3:
        return const CustomAppBarWithIcon(
            title: 'My Profile', icon: Icons.account_circle);
      default:
        return null; // use default avatar header for Home
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: widget.user.firstName ?? '',
      subtitle: widget.user.position ?? '',
      profileImage: 'assets/images/it-avatar.webp',
      onProfileTap: () {},
      body: _screens[_currentIndex],
      currentIndex: _currentIndex,
      onIndexChanged: (index) => setState(() => _currentIndex = index),
      navigationItems: _navigationItems,
      customAppBar: _getCustomAppBar(),
    );
  }
}
