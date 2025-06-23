import 'package:exfactor/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:exfactor/screens/login_page.dart';
import 'package:exfactor/utils/colors.dart';
import '../../widgets/common/custom_button.dart';

class TechnicalProfileScreen extends StatefulWidget {
  final UserModel user;
  const TechnicalProfileScreen({Key? key, required this.user})
      : super(key: key);

  @override
  State<TechnicalProfileScreen> createState() => _TechnicalProfileScreenState();
}

class _TechnicalProfileScreenState extends State<TechnicalProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCEAF5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            //Avatar
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(widget.user.profileImage),
            ),

            const SizedBox(height: 16),

            // User Info Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _infoCard({
                    'First Name': widget.user.firstName,
                    'Last Name': widget.user.lastName,
                    'Position': widget.user.position,
                    'Email Address': widget.user.email,
                    'Mobile Number': widget.user.mobile,
                    'Date Of Birth': widget.user.birthday.toString(),
                    'Join Date': widget.user.joinDate.toString(),
                    'Designation Date': widget.user.designationDate.toString(),
                    'Supervisor': widget.user.supervisor ?? '',
                    'Position': widget.user.position,
                  }),
                  const SizedBox(height: 16),
                  _infoCard({
                    'Name': widget.user.emergencyName,
                    'Contact Number': widget.user.emergencyMobileNumber,
                    'Relationship': widget.user.emergencyRelationship,
                  }),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: "Update",
                    onPressed: () {},
                    backgroundColor: cardGreen,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 5),
                  CustomButton(
                    text: "Log Out",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const LoginPage();
                      }));
                    },
                    backgroundColor: cardRed,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget to create info card
  Widget _infoCard(Map<String, String> infoMap) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: infoMap.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        entry.value,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1),
            ],
          );
        }).toList(),
      ),
    );
  }
}
