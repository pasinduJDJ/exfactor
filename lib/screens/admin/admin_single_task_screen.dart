import 'package:exfactor/widgets/common/custom_button.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'package:exfactor/services/superbase_service.dart';

class AdminSingleTaskScreen extends StatefulWidget {
  final String taskId;
  const AdminSingleTaskScreen({Key? key, required this.taskId})
      : super(key: key);

  @override
  State<AdminSingleTaskScreen> createState() => _AdminSingleTaskScreenState();
}

class _AdminSingleTaskScreenState extends State<AdminSingleTaskScreen> {
  Map<String, dynamic>? task;
  bool isLoading = true;
  String? supervisorName;
  String? projectTitle;

  @override
  void initState() {
    super.initState();
    fetchTask();
  }

  Future<void> fetchTask() async {
    try {
      final taskIdInt = int.tryParse(widget.taskId);
      if (taskIdInt == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      final data = await SupabaseService.getAllTasks();
      final t = data.firstWhere((t) => t['task_id'].toString() == widget.taskId,
          orElse: () => {});
      if (t.isNotEmpty) {
        // Fetch supervisor name
        String? supName;
        if (t['supervisor_id'] != null) {
          final sup = await SupabaseService.getUserByMemberId(
            t['supervisor_id'] is int
                ? t['supervisor_id']
                : int.tryParse(t['supervisor_id'].toString()) ?? 0,
          );
          if (sup != null) {
            supName =
                ((sup['first_name'] ?? '') + ' ' + (sup['last_name'] ?? ''))
                    .trim();
          }
        }
        // Fetch project title
        String? projTitle;
        if (t['p_id'] != null) {
          final proj = await SupabaseService.getProjectById(
            t['p_id'] is int
                ? t['p_id']
                : int.tryParse(t['p_id'].toString()) ?? 0,
          );
          if (proj != null) {
            projTitle = proj['title'] ?? '';
          }
        }
        setState(() {
          task = t;
          supervisorName = supName;
          projectTitle = projTitle;
          isLoading = false;
        });
      } else {
        setState(() {
          task = null;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbgColor,
      appBar: AppBar(
        title: const Text('Mange Task',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhite,
        elevation: 1,
        iconTheme: const IconThemeData(color: kWhite),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : task == null
                ? const Center(child: Text('Task not found'))
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: Text('$projectTitle',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: kWhite,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _infoRow('Task Title',
                                        task!['title']?.toString() ?? ''),
                                    const Divider(thickness: 1),
                                    _infoRow('Supervisor name',
                                        supervisorName ?? ''),
                                    const Divider(thickness: 1),
                                    _infoRow('Commencement Date',
                                        task!['start_date'] ?? ''),
                                    const Divider(thickness: 1),
                                    _infoRow('Expected Delivery Date',
                                        task!['end_date'] ?? ''),
                                    const Divider(thickness: 1),
                                    _infoRow('Status', task!['status'] ?? ''),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: CustomButton(
                              text: "Remove",
                              onPressed: () {},
                              backgroundColor: cardDarkRed,
                            )),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$label : ',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
