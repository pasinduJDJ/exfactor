import 'package:exfactor/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/common/custom_button.dart';

class SupervisorHome extends StatelessWidget {
  const SupervisorHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final teamStats = [
      {
        'title': 'Team Members',
        'value': '8',
        'icon': Icons.people,
        'color': Colors.blue,
      },
      {
        'title': 'Active Tasks',
        'value': '5',
        'icon': Icons.task,
        'color': Colors.green,
      },
      {
        'title': 'Pending Reviews',
        'value': '3',
        'icon': Icons.rate_review,
        'color': Colors.orange,
      },
      {
        'title': 'Completed Today',
        'value': '12',
        'icon': Icons.check_circle,
        'color': Colors.purple,
      },
    ];

    return Container(
      color: KbgColor,
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Team Overview',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color:kPrimaryColor,
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
            itemCount: teamStats.length,
            itemBuilder: (context, index) {
              final stat = teamStats[index];
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
            text: 'Assign New Task',
            onPressed: () {
              // TODO: Navigate to task assignment
            },
          ),
        ],
      ),
    );
  }
}
