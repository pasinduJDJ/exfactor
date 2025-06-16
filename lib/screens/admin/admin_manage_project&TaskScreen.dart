import 'package:exfactor/models/task_model.dart';
import 'package:exfactor/screens/admin/admin_add_task_screen.dart';
import 'package:exfactor/screens/admin/admin_add_project_screen.dart';
import 'package:exfactor/screens/admin/admin_single_project_screen.dart';
import 'package:exfactor/screens/admin/admin_single_task_screen.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/common/custom_button.dart';
import 'package:exfactor/widgets/utils_widget.dart';
import 'package:flutter/material.dart';

class AdminProjectManage extends StatefulWidget {
  const AdminProjectManage({super.key});

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
  bool showPending = false;
  bool showProgress = true;
  bool showOverdue = false;
  bool showComplete = false;

  // Example fetched tasks
  final List<Task> tasks = [
    Task(title: 'Database Migration', status: 'progress'),
    Task(title: 'Task 2', status: 'progress'),
    Task(title: 'Overdue Report', status: 'overdue'),
    Task(title: 'Pending Review', status: 'pending'),
    Task(title: 'Completed Feature', status: 'complete'),
  ];

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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
          const Text("Manage Projects",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            text: "Add New Project",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminAddProjectScreen()),
              );
            },
            width: double.infinity,
            backgroundColor: kPrimaryColor,
            icon: const Icon(Icons.task_alt),
          ),
          const SizedBox(
            height: 10,
          ),
          UserUtils.buildExpandableGroup(
            'On Progress Task',
            cardDarkGreen,
            showProgress,
            () => setState(() => showProgress = !showProgress),
            tasks.where((t) => t.status == 'progress').toList(),
            (task) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminSingleProjectScreen()),
              );
            },
          ),
          UserUtils.buildExpandableGroup(
            'Pending Task',
            cardDarkYellow,
            showPending,
            () => setState(() => showPending = !showPending),
            tasks.where((t) => t.status == 'pending').toList(),
            (task) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminSingleTaskScreen()),
              );
            },
          ),
          UserUtils.buildExpandableGroup(
            'Over Due Task',
            cardDarkRed,
            showOverdue,
            () => setState(() => showOverdue = !showOverdue),
            tasks.where((t) => t.status == 'overdue').toList(),
            (task) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminSingleTaskScreen()),
              );
            },
          ),
          //mange Tasks
          const SizedBox(
            height: 20,
          ),
          const Text("Manage Tasks",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: "Add New Tasks",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminAddTaskScreen()),
              );
            },
            width: double.infinity,
            backgroundColor: kPrimaryColor,
            icon: const Icon(Icons.task),
          ),
          const SizedBox(
            height: 10,
          ),
          UserUtils.buildExpandableGroup(
            'On Progress Task',
            cardGreen,
            showProgress,
            () => setState(() => showProgress = !showProgress),
            tasks.where((t) => t.status == 'progress').toList(),
            (task) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminSingleProjectScreen()),
              );
            },
          ),
          UserUtils.buildExpandableGroup(
            'Pending Task',
            cardYellow,
            showPending,
            () => setState(() => showPending = !showPending),
            tasks.where((t) => t.status == 'pending').toList(),
            (task) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminSingleTaskScreen()),
              );
            },
          ),
          UserUtils.buildExpandableGroup(
            'Over Due Task',
            cardRed,
            showOverdue,
            () => setState(() => showOverdue = !showOverdue),
            tasks.where((t) => t.status == 'overdue').toList(),
            (task) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminSingleTaskScreen()),
              );
            },
          ),
          UserUtils.buildExpandableGroup(
            'Completed Task',
            cardLightBlue,
            showComplete,
            () => setState(() => showComplete = !showComplete),
            tasks.where((t) => t.status == 'complete').toList(),
            (task) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminSingleTaskScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
