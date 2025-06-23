import 'package:exfactor/services/superbase_service.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/utils/constants.dart';
import 'package:exfactor/widgets/technical_notification_card.dart';
import 'package:flutter/material.dart';

class SupervisorNotification extends StatefulWidget {
  const SupervisorNotification({super.key});

  @override
  State<SupervisorNotification> createState() => _SupervisorNotificationState();
}

class _SupervisorNotificationState extends State<SupervisorNotification> {
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
    return Container(
      color: KbgColor,
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          isLoading
              ? const CircularProgressIndicator()
              : TechnicalNotificationCard.buildNotificationCards(
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
