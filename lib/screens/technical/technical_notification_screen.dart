import 'package:exfactor/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class TechnicalReportScreen extends StatelessWidget {
  const TechnicalReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reports = [
      {
        'title': 'System Down',
        'message': 'Network maintenance scheduled for March 20, 2024.',
        'type': 'notice',
      },
      {
        'title': 'Chrisms Party',
        'message':
            ' Join us for the annual Christmas party on December 25, 2024.',
        'type': 'event',
      },
      {
        'title': 'Happy Birthday',
        'message': 'To day is John\'s birthday. Wish him a great day!',
        'type': 'birthday',
      },
    ];

    return Container(
      color: KbgColor,
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppConstants.defaultSpacing * 2),
          Expanded(
            child: ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return Card(
                  margin: const EdgeInsets.only(
                    bottom: AppConstants.defaultSpacing,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(
                      AppConstants.defaultPadding,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: _getTypeColor(report['type'] as String),
                      child: Icon(
                        _getTypeIcon(report['type'] as String),
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      report['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppConstants.defaultSpacing / 2),
                        Text('${report['message']}'),
                        const SizedBox(height: AppConstants.defaultSpacing / 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'event':
        return const Color.fromARGB(255, 226, 203, 1);
      case 'notice':
        return const Color.fromARGB(255, 19, 0, 191);
      case 'birthday':
        return const Color.fromARGB(255, 174, 1, 18);
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'event':
        return Icons.calendar_month;
      case 'notice':
        return Icons.info_rounded;
      case 'birthday':
        return Icons.cake;
      default:
        return Icons.description;
    }
  }
}
