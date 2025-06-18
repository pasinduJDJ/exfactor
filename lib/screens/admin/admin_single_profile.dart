import 'package:exfactor/widgets/common/custom_app_bar_with_icon.dart';
import 'package:exfactor/widgets/common/custom_button.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class AdminSingleProfileScreen extends StatelessWidget {
  final Map<String, String> user;

  const AdminSingleProfileScreen({Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = {
      'name': 'Pasindu Dulanajana',
      'email': 'dp@exfsys.com',
      'mobile': '076 706 6455',
      'dob': '2000-10-25',
      'joined': '2025-01-01',
      'designation': '2026-01-01',
      'supervisor': 'Chumley D.',
      'permission': 'Technical User',
      'emergencyName': 'Pathirage Jayawardena',
      'emergencyRelation': 'Father',
      'emergencyNumber': '076 707 7546',
      'avatar': 'assets/images/avatar.png',
    };
    return Scaffold(
      backgroundColor: KbgColor,
      appBar:
          CustomAppBarWithIcon(icon: Icons.person, title: "Pasindu Dulanajana"),
      body: Padding(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage(user['avatar']!),
                    ),
                    const SizedBox(height: 16),
                    _infoRow('Full Name', user['name']!),
                    _infoRow('Email Adress', user['email']!),
                    _infoRow('Mobile Number', user['mobile']!),
                    _infoRow('Date of Birth', user['dob']!),
                    _infoRow('Joined Date', user['joined']!),
                    _infoRow('Designation', user['designation']!),
                    _infoRow('Supervisor', user['supervisor']!),
                    _infoRow('Permission Type', user['permission']!),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Emergency Contact..',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    _infoRow('Full Name', user['emergencyName']!),
                    _infoRow('Relationship', user['emergencyRelation']!),
                    _infoRow('Contact number', user['emergencyNumber']!),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      text: "Remove Member",
                      onPressed: () {},
                      backgroundColor: cardDarkRed,
                      width: double.infinity / 2,
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

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 4,
              child: Text('$label :',
                  style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(flex: 6, child: Text(value)),
        ],
      ),
    );
  }
}
