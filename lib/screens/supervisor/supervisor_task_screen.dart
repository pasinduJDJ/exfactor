import 'package:exfactor/screens/admin/admin_add_task_screen.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/utils_widget.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/common/custom_button.dart';

class SupervisorTaskScreen extends StatefulWidget {
  const SupervisorTaskScreen({Key? key}) : super(key: key);

  @override
  State<SupervisorTaskScreen> createState() => _SupervisorTaskScreenState();
}

class _SupervisorTaskScreenState extends State<SupervisorTaskScreen> {
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
      child: Column(
        children: [
          SizedBox(height: 20),
          UserUtils.buildStatusSummaryCard(statusItems),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: "Add New Task",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AdminAddTaskScreen()));
            },
            width: double.infinity,
            icon: Icon(Icons.task),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Currently Assign Projects | Tasks",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          supervisorTaskCard()
        ],
      ),
    );
  }
}

class supervisorTaskCard extends StatelessWidget {
  const supervisorTaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: kblack,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Task Name : ABC Mobile App Project",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              "Current Status: On Progress",
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Request : Complete",
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: cardGreen.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Approve",
                      style: TextStyle(color: cardGreen),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
