import 'package:exfactor/screens/login_page.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/common/custom_button.dart';

class SupervisorProfileScreen extends StatefulWidget {
  const SupervisorProfileScreen({Key? key}) : super(key: key);

  @override
  State<SupervisorProfileScreen> createState() =>
      _SupervisorProfileScreenState();
}

class _SupervisorProfileScreenState extends State<SupervisorProfileScreen> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FB),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          width: 340,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage(user['avatar']!),
              ),
              const SizedBox(height: 20),
              _buildInfoRow('Full Name', user['name']!),
              _buildInfoRow('Email Adress', user['email']!),
              _buildInfoRow('Mobile Number', user['mobile']!),
              _buildInfoRow('Date of Birth', user['dob']!),
              _buildInfoRow('Joined Date', user['joined']!),
              _buildInfoRow('Designation', user['designation']!),
              _buildInfoRow('Supervisor', user['supervisor']!),
              _buildInfoRow('Permission Type', user['permission']!),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Emergency Contact..',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              _buildInfoRow('Full Name', user['emergencyName']!),
              _buildInfoRow('Relationship', user['emergencyRelation']!),
              _buildInfoRow('Contact number', user['emergencyNumber']!),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomButton(
                    text: "Update",
                    onPressed: () {},
                    backgroundColor: cardGreen,
                    width: double.infinity / 2,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomButton(
                    text: "Log Out",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const LoginPage();
                      }));
                    },
                    backgroundColor: cardRed,
                    width: double.infinity / 2,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
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
