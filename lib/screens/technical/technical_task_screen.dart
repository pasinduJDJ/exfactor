import 'package:exfactor/models/task_model.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/technical_user_utils.dart';
import 'package:flutter/material.dart';

class TaskTrackingBody extends StatefulWidget {
  const TaskTrackingBody({super.key});

  @override
  State<TaskTrackingBody> createState() => _TaskTrackingBodyState();
}

class _TaskTrackingBodyState extends State<TaskTrackingBody> {
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
    final taskCounts = {
      'pending': tasks.where((t) => t.status == 'pending').length,
      'progress': tasks.where((t) => t.status == 'progress').length,
      'complete': tasks.where((t) => t.status == 'complete').length,
    };
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 30),
        // Summary Cards
        Card(
          elevation: 6,
          shadowColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TechnicalUserUtils.buildStatusCard(
                    'PENDING', cardRed, taskCounts['pending'] ?? 0),
                TechnicalUserUtils.buildStatusCard(
                    'ON PROGRESS', cardGreen, taskCounts['progress'] ?? 0),
                TechnicalUserUtils.buildStatusCard(
                    'COMPLETE', cardLightBlue, taskCounts['complete'] ?? 0),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        TechnicalUserUtils.buildExpandableGroup(
          'On Progress Task',
          cardGreen,
          showProgress,
          () => setState(() => showProgress = !showProgress),
          tasks.where((t) => t.status == 'progress').toList(),
        ),
        TechnicalUserUtils.buildExpandableGroup(
          'Pending Task',
          cardYellow,
          showPending,
          () => setState(() => showPending = !showPending),
          tasks.where((t) => t.status == 'pending').toList(),
        ),
        TechnicalUserUtils.buildExpandableGroup(
          'Over Due Task',
          cardRed,
          showOverdue,
          () => setState(() => showOverdue = !showOverdue),
          tasks.where((t) => t.status == 'overdue').toList(),
        ),
        TechnicalUserUtils.buildExpandableGroup(
          'Completed Task',
          cardLightBlue,
          showComplete,
          () => setState(() => showComplete = !showComplete),
          tasks.where((t) => t.status == 'complete').toList(),
        ),
      ]),
    );
  }
}
