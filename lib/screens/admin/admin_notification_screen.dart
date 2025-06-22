import 'package:exfactor/screens/admin/admin_add_notification.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/common/custom_button.dart';
import 'package:exfactor/widgets/notification_card_view.dart';
import 'package:flutter/material.dart';
import 'package:exfactor/services/superbase_service.dart';

class AdminNotificationScreen extends StatelessWidget {
  const AdminNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _AdminNotificationScreenBody();
  }
}

class _AdminNotificationScreenBody extends StatefulWidget {
  @override
  State<_AdminNotificationScreenBody> createState() =>
      _AdminNotificationScreenBodyState();
}

class _AdminNotificationScreenBodyState
    extends State<_AdminNotificationScreenBody> {
  List<Map<String, dynamic>> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      final fetchedNotifications = await SupabaseService.getAllNotifications();
      setState(() {
        notifications = fetchedNotifications;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminAddNotificationScreen()),
              );
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
          isLoading
              ? const CircularProgressIndicator()
              : NotificationCard.buildNotificationCards(
                  notifications
                      .map((n) => {
                            'notification_id': n['notification_id'],
                            'title': n['title'] ?? '',
                            'subtitle': n['message'] ?? '',
                            'type': n['type'] ?? '',
                            'submission_date': n['schedule_date'] ?? '',
                          })
                      .toList(),
                  onDelete: (int notificationId) async {
                    setState(() {
                      isLoading = true;
                    });
                    await SupabaseService.deleteNotification(notificationId);
                    await fetchNotifications();
                  },
                ),
        ],
      ),
    );
  }
}
