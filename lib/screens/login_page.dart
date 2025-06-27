import 'package:exfactor/screens/admin/admin_main_screen.dart';
import 'package:exfactor/screens/supervisor/supervisor_main_screen.dart';
import 'package:exfactor/screens/technical/technical_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:exfactor/services/superbase_service.dart';
import 'package:exfactor/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //initialized email, and password
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  Future<void> _loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email');
    if (savedEmail != null) {
      setState(() {
        _emailController.text = savedEmail;
        _rememberMe = true;
      });
    }
  }

  Future<void> _saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_email', email);
  }

  Future<void> _removeSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_email');
  }

  void _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      _showToast("Please enter email address or username");
      return;
    } else if (password.isEmpty) {
      _showToast("Please enter your password");
      return;
    }

    // Static admin login
    if (email == 'admin@exfactor.com' && password == 'admin123') {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return AdminMainScreen();
      }));
      return;
    }

    try {
      final userData = await SupabaseService.getUserByEmail(email);
      if (userData == null) {
        _showToast("User not found in database.");
        return;
      }
      final userModel = UserModel.fromMap(userData);

      if (userModel.role == 'Supervisor') {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return SupervisorMainScreen(user: userModel);
        }));
      } else if (userModel.role == 'Technician') {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return TechnicalMainScreen(user: userModel);
        }));
      } else {
        _showToast("No role found for this user.");
      }
    } catch (e) {
      _showToast("Login failed: \\${e.toString()}");
    }

    if (_rememberMe) {
      await _saveEmail(_emailController.text);
    } else {
      await _removeSavedEmail();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Exfactor.png',
              height: 70,
            ),
            const Text(
              'Lead The Change',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 100),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcome Exfactor Exfsys",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF001F54),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Email or user name',
                  hintStyle: const TextStyle(fontSize: 14),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blueGrey),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  final emailRegex =
                      RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                  if (!emailRegex.hasMatch(val))
                    return 'Enter a valid email address';
                  return null;
                }),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                hintStyle: const TextStyle(fontSize: 14),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                ),
                const Text('Remember Me'),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001F54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Sign in",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Any issues ?',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            TextButton(
              onPressed: () {
                _handleLogin();
              },
              child: const Text(
                'contact the technical team',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF0059FF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}
