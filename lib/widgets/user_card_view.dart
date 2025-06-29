import 'package:flutter/material.dart';
import 'package:exfactor/screens/admin/admin_single_profile.dart';

class UserCard {
  static Widget buildUserGridCard(List<Map<String, String>> users) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(), // Important if inside Column
        itemCount: users.length,
        itemBuilder: (context, i) {
          final u = users[i];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// User Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            u['name'] ?? '',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            u['email'] ?? '',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            u['role'] ?? '',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AdminSingleProfileScreen(
                                          userEmail: u['email'] ?? ''),
                                ),
                              );
                            },
                            child: const Text(
                              'see more ..',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Avatar
                    const SizedBox(width: 12),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          (u['avatar'] != null && u['avatar']!.isNotEmpty)
                              ? AssetImage(u['avatar']!) as ImageProvider
                              : null,
                      child: (u['avatar'] == null || u['avatar']!.isEmpty)
                          ? const Icon(Icons.person_outline, size: 30)
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
