import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/auth/lgin_screen.dart';

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
              child: OutlinedButton(
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
                    : const Text("Update Password", style: TextStyle(color: Color(0xFF00C569)),),
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

      // Re-authenticate user
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPass.text,
      );

      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPass.text);

      //  Sign out user after password change
      await FirebaseAuth.instance.signOut();

      _showMsg("Password updated. Please login again.");

      if (mounted) {
        Navigator.pushNamed(context, "/login");
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

  // Future<void> _newPassword() async {
  //   setState(() => isLoading = true);

  //   try {
  //     final user = FirebaseAuth.instance.currentUser;

  //     if (user == null) {
  //       throw Exception("User not logged in");
  //     }

  //     // 🔐 Update password
  //     await user.updatePassword(newPass.text.trim());

  //     // 🔄 Optional but recommended
  //     await FirebaseAuth.instance.signOut();

  //     if (mounted) {
  //       Navigator.pushname
  //         // (route) => false,
  //       // );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     String message = "Password update failed";

  //     if (e.code == 'requires-recent-login') {
  //       message = "Please login again to update password";
  //     }

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(message)),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(e.toString())),
  //     );
  //   } finally {
  //     if (mounted) setState(() => isLoading = false);
  //   }
  // }
}
