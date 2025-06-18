import 'package:exfactor/models/task_model.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/utils_widget.dart';
import 'package:flutter/material.dart';

class TechnicalHome extends StatefulWidget {
  const TechnicalHome({super.key});

  @override
  State<TechnicalHome> createState() => _TechnicalHomeState();
}

class _TechnicalHomeState extends State<TechnicalHome> {
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
    List<Map<String, dynamic>> statusItems = [
      {'label': 'OVER DUE', 'count': 0, 'color': cardRed},
      {'label': 'PENDING', 'count': 5, 'color': cardYellow},
      {'label': 'ON PROGRESS', 'count': 15, 'color': cardGreen},
      {'label': 'Complete', 'count': 2, 'color': cardLightBlue},
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        SizedBox(height: 20),
        UserUtils.buildStatusSummaryCard(statusItems),
        const SizedBox(height: 30),
        UserUtils.buildExpandableGroup(
          'On Progress Task',
          cardGreen,
          showProgress,
          () => setState(() => showProgress = !showProgress),
          tasks.where((t) => t.status == 'progress').toList(),
          (task) => {},
        ),
        UserUtils.buildExpandableGroup(
          'Pending Task',
          cardYellow,
          showPending,
          () => setState(() => showPending = !showPending),
          tasks.where((t) => t.status == 'pending').toList(),
          (task) => {},
        ),
        UserUtils.buildExpandableGroup(
          'Over Due Task',
          cardRed,
          showOverdue,
          () => setState(() => showOverdue = !showOverdue),
          tasks.where((t) => t.status == 'overdue').toList(),
          (task) => {},
        ),
        UserUtils.buildExpandableGroup(
          'Completed Task',
          cardLightBlue,
          showComplete,
          () => setState(() => showComplete = !showComplete),
          tasks.where((t) => t.status == 'complete').toList(),
          (task) => {},
        ),
      ]),
    );
  }
}
