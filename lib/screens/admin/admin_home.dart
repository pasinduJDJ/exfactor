import 'package:exfactor/screens/admin/admin_add_task_screen.dart';
import 'package:exfactor/screens/admin/admin_single_profile.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/common/custom_button.dart';
import 'package:exfactor/widgets/utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:exfactor/screens/admin/admin_single_project_screen.dart';
import 'package:exfactor/screens/admin/admin_single_task_screen.dart';
import 'package:exfactor/services/superbase_service.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool showLiveProject = false;
  bool showPending = false;
  bool showProgress = true;
  bool showOverdue = false;
  bool showComplete = false;
  bool showOverDueTask = false;

  int liveProjectCount = 0;
  int overdueTaskCount = 0;
  int pendingTaskCount = 0;
  int onProgressTaskCount = 0;
  bool isLoadingSummary = true;

  List<Map<String, dynamic>> liveProjects = [];
  List<Map<String, dynamic>> onProgressTask = [];
  List<Map<String, dynamic>> teamMembers = [];
  List<Map<String, dynamic>> overDueTask = [];

  @override
  void initState() {
    super.initState();
    fetchSummaryCounts();
    fetchTeamMembers();
  }

  Future<void> fetchSummaryCounts() async {
    setState(() => isLoadingSummary = true);

    final projects = await SupabaseService.getAllProjects();
    final tasks = await SupabaseService.getAllTasks();
    final now = DateTime.now();

    liveProjectCount = projects.where((p) {
      final status = (p['status'] ?? '').toString().toLowerCase();
      return status == 'on progress' || status == 'progress';
    }).length;

    overdueTaskCount = tasks.where((t) {
      final status = (t['status'] ?? '').toString().toLowerCase();
      final endDateStr = t['end_date'] ?? t['project_end_date'] ?? '';
      DateTime? endDate;
      try {
        endDate = endDateStr != '' ? DateTime.parse(endDateStr) : null;
      } catch (_) {
        endDate = null;
      }
      // Only count as overdue if not complete and end date is before now
      return endDate != null && endDate.isBefore(now) && status != 'complete';
    }).length;

    pendingTaskCount = tasks.where((t) {
      final status = (t['status'] ?? '').toString().toLowerCase();
      return status == 'pending';
    }).length;

    onProgressTaskCount = tasks.where((t) {
      final status = (t['status'] ?? '').toString().toLowerCase();
      return status == 'on progress' || status == 'progress';
    }).length;

    onProgressTask = tasks.where((t) {
      final status = (t['status'] ?? '').toString().toLowerCase();
      return status == 'on progress' || status == 'progress';
    }).toList();

    overDueTask = tasks.where((t) {
      final status = (t['status'] ?? '').toString().toLowerCase();
      return status == 'overdue';
    }).toList();

    liveProjects = projects.where((p) {
      final status = (p['status'] ?? '').toString().toLowerCase();
      return status == 'on progress' || status == 'progress';
    }).toList();

    setState(() => isLoadingSummary = false);
  }

  Future<void> fetchTeamMembers() async {
    final users = await SupabaseService.getAllUsers();
    // Display all users, no role filtering
    teamMembers = users;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> statusItems = [
      {
        'label': 'Live Project',
        'count': liveProjectCount,
        'color': const Color(0xFF25253F)
      },
      {'label': 'OVER DUE', 'count': overdueTaskCount, 'color': Colors.red},
      {'label': 'PENDING', 'count': pendingTaskCount, 'color': Colors.amber},
      {
        'label': 'ON PROGRESS',
        'count': onProgressTaskCount,
        'color': Colors.green
      },
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(children: [
        const SizedBox(height: 30),
        isLoadingSummary
            ? const Center(child: CircularProgressIndicator())
            : UserUtils.buildStatusSummaryCard(statusItems),
        const SizedBox(height: 30),
        UserUtils.buildExpandableGroup(
          title: "Live Project",
          color: cardDarkGreen,
          expanded: showLiveProject,
          onToggle: () => setState(() => showLiveProject = !showLiveProject),
          groupList: liveProjects,
          onSeeMore: (project) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminSingleProjectScreen(
                    projectId: project['project_id']?.toString() ?? ''),
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        UserUtils.buildExpandableGroup(
          title: "OverDue Task",
          color: cardDarkRed,
          expanded: showOverDueTask,
          onToggle: () => setState(() => showOverDueTask = !showOverDueTask),
          groupList: overDueTask,
          onSeeMore: (task) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminSingleProjectScreen(
                    projectId: task['task_id']?.toString() ?? ''),
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        UserUtils.buildExpandableGroup(
          title: "On Progress Task",
          color: cardGreen,
          expanded: showOverdue,
          onToggle: () => setState(() => showOverdue = !showOverdue),
          groupList: onProgressTask,
          onSeeMore: (task) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminSingleTaskScreen(
                    taskId: task['task_id']?.toString() ?? ''),
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButton(
          text: "Add Task",
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => AdminAddTaskScreen()));
          },
          backgroundColor: kPrimaryColor,
          width: double.infinity,
          height: 48,
          icon: Icon(Icons.assignment_turned_in_outlined),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: const Text(
            'Current Exfactor Team',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: teamMembers.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No team members found.'),
                )
              : Column(
                  children: teamMembers
                      .map((user) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '${user['first_name'] ?? ''} ${user['last_name'] ?? ''}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AdminSingleProfileScreen(
                                        userEmail:
                                            user['email']?.toString() ?? '',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('See more ..'),
                              ),
                            ],
                          ))
                      .toList(),
                ),
        ),
      ]),
    );
  }
}
