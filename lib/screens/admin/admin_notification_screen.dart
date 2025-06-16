import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/common/custom_button.dart';
import 'package:exfactor/widgets/notification_card_view.dart';
import 'package:flutter/material.dart';

class AdminNotificationScreen extends StatelessWidget {
  const AdminNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Server Upgrade',
        'subtitle': 'Will be offline from 2–4 AM',
        'type': 'Event',
        'submission_date': '2025-06-16',
      },
      {
        'title': "Harindu's Birthday",
        'subtitle': 'Wish Harindu a happy birthday today!',
        'type': 'Birthday',
        'submission_date': '2025-06-16',
      },
      {
        'title': 'Weekly Newsletter',
        'subtitle': 'Your digest for the week is ready',
        'type': 'News',
        'submission_date': '2025-06-15',
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            text: "Add Alert",
            width: double.infinity,
            backgroundColor: kPrimaryColor,
            onPressed: () {
              // TODO: Implement add alert navigation
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              Text(
                "NOIFICATION ",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          NotificationCard.buildNotificationCards(notifications)
        ],
      ),
    );
  }
}
