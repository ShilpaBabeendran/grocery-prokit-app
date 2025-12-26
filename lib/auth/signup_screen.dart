import 'package:flutter/material.dart';
import 'package:grocery_app/auth/auth_service.dart';
import 'package:grocery_app/utils/flutter_toast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //controllers dispose
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Center(
                child: Text(
                  'SignUp',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
              ),

              const SizedBox(height: 10),

              // email error
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: "Enter your email",
                ),
              ),

              const SizedBox(height: 10),

              // PASSWORD FIELD
              TextFormField(
                controller: passwordController,
                obscureText: true, //hide pass
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: "Enter your password",
                ),
              ),

              const SizedBox(height: 10),

              // signup
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  onPressed: () async {
                    // validation
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      Message.show(message: "All fields are required");
                      return;
                    }

                    final result = await AuthServiceHelper.createAccount(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                    if (mounted) {
                      if (result == "Account Created") {
                        Message.show(message: "Account Created");
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/home",
                          (route) => false,
                        );
                      } else {
                        Message.show(message: "Error: $result");
                      }
                    }
                  },
                  child: const Text('SignUp'),
                ),
              ),

              const SizedBox(height: 10),

              // login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('LogIn'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
