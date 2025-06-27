import 'package:exfactor/screens/admin/admin_add_user.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:exfactor/widgets/common/custom_button.dart';
import 'package:exfactor/widgets/user_card_view.dart';
import 'package:flutter/material.dart';
import 'package:exfactor/services/superbase_service.dart';

class MangeUsers extends StatefulWidget {
  const MangeUsers({super.key});

  @override
  State<MangeUsers> createState() => _MangeUsersState();
}

class _MangeUsersState extends State<MangeUsers> {
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final fetchedUsers = await SupabaseService.getAllUsers();
      setState(() {
        users = fetchedUsers;
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
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15),
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
          isLoading
              ? const CircularProgressIndicator()
              : UserCard.buildUserGridCard(
                  users
                      .map((u) => {
                            'id': u['id']?.toString() ?? '',
                            'name':
                                '${u['first_name'] ?? ''} ${u['last_name'] ?? ''}',
                            'email': u['email']?.toString() ?? '',
                            'role': u['position']?.toString() ?? '',
                            'avatar': u['profile_image']?.toString() ?? '',
                          } as Map<String, String>)
                      .toList(),
                ),
        ],
      ),
    ));
  }
}
