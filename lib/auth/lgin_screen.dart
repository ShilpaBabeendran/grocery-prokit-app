import 'package:flutter/material.dart';
import 'package:grocery_app/auth/auth_service.dart';
import 'package:grocery_app/utils/flutter_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassworVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 116, 216, 170),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Welcome Back",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Text(
                  "Grocery Prokit",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Text(
                  'LogIn',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                ),
              ),
              SizedBox(height: 10),

              //email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Email'),
                  hintText: "Enter your email",
                ),
              ),

              SizedBox(height: 10),

              //pass
              TextFormField(
                controller: passwordController,
                obscureText: !isPassworVisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Password'),
                  hintText: "Enter your password",

                  suffixIcon: IconButton(
                    icon: Icon(
                      isPassworVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPassworVisible = !isPassworVisible;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  onPressed: () async {
                    final result = await AuthServiceHelper.loginWithEmail(
                      emailController.text,
                      passwordController.text,
                    );
                    if (mounted) {
                      if (result == "Login Successful") {
                        if (mounted) {
                          await Message.show(message: "Login Successful");
                          if (mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              "/home",
                              (route) => false,
                            );
                          }
                        }
                      } else {
                        if (mounted) {
                          await Message.show(message: "Login Error: $result");
                        }
                      }
                    }
                  },
                  child: Text('LogIn'),
                ),
              ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Need an Account?',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/signup");
                    },
                    child: Text('Create Account'),
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
