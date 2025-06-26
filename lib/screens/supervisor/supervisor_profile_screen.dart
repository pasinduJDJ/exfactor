import 'package:exfactor/models/user_model.dart';
import 'package:exfactor/screens/login_page.dart';
import 'package:exfactor/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/common/custom_button.dart';
import 'supervisor_update_user.dart';
import '../../services/superbase_service.dart';

class SupervisorProfileScreen extends StatefulWidget {
  final UserModel user;
  const SupervisorProfileScreen({Key? key, required this.user})
      : super(key: key);

  @override
  State<SupervisorProfileScreen> createState() =>
      _SupervisorProfileScreenState();
}

class _SupervisorProfileScreenState extends State<SupervisorProfileScreen> {
  late UserModel _user;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    setState(() => _loading = true);
    final data = await SupabaseService.getUserByMemberId(_user.memberId);
    if (data != null) {
      setState(() {
        _user = UserModel.fromMap(data);
        _loading = false;
      });
    } else {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
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
              backgroundImage: AssetImage(_user.profileImage ?? ''),
            ),

            const SizedBox(height: 16),

            // User Info Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _infoCard({
                    'First Name': _user.firstName ?? '',
                    'Last Name': _user.lastName ?? '',
                    'Position': _user.position ?? '',
                    'Email Address': _user.email ?? '',
                    'Mobile Number': _user.mobile ?? '',
                    'Date Of Birth': _user.birthday ?? '',
                    'Join Date': _user.joinDate ?? '',
                    'Designation Date': _user.designationDate ?? '',
                    'Supervisor': _user.supervisor ?? '',
                  }),
                  const SizedBox(height: 16),
                  _infoCard({
                    'Name': _user.emergencyName ?? '',
                    'Contact Number': _user.emergencyMobileNumber ?? '',
                    'Relationship': _user.emergencyRelationship ?? '',
                  }),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: "Update",
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SupervisorUpdateUserScreen(
                              memberId: _user.memberId),
                        ),
                      );
                      await _fetchUser();
                    },
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
