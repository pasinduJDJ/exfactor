import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';

class AdminNotificationScreen extends StatelessWidget {
  const AdminNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy notifications data
    final notifications = [
      {
        'title': 'New Task Assigned',
        'message': 'A new task has been assigned to Team A',
        'time': '2 hours ago',
        'isRead': false,
      },
      {
        'title': 'Task Completed',
        'message': 'Team B has completed their assigned task',
        'time': '5 hours ago',
        'isRead': true,
      },
    ];

    return Container(
      color: AppTheme.bgColor,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.only(bottom: AppConstants.defaultSpacing),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: notification['isRead'] as bool
                    ? Colors.grey[200]
                    : AppTheme.themeColor,
                child: Icon(
                  Icons.notifications,
                  color: notification['isRead'] as bool
                      ? Colors.grey
                      : Colors.white,
                ),
              ),
              title: Text(
                notification['title'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification['message'] as String),
                  const SizedBox(height: 4),
                  Text(
                    notification['time'] as String,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              onTap: () {
                // TODO: Handle notification tap
              },
            ),
          );
        },
      ),
    );
  }
}
