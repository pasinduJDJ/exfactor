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
      setState(() {
        task = t.isNotEmpty ? t : null;
        isLoading = false;
      });
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
        title: const Text('Single Task',
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
      body: isLoading
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
                                color: cardGreen,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Text(
                                  'Task Title : ${task!['title'] ?? ''}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _infoRow('Project Title',
                                      task!['title']?.toString() ?? ''),
                                  const Divider(thickness: 1),
                                  _infoRow('Commencement Date',
                                      task!['start_date'] ?? ''),
                                  const Divider(thickness: 1),
                                  _infoRow('Expected Delivery Date',
                                      task!['end_date'] ?? ''),
                                  const Divider(thickness: 1),
                                  _infoRow('Supervisor name',
                                      task!['supervisor'] ?? ''),
                                  const Divider(thickness: 1),
                                  _infoRow('Status', task!['status'] ?? ''),
                                ],
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: CustomButton(
                                  text: "Remove",
                                  onPressed: () {},
                                  backgroundColor: cardDarkRed,
                                )),
                          ],
                        ),
                      ),
                    ],
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
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
