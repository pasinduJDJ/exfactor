import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/common/custom_button.dart';

class TechnicalProfileScreen extends StatelessWidget {
  const TechnicalProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bgColor,
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
              'Mike Johnson',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.themeColor,
              ),
            ),
            const Text(
              'Technical Engineer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: AppConstants.defaultSpacing * 3),
            _buildInfoSection(
              title: 'Personal Information',
              items: {
                'Email': 'mike.johnson@example.com',
                'Phone': '+1 234 567 890',
                'Location': 'New York, USA',
                'Department': 'IT Operations',
              },
            ),
            const SizedBox(height: AppConstants.defaultSpacing * 2),
            _buildInfoSection(
              title: 'Performance Statistics',
              items: {
                'Tasks Completed': '45',
                'On-time Completion': '95%',
                'Average Rating': '4.8/5.0',
                'Response Time': '< 30 mins',
              },
            ),
            const SizedBox(height: AppConstants.defaultSpacing * 2),
            _buildInfoSection(
              title: 'Skills & Certifications',
              items: {
                'Primary Skills': 'Network, Server Administration',
                'Certifications': 'CCNA, AWS Associate',
                'Experience': '5+ years',
                'Specialization': 'Cloud Infrastructure',
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
