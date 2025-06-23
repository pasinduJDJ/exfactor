import 'package:exfactor/models/user_model.dart';
import 'package:exfactor/screens/technical/technical_single_task.dart';
import 'package:exfactor/services/superbase_service.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/utils_widget.dart';
import 'package:flutter/material.dart';

class SupervisorHome extends StatefulWidget {
  final UserModel user;
  const SupervisorHome({Key? key, required this.user}) : super(key: key);

  @override
  State<SupervisorHome> createState() => _SupervisorHomeState();
}

class _SupervisorHomeState extends State<SupervisorHome> {
  bool showPending = false;
  bool showProgress = true;
  bool showOverdue = false;
  bool showComplete = false;

  int overdueCount = 0;
  int pendingCount = 0;
  int progressCount = 0;
  int completeCount = 0;
  bool isLoading = true;

  List<Map<String, dynamic>> inProgressTasks = [];
  List<Map<String, dynamic>> inProgress = [];
  List<Map<String, dynamic>> overdueTasks = [];
  List<Map<String, dynamic>> isoverdue = [];
  List<Map<String, dynamic>> pendingTasks = [];
  List<Map<String, dynamic>> ispending = [];
  List<Map<String, dynamic>> completeTasks = [];
  List<Map<String, dynamic>> iscomplete = [];
  bool showInProgress = true;

  @override
  void initState() {
    super.initState();
    fetchAndProcessTasks();
  }

  Future<void> fetchAndProcessTasks() async {
    try {
      final allTasks = await SupabaseService.getAllTasks();
      final userId = widget.user.memberId.toString();
      final now = DateTime.now();
      int overdue = 0, pending = 0, progress = 0, complete = 0;
      for (final task in allTasks) {
        final members = (task['members'] ?? '').toString().split(',');
        if (!members.contains(userId)) continue;
        final status = (task['status'] ?? '').toString().toLowerCase();
        final endDateStr = (task['end_date'] ?? '').toString();
        DateTime? endDate;
        try {
          endDate = DateTime.parse(endDateStr);
        } catch (_) {}
        if (status == 'complete') {
          complete++;
          iscomplete.add(task);
        } else if (status == 'pending') {
          pending++;
          ispending.add(task);
        } else if (status.contains('progress')) {
          progress++;
          inProgress.add(task);
        } else if (endDate != null && endDate.isBefore(now)) {
          overdue++;
          isoverdue.add(task);
        }
      }
      setState(() {
        overdueCount = overdue;
        pendingCount = pending;
        progressCount = progress;
        completeCount = complete;
        inProgressTasks = inProgress;
        completeTasks = iscomplete;
        overdueTasks = isoverdue;
        pendingTasks = ispending;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onSeeMoreTask(Map<String, dynamic> task) {
    final taskId = task['task_id']?.toString();
    if (taskId != null) {
      Navigator.of(context).pushNamed(
        '/technical_single_task',
        arguments: {'task_id': taskId},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> statusItems = [
      {'label': 'OVER DUE', 'count': overdueCount, 'color': cardRed},
      {'label': 'PENDING', 'count': pendingCount, 'color': cardYellow},
      {'label': 'IN PROGRESS', 'count': progressCount, 'color': cardGreen},
      {'label': 'COMPLETE', 'count': completeCount, 'color': cardLightBlue},
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        SizedBox(height: 20),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : UserUtils.buildStatusSummaryCard(statusItems),
        const SizedBox(height: 30),
        UserUtils.buildExpandableGroup(
          title: 'In Progress Task',
          color: cardGreen,
          expanded: showInProgress,
          onToggle: () {
            setState(() {
              showInProgress = !showInProgress;
            });
          },
          groupList: inProgressTasks,
          onSeeMore: (task) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TechnicalSingleTask(
                    taskId: task['task_id']?.toString() ?? ''),
              ),
            );
          },
        ),
        SizedBox(height: 20),
        UserUtils.buildExpandableGroup(
          title: 'Pending Task',
          color: cardDarkYellow,
          expanded: showPending,
          onToggle: () {
            setState(() {
              showPending = !showPending;
            });
          },
          groupList: pendingTasks,
          onSeeMore: (task) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TechnicalSingleTask(
                    taskId: task['task_id']?.toString() ?? ''),
              ),
            );
          },
        ),
        SizedBox(height: 20),
        UserUtils.buildExpandableGroup(
          title: 'Over Due Task',
          color: cardDarkRed,
          expanded: showOverdue,
          onToggle: () {
            setState(() {
              showOverdue = !showOverdue;
            });
          },
          groupList: overdueTasks,
          onSeeMore: (task) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TechnicalSingleTask(
                    taskId: task['task_id']?.toString() ?? ''),
              ),
            );
          },
        ),
        SizedBox(height: 20),
        UserUtils.buildExpandableGroup(
          title: 'Complete Task',
          color: cardLightBlue,
          expanded: showComplete,
          onToggle: () {
            setState(() {
              showComplete = !showComplete;
            });
          },
          groupList: completeTasks,
          onSeeMore: (task) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TechnicalSingleTask(
                    taskId: task['task_id']?.toString() ?? ''),
              ),
            );
          },
        ),
      ]),
    );
  }
}
