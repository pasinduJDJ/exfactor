import 'package:exfactor/models/task_model.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/common/custom_button.dart';
import 'package:exfactor/widgets/utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:exfactor/screens/admin/admin_single_project_screen.dart';
import 'package:exfactor/screens/admin/admin_single_task_screen.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool showPending = false;
  bool showProgress = true;
  bool showOverdue = false;
  bool showComplete = false;

  final List<Task> tasks = [
    Task(title: 'Database Migration', status: 'progress'),
    Task(title: 'Task 2', status: 'progress'),
    Task(title: 'Overdue Report', status: 'overdue'),
    Task(title: 'Pending Review', status: 'pending'),
    Task(title: 'Completed Feature', status: 'complete'),
  ];
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> statusItems = [
      {'label': 'Live Project', 'count': 2, 'color': const Color(0xFF25253F)},
      {'label': 'OVER DUE', 'count': 0, 'color': Colors.red},
      {'label': 'PENDING', 'count': 5, 'color': Colors.amber},
      {'label': 'ON PROGRESS', 'count': 15, 'color': Colors.green},
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        const SizedBox(height: 30),
        UserUtils.buildStatusSummaryCard(statusItems),
        const SizedBox(height: 30),
        CustomButton(
          text: "Manage Projects",
          onPressed: () {},
          backgroundColor: kPrimaryColor,
          width: double.infinity,
          height: 48,
          icon: Icon(Icons.assignment_turned_in_outlined),
        ),
        const SizedBox(height: 30),
        UserUtils.buildGroup(
          'On Progress',
          cardLightBlue,
          tasks.where((t) => t.status == 'overdue').toList(),
          (task) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminSingleProjectScreen()),
            );
          },
        ),
        const SizedBox(height: 30),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Exfactor Team Members",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
          ],
        ),
        const SizedBox(height: 10),
        UserUtils.buildGroup(
          'On Progress Task',
          cardOrenge,
          tasks.where((t) => t.status == 'progress').toList(),
          (task) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminSingleTaskScreen()),
            );
          },
        ),
      ]),
    );
  }
}
