import 'package:exfactor/screens/login_page.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/common/custom_button.dart';

class TechnicalProfileScreen extends StatelessWidget {
  const TechnicalProfileScreen({Key? key}) : super(key: key);

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
              const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(height: 20),
              _buildInfoRow('Full Name', 'Pasindu Dulanjana'),
              _buildInfoRow('Email Address', 'dp@exfsys.com'),
              _buildInfoRow('Mobile Number', '076 706 6455'),
              _buildInfoRow('Date of Birth', '2000 - Oct - 25'),
              _buildInfoRow('Joined Date', '2025 - 01 - 01'),
              _buildInfoRow('Designation', '2026 - 01 - 01'),
              _buildInfoRow('Supervisor', 'Chumley D.'),
              _buildInfoRow('Permission Type', 'Technical User'),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Emergency Contact..',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              _buildInfoRow('Full Name', 'Pathirage Jayawardena'),
              _buildInfoRow('Relationship', 'Father'),
              _buildInfoRow('Contact number', '076 707 7546'),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomButton(
                    text: "Update",
                    onPressed: () {},
                    backgroundColor: Colors.green,
                    width: double.infinity / 2,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomButton(
                    text: "Delete",
                    onPressed: () {},
                    backgroundColor: Colors.red,
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
                    backgroundColor: kPrimaryColor,
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
