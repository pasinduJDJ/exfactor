import 'package:exfactor/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../utils/constants.dart';
import '../../widgets/common/custom_button.dart';

class TechnicalReportScreen extends StatelessWidget {
  const TechnicalReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reports = [
      {
        'title': 'Network Maintenance Report',
        'date': '2024-03-19',
        'status': 'Submitted',
        'type': 'Maintenance',
      },
      {
        'title': 'Server Backup Report',
        'date': '2024-03-18',
        'status': 'Draft',
        'type': 'Backup',
      },
      {
        'title': 'Security Audit Report',
        'date': '2024-03-17',
        'status': 'Approved',
        'type': 'Audit',
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
                'Reports',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              CustomButton(
                text: 'New Report',
                onPressed: () {
                  // TODO: Navigate to create report screen
                },
              ),
            ],
          ),
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
                        Text('Date: ${report['date']}'),
                        const SizedBox(height: AppConstants.defaultSpacing / 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(report['status'] as String),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            report['status'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        // TODO: Show report actions
                      },
                    ),
                    onTap: () {
                      // TODO: Navigate to report details
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
      case 'approved':
        return Colors.green;
      case 'submitted':
        return Colors.blue;
      case 'draft':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'maintenance':
        return Colors.blue;
      case 'backup':
        return Colors.purple;
      case 'audit':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'maintenance':
        return Icons.build;
      case 'backup':
        return Icons.backup;
      case 'audit':
        return Icons.security;
      default:
        return Icons.description;
    }
  }
}
