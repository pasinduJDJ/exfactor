import 'package:exfactor/screens/admin/admin_add_user.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/common/custom_button.dart';
import 'package:exfactor/widgets/user_card_view.dart';
import 'package:flutter/material.dart';

class MangeUsers extends StatefulWidget {
  const MangeUsers({super.key});

  @override
  State<MangeUsers> createState() => _MangeUsersState();
}

class _MangeUsersState extends State<MangeUsers> {
  final users = [
    {
      'name': 'Pasindu Dulanajana',
      'email': 'dp@exfsys.com',
      'role': 'QA & Mobile Technologie Associate',
      'avatar': 'assets/avatars/pasindu.png',
    },
    {
      'name': 'Kamith Iiyanage',
      'email': 'kl@exfsys.com',
      'role': 'Mobile Technologie Associate',
      'avatar': 'assets/avatars/kamith.png',
    },
    {
      'name': 'Harindu Yapa',
      'email': 'hy@exfsys.com',
      'role': 'QA Associate',
      'avatar': 'assets/avatars/harindu.png',
    },
  ];
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
            text: "Add New Team Members",
            width: double.infinity,
            backgroundColor: kPrimaryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserScreen()),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              Text(
                "Exfactor Team",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ],
          ),
          User_card.buildUserGridCard(users),
        ],
      ),
    );
  }
}
