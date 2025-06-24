import 'package:exfactor/widgets/common/custom_app_bar_with_icon.dart';
import 'package:exfactor/widgets/common/custom_button.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'package:exfactor/services/superbase_service.dart';

class AdminSingleProfileScreen extends StatefulWidget {
  final String userEmail;

  const AdminSingleProfileScreen({Key? key, required this.userEmail})
      : super(key: key);

  @override
  State<AdminSingleProfileScreen> createState() =>
      _AdminSingleProfileScreenState();
}

class _AdminSingleProfileScreenState extends State<AdminSingleProfileScreen> {
  Map<String, dynamic>? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      final userEmail = widget.userEmail;
      if (userEmail == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      final userData = await SupabaseService.getUserByEmail(userEmail);
      setState(() {
        user = userData;
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
      backgroundColor: KbgColor,
      appBar: CustomAppBarWithIcon(
        icon: Icons.person,
        title: user != null
            ? "${user!['first_name'] ?? ''} ${user!['last_name'] ?? ''}"
            : "User Profile",
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
              ? const Center(child: Text('User not found'))
              : Padding(
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
                                backgroundImage:
                                    (user!['profile_image'] != null &&
                                            user!['profile_image']
                                                .toString()
                                                .isNotEmpty)
                                        ? (user!['profile_image']
                                                    .toString()
                                                    .startsWith('http')
                                                ? NetworkImage(
                                                    user!['profile_image'])
                                                : AssetImage(
                                                    user!['profile_image']))
                                            as ImageProvider
                                        : null,
                                child: (user!['profile_image'] == null ||
                                        user!['profile_image']
                                            .toString()
                                            .isEmpty)
                                    ? const Icon(Icons.person_outline, size: 30)
                                    : null,
                              ),
                              const SizedBox(height: 16),
                              _infoRow('Full Name',
                                  "${user!['first_name'] ?? ''} ${user!['last_name'] ?? ''}"),
                              const Divider(thickness: 1),
                              _infoRow('Email Address', user!['email'] ?? ''),
                              const Divider(thickness: 1),
                              _infoRow('Mobile Number', user!['mobile'] ?? ''),
                              const Divider(thickness: 1),
                              _infoRow(
                                  'Date of Birth', user!['birthday'] ?? ''),
                              const Divider(thickness: 1),
                              _infoRow('Joined Date', user!['join_date'] ?? ''),
                              const Divider(thickness: 1),
                              _infoRow('Designation',
                                  user!['designation_date'] ?? ''),
                              const Divider(thickness: 1),
                              _infoRow('Supervisor', user!['supervisor'] ?? ''),
                              const Divider(thickness: 1),
                              _infoRow('Permission Type', user!['role'] ?? ''),
                              const Divider(thickness: 1),
                              const SizedBox(height: 10),
                              // Emergency contact fields if available
                              if (user!['emergency_name'] != null)
                                _infoRow('Emergency Name',
                                    user!['emergency_name'] ?? ''),
                              const Divider(thickness: 1),
                              if (user!['emergency_relationship'] != null)
                                _infoRow('Relationship',
                                    user!['emergency_relationship'] ?? ''),
                              const Divider(thickness: 1),
                              if (user!['emergency_number'] != null)
                                _infoRow('Contact number',
                                    user!['emergency_number'] ?? ''),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomButton(
                                text: "Remove Member",
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    final userIdInt =
                                        int.tryParse(user!['id'].toString());
                                    if (userIdInt != null) {
                                      await SupabaseService
                                          .deleteEmergencyContactsByUserId(
                                              userIdInt);
                                      await SupabaseService.deleteUser(
                                          userIdInt);
                                      if (mounted) {
                                        Navigator.of(context).pop(true);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'User removed successfully.')),
                                        );
                                      }
                                    }
                                  } catch (e) {
                                    if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Failed to remove user: \\${e.toString()}')),
                                      );
                                    }
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  }
                                },
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
