import 'package:exfactor/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/common/custom_button.dart';

class SupervisorProfileScreen extends StatelessWidget {
  const SupervisorProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KbgColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: AppConstants.defaultSpacing * 2),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            const SizedBox(height: AppConstants.defaultSpacing * 2),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const Text(
              'Senior Supervisor',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: AppConstants.defaultSpacing * 3),
            _buildInfoSection(
              title: 'Personal Information',
              items: {
                'Email': 'john.doe@example.com',
                'Phone': '+1 234 567 890',
                'Location': 'New York, USA',
                'Department': 'IT Operations',
              },
            ),
            const SizedBox(height: AppConstants.defaultSpacing * 2),
            _buildInfoSection(
              title: 'Team Statistics',
              items: {
                'Team Size': '8 Members',
                'Active Projects': '3',
                'Completed Projects': '12',
                'Team Performance': '95%',
              },
            ),
            const SizedBox(height: AppConstants.defaultSpacing * 3),
            CustomButton(
              text: 'Edit Profile',
              onPressed: () {
                // TODO: Navigate to edit profile
              },
            ),
            const SizedBox(height: AppConstants.defaultSpacing),
            CustomButton(
              text: 'Change Password',
              isOutlined: true,
              onPressed: () {
                // TODO: Navigate to change password
              },
            ),
            const SizedBox(height: AppConstants.defaultSpacing * 2),
            TextButton(
              onPressed: () {
                // TODO: Implement logout
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required Map<String, String> items,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.defaultSpacing),
            ...items.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(
                  bottom: AppConstants.defaultSpacing,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      entry.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
