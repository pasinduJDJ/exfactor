import 'package:exfactor/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:exfactor/screens/login_page.dart';
import 'package:exfactor/utils/colors.dart';
import '../../widgets/common/custom_button.dart';
import '../../services/superbase_service.dart';
import 'technical_update_user.dart';

class TechnicalProfileScreen extends StatefulWidget {
  final UserModel user;
  const TechnicalProfileScreen({Key? key, required this.user})
      : super(key: key);

  @override
  State<TechnicalProfileScreen> createState() => _TechnicalProfileScreenState();
}

class _TechnicalProfileScreenState extends State<TechnicalProfileScreen> {
  late UserModel _user;
  bool _loading = true;
  String? supervisorName;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _fetchUser();
    _fetchSupervisorName();
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

  Future<void> _fetchSupervisorName() async {
    if (_user.supervisor != null && _user.supervisor!.isNotEmpty) {
      final allUsers = await SupabaseService.getAllUsers();
      final sup = allUsers.firstWhere(
        (u) => u['member_id'].toString() == _user.supervisor,
        orElse: () => {},
      );
      if (sup != null) {
        setState(() {
          supervisorName =
              ((sup['first_name'] ?? '') + ' ' + (sup['last_name'] ?? ''))
                  .trim();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe9ecef),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/it-avatar.webp'),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Personal Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _infoCard({
                    'First Name': _user.firstName ?? '',
                    'Last Name': _user.lastName ?? '',
                    'Date Of Birth': _user.birthday ?? '',
                  }),
                  const SizedBox(height: 16),
                  const Text(
                    "Company Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _infoCard({
                    'Position': _user.position ?? '',
                    'Role': _user.role ?? '',
                    'Email Address': _user.email ?? '',
                    'Mobile Number': _user.mobile ?? '',
                    'Join Date': _user.joinDate ?? '',
                    'Designation Date': _user.designationDate ?? '',
                    'Supervisor': supervisorName ?? '',
                  }),
                  const SizedBox(height: 16),
                  const Text(
                    "Emergency Contact Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _infoCard({
                    'Name': _user.emergencyName ?? '',
                    'Contact Number': _user.emergencyMobileNumber ?? '',
                    'Relationship': _user.emergencyRelationship ?? '',
                  }),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: "Update",
                    onPressed: () async {
                      print(
                          'Navigating to update screen with memberId: ${_user.memberId}');
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TechnicalUpdateUserScreen(
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
