import 'package:exfactor/widgets/common/custom_app_bar_with_icon.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'package:exfactor/services/superbase_service.dart';

class AdminSingleProjectScreen extends StatefulWidget {
  final String projectId;
  const AdminSingleProjectScreen({Key? key, required this.projectId})
      : super(key: key);

  @override
  State<AdminSingleProjectScreen> createState() =>
      _AdminSingleProjectScreenState();
}

class _AdminSingleProjectScreenState extends State<AdminSingleProjectScreen> {
  Map<String, dynamic>? project;
  bool isLoading = true;
  List<Map<String, dynamic>> projectTasks = [];
  bool isLoadingTasks = true;

  @override
  void initState() {
    super.initState();
    fetchProject();
    fetchTasks();
  }

  Future<void> fetchProject() async {
    try {
      final projectIdInt = int.tryParse(widget.projectId);
      if (projectIdInt == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      final data = await SupabaseService.getAllProjects();
      final proj = data.firstWhere(
          (p) => p['project_id'].toString() == widget.projectId,
          orElse: () => {});
      setState(() {
        project = proj.isNotEmpty ? proj : null;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchTasks() async {
    setState(() {
      isLoadingTasks = true;
    });
    final projectIdInt = int.tryParse(widget.projectId);
    if (projectIdInt == null) {
      setState(() {
        isLoadingTasks = false;
      });
      return;
    }
    final tasks = await SupabaseService.getTasksForProject(projectIdInt);
    setState(() {
      projectTasks = tasks;
      isLoadingTasks = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgColor,
      appBar: CustomAppBarWithIcon(icon: Icons.task, title: "Project Details"),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : project == null
              ? const Center(child: Text('Project not found'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _infoRow(
                                  'Project Title', project!['title'] ?? ''),
                              const SizedBox(height: 5),
                              // _infoRow('Project Initial No',
                              //     project!['project_id'] ?? ''),
                              _infoRow('Project Message',
                                  project!['description'] ?? ''),
                              const SizedBox(height: 10),
                              _infoRow('Client Name or Company',
                                  project!['client_name'] ?? ''),
                              _infoRow('Primary Contact Person',
                                  project!['contact_person'] ?? ''),
                              _infoRow('Contact email',
                                  project!['contact_email'] ?? '',
                                  copy: true),
                              _infoRow('Contact number',
                                  project!['contact_mobile'] ?? '',
                                  copy: true),
                              _infoRow('Client Country',
                                  project!['client_country'] ?? ''),
                              _infoRow(
                                  'Supervisor', project!['supervisor'] ?? ''),
                              _infoRow('Commencement Date',
                                  project!['start_date'] ?? ''),
                              _infoRow('Expected Delivery Date',
                                  project!['end_date'] ?? ''),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {},
                        child: const Text('In Archive Project'),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('Task List',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            isLoadingTasks
                                ? const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )
                                : projectTasks.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Text(
                                            'No tasks assigned to this project.'),
                                      )
                                    : Column(
                                        children: projectTasks
                                            .map((task) => ListTile(
                                                  title:
                                                      Text(task['title'] ?? ''),
                                                  trailing: TextButton(
                                                    onPressed: () {
                                                      // TODO: Navigate to single task screen
                                                    },
                                                    child: const Text(
                                                        'See more..'),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _infoRow(String label, String value, {bool copy = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label : ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
          if (copy)
            IconButton(
              icon: const Icon(Icons.copy, size: 16),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}
