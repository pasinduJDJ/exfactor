import 'package:exfactor/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/common/custom_button.dart';

class AdminManageScreen extends StatelessWidget {
  const AdminManageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'title': 'Manage Users',
        'icon': Icons.people,
        'onTap': () {
          Navigator.pushNamed(context, '/admin-add-user');
        },
      },
      {
        'title': 'Manage Teams',
        'icon': Icons.group_work,
        'onTap': () {
          // TODO: Implement team management
        },
      },
      {
        'title': 'Manage Roles',
        'icon': Icons.admin_panel_settings,
        'onTap': () {
          // TODO: Implement role management
        },
      },
      {
        'title': 'Settings',
        'icon': Icons.settings,
        'onTap': () {
          // TODO: Implement settings
        },
      },
    ];

    return Container(
      color: KbgColor,
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Management',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(height: AppConstants.defaultSpacing * 2),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppConstants.defaultSpacing,
                mainAxisSpacing: AppConstants.defaultSpacing,
                childAspectRatio: 1.5,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return Card(
                  child: InkWell(
                    onTap: item['onTap'] as VoidCallback,
                    borderRadius:
                        BorderRadius.circular(AppConstants.defaultRadius),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          size: 32,
                          color: kPrimaryColor,
                        ),
                        const SizedBox(height: AppConstants.defaultSpacing),
                        Text(
                          item['title'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppConstants.defaultSpacing * 2),
          CustomButton(
            text: 'Generate Report',
            onPressed: () {
              // TODO: Implement report generation
            },
          ),
        ],
      ),
    );
  }
}
