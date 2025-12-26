import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final currentPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    currentPass.dispose();
    newPass.dispose();
    confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(color: Color(0xffffffff)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: currentPass,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Current Password"),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: newPass,
              obscureText: true,
              decoration: const InputDecoration(labelText: "New Password"),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: confirmPass,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm New Password",
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _changePassword,
                child: isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text("Update Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changePassword() async {
    if (currentPass.text.isEmpty ||
        newPass.text.isEmpty ||
        confirmPass.text.isEmpty) {
      _showMsg("All fields are required");
      return;
    }

    if (newPass.text.length < 6) {
      _showMsg("Password must be at least 6 characters");
      return;
    }

    if (newPass.text != confirmPass.text) {
      _showMsg("Passwords do not match");
      return;
    }

    setState(() => isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null || user.email == null) {
        _showMsg("User not logged in");
        return;
      }

      // 🔑 Re-authenticate user
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPass.text,
      );

      await user.reauthenticateWithCredential(credential);

      // 🔐 Update password
      await user.updatePassword(newPass.text);

      // 🚪 Sign out user after password change
      await FirebaseAuth.instance.signOut();

      _showMsg("Password updated. Please login again.");

      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      _showMsg(e.message ?? "Something went wrong");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
