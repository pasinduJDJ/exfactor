import 'package:exfactor/models/task_model.dart';
import 'package:exfactor/screens/admin/admin_manage_project_screen.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/common/custom_button.dart';
import 'package:exfactor/widgets/utils_widget.dart';
import 'package:flutter/material.dart';

class AdminProjectManage extends StatefulWidget {
  final int initialIndex;
  const AdminProjectManage({super.key , this.initialIndex = 0});

  @override
  State<AdminProjectManage> createState() => _AdminProjectManageState();
}

class _AdminProjectManageState extends State<AdminProjectManage> {
  List<Map<String, dynamic>> statusProjectOverview = [
    {'label': 'OVER DUE', 'count': 0, 'color': Colors.red},
    {'label': 'PENDING', 'count': 5, 'color': Colors.amber},
    {'label': 'ON PROGRESS', 'count': 15, 'color': Colors.green},
  ];
  List<Map<String, dynamic>> statusTaskOverView = [
    {'label': 'OVER DUE', 'count': 0, 'color': Colors.red},
    {'label': 'PENDING', 'count': 5, 'color': Colors.amber},
    {'label': 'ON PROGRESS', 'count': 15, 'color': Colors.green},
  ];

  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // use initial index passed in
  }

  @override
  Widget build(BuildContext context) {
    bool showProgress = true;
    final List<Task> tasks = [
      Task(title: 'Database Migration', status: 'progress'),
      Task(title: 'Task 2', status: 'progress'),
      Task(title: 'Overdue Report', status: 'overdue'),
      Task(title: 'Pending Review', status: 'pending'),
      Task(title: 'Completed Feature', status: 'complete'),
    ];
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          // 1st row Summerize Project Overview
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Project OverView ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(
                  height: 5,
                ),
                UserUtils.buildStatusSummaryCard(statusProjectOverview),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // 2nd Row Summerize Task Overview
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Task OverView ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(
                  height: 5,
                ),
                UserUtils.buildStatusSummaryCard(statusTaskOverView),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: "Manage Tasks",
            onPressed: () {},
            width: double.infinity,
            backgroundColor: kPrimaryColor,
            icon: const Icon(Icons.track_changes_outlined),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: "Manage Project",
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProjectManageScreen(initialIndex: index)));
            },
            width: double.infinity,
            backgroundColor: kPrimaryColor,
            icon: const Icon(Icons.track_changes_outlined),
          ),
          const SizedBox(
            height: 20,
          ),
          UserUtils.buildExpandableGroup(
            'On Progress Task',
            cardGreen,
            showProgress,
            () => setState(() => showProgress = !showProgress),
            tasks.where((t) => t.status == 'progress').toList(),
          ),
          UserUtils.buildExpandableGroup(
            'On Progress Task',
            cardGreen,
            showProgress,
            () => setState(() => showProgress = !showProgress),
            tasks.where((t) => t.status == 'progress').toList(),
          ),
        ],
      ),
    );
  }
}
