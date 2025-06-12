import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../widgets/common/custom_button.dart';

class AdminTaskScreen extends StatelessWidget {
  const AdminTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Task Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.themeColor,
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Create New Task',
              onPressed: () {
                // TODO: Implement task creation
              },
            ),
          ],
        ),
      ),
    );
  }
}
