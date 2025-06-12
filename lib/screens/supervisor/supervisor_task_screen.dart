import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/common/custom_button.dart';

class SupervisorTaskScreen extends StatelessWidget {
  const SupervisorTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {
        'title': 'Server Maintenance',
        'assignee': 'John Doe',
        'status': 'In Progress',
        'priority': 'High',
        'dueDate': '2024-03-20',
      },
      {
        'title': 'Network Setup',
        'assignee': 'Jane Smith',
        'status': 'Pending',
        'priority': 'Medium',
        'dueDate': '2024-03-22',
      },
      {
        'title': 'Security Audit',
        'assignee': 'Mike Johnson',
        'status': 'Completed',
        'priority': 'High',
        'dueDate': '2024-03-18',
      },
    ];

    return Container(
      color: AppTheme.bgColor,
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Team Tasks',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.themeColor,
                ),
              ),
              CustomButton(
                text: 'New Task',
                onPressed: () {
                  // TODO: Navigate to task creation
                },
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultSpacing * 2),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: const EdgeInsets.only(
                    bottom: AppConstants.defaultSpacing,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(
                      AppConstants.defaultPadding,
                    ),
                    title: Text(
                      task['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppConstants.defaultSpacing / 2),
                        Text('Assignee: ${task['assignee']}'),
                        Text('Due Date: ${task['dueDate']}'),
                        const SizedBox(height: AppConstants.defaultSpacing / 2),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    _getStatusColor(task['status'] as String),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                task['status'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getPriorityColor(
                                    task['priority'] as String),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                task['priority'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        // TODO: Show task actions
                      },
                    ),
                    onTap: () {
                      // TODO: Navigate to task details
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'in progress':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
