import 'package:exfactor/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/common/custom_button.dart';

class SupervisorTeamScreen extends StatelessWidget {
  const SupervisorTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final teamMembers = [
      {
        'name': 'John Doe',
        'role': 'Technical Lead',
        'status': 'Active',
        'avatar': 'assets/images/avatar.png',
        'activeTasks': 3,
      },
      {
        'name': 'Jane Smith',
        'role': 'Network Engineer',
        'status': 'On Leave',
        'avatar': 'assets/images/avatar.png',
        'activeTasks': 0,
      },
      {
        'name': 'Mike Johnson',
        'role': 'System Administrator',
        'status': 'Active',
        'avatar': 'assets/images/avatar.png',
        'activeTasks': 2,
      },
    ];

    return Container(
      color: KbgColor,
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Team Members',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              CustomButton(
                text: 'Add Member',
                onPressed: () {
                  // TODO: Navigate to add member screen
                },
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultSpacing * 2),
          Expanded(
            child: ListView.builder(
              itemCount: teamMembers.length,
              itemBuilder: (context, index) {
                final member = teamMembers[index];
                return Card(
                  margin: const EdgeInsets.only(
                    bottom: AppConstants.defaultSpacing,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(
                      AppConstants.defaultPadding,
                    ),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(member['avatar'] as String),
                      radius: 25,
                    ),
                    title: Text(
                      member['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppConstants.defaultSpacing / 2),
                        Text(member['role'] as String),
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
                                    _getStatusColor(member['status'] as String),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                member['status'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${member['activeTasks']} Active Tasks',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        // TODO: Show member actions
                      },
                    ),
                    onTap: () {
                      // TODO: Navigate to member details
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
      case 'active':
        return Colors.green;
      case 'on leave':
        return Colors.orange;
      case 'inactive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
