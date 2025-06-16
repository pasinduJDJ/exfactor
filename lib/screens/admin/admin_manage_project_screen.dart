import 'package:exfactor/screens/admin/admin_manage_project&TaskScreen.dart';
import 'package:exfactor/widgets/common/base_layout.dart';
import 'package:exfactor/widgets/common/custom_app_bar_with_icon.dart';
import 'package:exfactor/widgets/utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/common/custom_button.dart';

class ProjectManageScreen extends StatefulWidget {
  const ProjectManageScreen({super.key});

  @override
  State<ProjectManageScreen> createState() => _ProjectManageScreenState();
}

class _ProjectManageScreenState extends State<ProjectManageScreen> {
  List<Map<String, dynamic>> statusProjectOverview = [
    {'label': 'OVER DUE', 'count': 0, 'color': Colors.red},
    {'label': 'PENDING', 'count': 5, 'color': Colors.amber},
    {'label': 'ON PROGRESS', 'count': 15, 'color': Colors.green},
  ];
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Chamuly D.',
      subtitle: 'CEO & Founder',
      profileImage: 'assets/images/man-avatar.jpg',

      customAppBar: const CustomAppBarWithIcon(
        title: 'Project Manager',
        icon: Icons.folder_shared,
      ),

      currentIndex: 1, // Highlight the "Tasks" tab (index from AdminMainScreen)

      onIndexChanged: (index) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminProjectManage()),
        );
      },

      navigationItems: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'Tasks'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle), label: 'Manage'),
      ],

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserUtils.buildStatusSummaryCard(statusProjectOverview),
            const SizedBox(height: 20),
            const Text("User Manage Section (example placeholder)"),
            // Add your other project sections here (e.g. cards, lists)
          ],
        ),
      ),
    );
  }

  // Mini reusable widgets
  Widget _buildStatusCard(String label, int count, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            Text(
              count.toString().padLeft(2, '0'),
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(String title) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(title, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
