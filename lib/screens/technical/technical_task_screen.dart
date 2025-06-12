import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/common/custom_button.dart';

class TechnicalTaskScreen extends StatelessWidget {
  const TechnicalTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {
        'title': 'Network Maintenance',
        'description': 'Perform routine network maintenance and updates',
        'status': 'In Progress',
        'priority': 'High',
        'dueDate': '2024-03-20',
        'supervisor': 'John Smith',
      },
      {
        'title': 'Server Backup',
        'description': 'Create backup of production servers',
        'status': 'Pending',
        'priority': 'Medium',
        'dueDate': '2024-03-22',
        'supervisor': 'Jane Doe',
      },
      {
        'title': 'Software Update',
        'description': 'Deploy latest software updates to client machines',
        'status': 'Completed',
        'priority': 'Low',
        'dueDate': '2024-03-18',
        'supervisor': 'John Smith',
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
                'My Tasks',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.themeColor,
                ),
              ),
              CustomButton(
                text: 'Filter',
                onPressed: () {
                  // TODO: Show filter options
                },
                isOutlined: true,
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
                  child: ExpansionTile(
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
                        Text('Due: ${task['dueDate']}'),
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
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.all(AppConstants.defaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task['description'] as String,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: AppConstants.defaultSpacing),
                            Text(
                              'Supervisor: ${task['supervisor']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: AppConstants.defaultSpacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomButton(
                                  text: 'Update Status',
                                  onPressed: () {
                                    // TODO: Show status update dialog
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
