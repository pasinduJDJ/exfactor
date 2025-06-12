import 'package:exfactor/screens/admin/admin_home.dart';
import 'package:exfactor/screens/admin/admin_main_screen.dart';
import 'package:exfactor/screens/supervisor/supervisor_main_screen.dart';
import 'package:exfactor/screens/technical/technical_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:exfactor/utils/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //initialized email, and password
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // handle User login logic
  void _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      _showToast("Please enter email address or username");
      return;
    } else if (password.isEmpty) {
      _showToast("Please enter your password");
      return;
    } else if (email == 'admin' || password == 'admin') {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const AdminMainScreen();
      }));
    } else if (email == 'supervisor' || password == 'supervisor') {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const SupervisorMainScreen();
      }));
    } else if (email == 'technical' || password == 'technical') {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const TechnicalMainScreen();
      }));
    } else {
      _showToast("No role found for this user.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Exfactor.png',
                height: 90,
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
              TextField(
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
              ),
              const SizedBox(height: 16),
              TextField(
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
              const SizedBox(height: 24),
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
      ),
    );
  }
}

void _showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: AppTheme.errColor,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}
