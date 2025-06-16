import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class AdminSingleProjectScreen extends StatelessWidget {
  const AdminSingleProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock project data
    final project = {
      'title': 'Backend Migration Project',
      'initialNo': '',
      'message': '',
      'client': 'Amana Logistic',
      'contactPerson': 'John Akrahm',
      'email': 'amanalogic@gmail.com',
      'number': '076 706 6455',
      'country': 'Zambia',
      'supervisors': 'testUser 01, testUser02',
      'team': 'user01, user02, user03, user04',
      'commencement': '2025-06-09',
      'delivery': '2025-09-09',
      'tasks': [
        'Database Migration',
        'Sample task',
        'Sample task',
        'Sample task',
      ],
    };
    return Scaffold(
      backgroundColor: KbgColor,
      appBar: AppBar(
        title: const Text('Single Projects',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhite,
        elevation: 1,
        iconTheme: const IconThemeData(color: kWhite),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow('Project Title', project['title'] as String),
                    _infoRow(
                        'Project Initial No', project['initialNo'] as String),
                    _infoRow('Project Message', project['message'] as String),
                    const SizedBox(height: 10),
                    _infoRow(
                        'Client Name or Company', project['client'] as String),
                    _infoRow('Primary Contact Person',
                        project['contactPerson'] as String),
                    _infoRow('Contact email', project['email'] as String,
                        copy: true),
                    _infoRow('Contact number', project['number'] as String,
                        copy: true),
                    _infoRow('Client Country', project['country'] as String),
                    _infoRow('Supervisor', project['supervisors'] as String),
                    _infoRow('Team members', project['team'] as String),
                    _infoRow(
                        'Commencement Date', project['commencement'] as String),
                    _infoRow('Expected Delivery Date',
                        project['delivery'] as String),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {},
              child: const Text('In Archive Project'),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Task List',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    ...List.generate(
                        (project['tasks'] as List<String>).length,
                        (i) => ListTile(
                              title:
                                  Text((project['tasks'] as List<String>)[i]),
                              trailing: TextButton(
                                onPressed: () {},
                                child: const Text('See more..'),
                              ),
                            )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool copy = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label : ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
          if (copy)
            IconButton(
              icon: const Icon(Icons.copy, size: 16),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}
