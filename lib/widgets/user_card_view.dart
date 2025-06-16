import 'package:exfactor/screens/admin/admin_single_profile.dart';
import 'package:flutter/material.dart';

class User_card {
  static Widget buildUserGridCard(List<Map<String, String>> users) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // change to 2 for two columns
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3, // tweak to get your card shape
        ),
        itemCount: users.length,
        itemBuilder: (context, i) {
          final u = users[i];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(u['name']!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(u['email']!,
                            style: TextStyle(color: Colors.grey[700])),
                        const SizedBox(height: 4),
                        Text(u['role']!,
                            style: TextStyle(color: Colors.grey[700])),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdminSingleProfileScreen(user: u),
                                // builder: (context) =>AdminSingleProfileScreen(user: u),
                              ),
                            );
                          },
                          child: const Text(
                            'see more ..',
                          ),
                        ),
                      ],
                    ),
                  ),

                  // avatar
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: u['avatar']!.isNotEmpty
                        ? AssetImage(u['avatar']!)
                        : null,
                    child: u['avatar']!.isEmpty
                        ? const Icon(Icons.person_outline, size: 40)
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
