import 'package:exfactor/screens/admin/admin_add_task_screen.dart';
import 'package:exfactor/screens/admin/admin_add_project_screen.dart';
import 'package:exfactor/screens/admin/admin_single_project_screen.dart';
import 'package:exfactor/screens/admin/admin_single_task_screen.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/common/custom_button.dart';
import 'package:exfactor/widgets/utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:exfactor/services/superbase_service.dart';

class AdminProjectManage extends StatefulWidget {
  const AdminProjectManage({super.key});

  @override
  State<AdminProjectManage> createState() => _AdminProjectManageState();
}

class _AdminProjectManageState extends State<AdminProjectManage> {
  List<Map<String, dynamic>> statusProjectOverview = [
    {'label': 'PENDING', 'count': 0, 'color': cardDarkYellow},
    {'label': 'ON PROGRESS', 'count': 0, 'color': cardDarkGreen},
    {'label': 'OVER DUE', 'count': 0, 'color': cardDarkRed},
  ];
  List<Map<String, dynamic>> statusTaskOverView = [
    {'label': 'PENDING', 'count': 0, 'color': cardDarkYellow},
    {'label': 'ON PROGRESS', 'count': 0, 'color': cardDarkGreen},
    {'label': 'OVER DUE', 'count': 0, 'color': cardDarkRed},
  ];

  // Separate expand/collapse state for projects
  bool showProjectPending = false;
  bool showProjectProgress = false;
  bool showProjectOverdue = false;
  bool showProjectComplete = false;
  bool showProjectArchived = false;

  // Separate expand/collapse state for tasks
  bool showTaskPending = false;
  bool showTaskProgress = false;
  bool showTaskOverdue = false;
  bool showTaskComplete = false;

  bool isLoadingProjectOverview = true;
  bool isLoadingTaskOverview = true;

  List<Map<String, dynamic>> inProgressProjects = [];
  List<Map<String, dynamic>> overdueProjects = [];
  List<Map<String, dynamic>> pendingProjects = [];
  List<Map<String, dynamic>> inProgressTasks = [];
  List<Map<String, dynamic>> overdueTasks = [];
  List<Map<String, dynamic>> pendingTasks = [];
  List<Map<String, dynamic>> archivedProjects = [];
  bool isLoadingProjectList = true;
  bool isLoadingTaskList = true;

  @override
  void initState() {
    super.initState();
    fetchProjectOverview();
    fetchTaskOverview();
    fetchProjectLists();
    fetchTasksLists();
  }

// Get Project Overview Details
  Future<void> fetchProjectOverview() async {
    setState(() {
      isLoadingProjectOverview = true;
    });
    final projects = await SupabaseService.getAllProjects();
    int overdue = 0;
    int pending = 0;
    int onProgress = 0;
    final now = DateTime.now();
    for (final p in projects) {
      final status = (p['status'] ?? '').toString().toLowerCase();
      final endDateStr = p['end_date'] ?? p['project_end_date'] ?? '';
      DateTime? endDate;
      try {
        endDate = endDateStr != '' ? DateTime.parse(endDateStr) : null;
      } catch (_) {
        endDate = null;
      }
      if (endDate != null && endDate.isBefore(now)) {
        overdue++;
      } else if (status == 'pending') {
        pending++;
      } else if (status == 'on progress' || status == 'progress') {
        onProgress++;
      }
    }
    setState(() {
      statusProjectOverview = [
        {'label': 'PENDING', 'count': pending, 'color': cardDarkYellow},
        {'label': 'WORKING', 'count': onProgress, 'color': cardDarkGreen},
        {'label': 'OVER DUE', 'count': overdue, 'color': cardDarkRed},
      ];
      isLoadingProjectOverview = false;
    });
  }

// Get Task Overview Details
  Future<void> fetchTaskOverview() async {
    setState(() {
      isLoadingTaskOverview = true;
    });
    final tasks = await SupabaseService.getAllTasks();
    int overdue = 0;
    int pending = 0;
    int onProgress = 0;
    final now = DateTime.now();
    for (final t in tasks) {
      final status = (t['status'] ?? '').toString().toLowerCase();
      final endDateStr = t['end_date'] ?? '';
      DateTime? endDate;
      try {
        endDate = endDateStr != '' ? DateTime.parse(endDateStr) : null;
      } catch (_) {
        endDate = null;
      }
      if (endDate != null && endDate.isBefore(now)) {
        overdue++;
      } else if (status == 'pending') {
        pending++;
      } else if (status == 'on progress' || status == 'progress') {
        onProgress++;
      }
    }
    setState(() {
      statusTaskOverView = [
        {'label': 'PENDING', 'count': pending, 'color': Colors.amber},
        {'label': 'WORKING', 'count': onProgress, 'color': cardGreen},
        {'label': 'OVER DUE', 'count': overdue, 'color': cardRed},
      ];
      isLoadingTaskOverview = false;
    });
  }

// get All Projects
  Future<void> fetchProjectLists() async {
    setState(() {
      isLoadingProjectList = true;
    });
    final projects = await SupabaseService.getAllProjects();
    final now = DateTime.now();
    List<Map<String, dynamic>> inProgress = [];
    List<Map<String, dynamic>> overdue = [];
    List<Map<String, dynamic>> pending = [];
    List<Map<String, dynamic>> archived = [];
    for (final p in projects) {
      final status = (p['status'] ?? '').toString().toLowerCase();
      final endDateStr = p['end_date'] ?? p['project_end_date'] ?? '';
      DateTime? endDate;
      try {
        endDate = endDateStr != '' ? DateTime.parse(endDateStr) : null;
      } catch (_) {
        endDate = null;
      }
      if ((status == 'on progress' || status == 'progress') &&
          (endDate == null || endDate.isAfter(now))) {
        inProgress.add(p);
      } else if (endDate != null && endDate.isBefore(now)) {
        overdue.add(p);
      } else if ((status == 'pending') &&
          (endDate == null || endDate.isAfter(now))) {
        pending.add(p);
      } else if (status == 'archived') {
        archived.add(p);
      }
    }
    setState(() {
      inProgressProjects = inProgress;
      overdueProjects = overdue;
      pendingProjects = pending;
      archivedProjects = archived;
      isLoadingProjectList = false;
    });
  }

  // get All Tasks
  Future<void> fetchTasksLists() async {
    setState(() {
      isLoadingTaskList = true;
    });
    final tasks = await SupabaseService.getAllTasks();
    final now = DateTime.now();

    List<Map<String, dynamic>> inProgress = [];
    List<Map<String, dynamic>> overdue = [];
    List<Map<String, dynamic>> pending = [];
    for (final t in tasks) {
      final status = (t['status'] ?? '').toString().toLowerCase();
      final endDateStr = t['end_date'] ?? t['project_end_date'] ?? '';
      DateTime? endDate;
      try {
        endDate = endDateStr != '' ? DateTime.parse(endDateStr) : null;
      } catch (_) {
        endDate = null;
      }
      if ((status == 'on progress' || status == 'progress') &&
          (endDate == null || endDate.isAfter(now))) {
        inProgress.add(t);
      } else if (endDate != null &&
          endDate.isBefore(now) &&
          status != 'complete') {
        overdue.add(t);
      } else if ((status == 'pending') &&
          (endDate == null || endDate.isAfter(now))) {
        pending.add(t);
      }
    }
    setState(() {
      inProgressTasks = inProgress;
      overdueTasks = overdue;
      pendingTasks = pending;
      isLoadingTaskList = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15),
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
                isLoadingProjectOverview
                    ? const Center(child: CircularProgressIndicator())
                    : UserUtils.buildStatusSummaryCard(statusProjectOverview),
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
                isLoadingTaskOverview
                    ? const Center(child: CircularProgressIndicator())
                    : UserUtils.buildStatusSummaryCard(statusTaskOverView),
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
          // In Progress Project Table list  Start
          UserUtils.buildExpandableGroup(
            title: "In Progress Project",
            color: cardDarkGreen,
            expanded: showProjectProgress,
            onToggle: () =>
                setState(() => showProjectProgress = !showProjectProgress),
            groupList: inProgressProjects,
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
          const SizedBox(height: 10),
          // Overdue Project Table list  Start
          UserUtils.buildExpandableGroup(
            title: "Overdue Project",
            color: cardRed,
            expanded: showProjectOverdue,
            onToggle: () =>
                setState(() => showProjectOverdue = !showProjectOverdue),
            groupList: overdueProjects,
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
          const SizedBox(height: 10),
          // Pending Project Table list  Start
          UserUtils.buildExpandableGroup(
            title: "Pending Project",
            color: cardDarkYellow,
            expanded: showProjectPending,
            onToggle: () =>
                setState(() => showProjectPending = !showProjectPending),
            groupList: pendingProjects,
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
          const SizedBox(height: 10),
          // Archived Project Table list Start
          UserUtils.buildExpandableGroup(
            title: "Archived Project",
            color: Colors.grey,
            expanded: showProjectArchived,
            onToggle: () =>
                setState(() => showProjectArchived = !showProjectArchived),
            groupList: archivedProjects,
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
            height: 20,
          ),
          // on Progress Task Table
          UserUtils.buildExpandableGroup(
            title: "In Progress Task",
            color: cardDarkGreen,
            expanded: showTaskProgress,
            onToggle: () =>
                setState(() => showTaskProgress = !showTaskProgress),
            groupList: inProgressTasks,
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
          // Overdue Task Table
          const SizedBox(height: 10),
          UserUtils.buildExpandableGroup(
            title: "Overdue Task",
            color: cardRed,
            expanded: showTaskOverdue,
            onToggle: () => setState(() => showTaskOverdue = !showTaskOverdue),
            groupList: overdueTasks,
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
          // Pending Task Table
          const SizedBox(height: 10),
          UserUtils.buildExpandableGroup(
            title: "Pending Task",
            color: cardYellow,
            expanded: showTaskPending,
            onToggle: () => setState(() => showTaskPending = !showTaskPending),
            groupList: pendingTasks,
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
            height: 20,
          )
        ],
      ),
    ));
  }
}
