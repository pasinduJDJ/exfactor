import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/common/custom_button.dart';

class TechnicalHome extends StatelessWidget {
  const TechnicalHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskStats = [
      {
        'title': 'Assigned Tasks',
        'value': '5',
        'icon': Icons.assignment,
        'color': Colors.blue,
      },
      {
        'title': 'In Progress',
        'value': '2',
        'icon': Icons.pending_actions,
        'color': Colors.orange,
      },
      {
        'title': 'Completed Today',
        'value': '3',
        'icon': Icons.check_circle,
        'color': Colors.green,
      },
      {
        'title': 'Overdue',
        'value': '1',
        'icon': Icons.warning,
        'color': Colors.red,
      },
    ];

    return Container(
      color: AppTheme.bgColor,
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Tasks',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.themeColor,
            ),
          ),
          const SizedBox(height: AppConstants.defaultSpacing * 2),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppConstants.defaultSpacing,
              mainAxisSpacing: AppConstants.defaultSpacing,
              childAspectRatio: 1.5,
            ),
            itemCount: taskStats.length,
            itemBuilder: (context, index) {
              final stat = taskStats[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        stat['icon'] as IconData,
                        color: stat['color'] as Color,
                        size: 32,
                      ),
                      const SizedBox(height: AppConstants.defaultSpacing),
                      Text(
                        stat['value'] as String,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        stat['title'] as String,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppConstants.defaultSpacing * 2),
          CustomButton(
            text: 'Start New Task',
            onPressed: () {
              // TODO: Navigate to task details
            },
          ),
        ],
      ),
    );
  }
}
