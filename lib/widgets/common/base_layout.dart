import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/theme.dart';

class BaseLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? profileImage;
  final VoidCallback? onProfileTap;
  final Widget body;
  final int currentIndex;
  final Function(int) onIndexChanged;
  final List<BottomNavigationBarItem> navigationItems;
  final PreferredSizeWidget? customAppBar;

  const BaseLayout({
    Key? key,
    required this.title,
    required this.subtitle,
    this.profileImage,
    this.onProfileTap,
    required this.body,
    required this.currentIndex,
    required this.onIndexChanged,
    required this.navigationItems,
    this.customAppBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar ??
          PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: Container(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.themeColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (profileImage != null)
                      GestureDetector(
                        onTap: onProfileTap,
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage(profileImage!),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onIndexChanged,
        selectedItemColor: const Color.fromARGB(255, 112, 7, 7),
        unselectedItemColor: Colors.white60,
        backgroundColor: Color.fromARGB(0, 5, 177, 22),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: navigationItems,
      ),
    );
  }
}
