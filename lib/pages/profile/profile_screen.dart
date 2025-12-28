import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocery_app/widgets/top_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:grocery_app/provider/theme_provider.dart';
import 'package:grocery_app/pages/profile/change_password_sceen.dart';
import 'package:grocery_app/pages/profile/delivery_address.dart';
import 'package:grocery_app/pages/profile/payment_method_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _pickAndUploadImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    
    final uid = user.uid;
    final file = File(picked.path);

    final ref = FirebaseStorage.instance
        .ref()
        .child("profile_images")
        .child("$uid.jpg");

    await ref.putFile(file);

    final imageUrl = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "profileImage": imageUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final user = FirebaseAuth.instance.currentUser;
    
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF00C853),
          title: const Text("Store"),
        ),
        body: const Center(
          child: Text("Please log in to view profile"),
        ),
      );
    }
    
    final uid = user.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00C853),
        title: const Text("Store"),
      ),
      body: Column(
        children: [
          TopNavigationBar(),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final data = snapshot.data!.data() as Map<String, dynamic>?;

                final name = data?['name'] ?? "User";
                final phone = data?['phone'] ?? "";
                final profileImage = data?['profileImage'];

                return ListView(
                  children: [
                    /// PROFILE HEADER
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => _pickAndUploadImage(context),
                            child: CircleAvatar(
                              radius: 36,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage: profileImage != null
                                  ? NetworkImage(profileImage)
                                  : null,
                              child: profileImage == null
                                  ? const Icon(Icons.camera_alt, size: 28)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(user.email ?? ""),
                              Text(phone),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Divider(),

                    /// DARK MODE
                    _item(
                      icon: Icons.sunny_snowing,
                      color: const Color.fromARGB(255, 26, 64, 190),
                      title: "Dark Mode",
                      trailing: Switch(
                        value: theme.isDark,
                        onChanged: theme.toggle,
                      ),
                    ),

                    _item(
                      icon: Icons.person_2_outlined,
                      color: const Color.fromARGB(255, 58, 39, 115),
                      title: "Recipient Details",
                      onTap: () {},
                      //  () => Navigator.push(
                      // context,
                      // MaterialPageRoute(
                      // builder: (_) => const PaymentMethodsScreen()),
                      // ),
                    ),

                    _item(
                      icon: Icons.delivery_dining_sharp,
                      color: Colors.orange,
                      title: "Delivery Address",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DeliveryAddressScreen(),
                        ),
                      ),
                    ),

                    _item(
                      icon: Icons.currency_exchange_outlined,
                      color: const Color.fromARGB(252, 203, 12, 12),
                      title: "Payment Methods",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PaymentMethodsScreen(),
                        ),
                      ),
                    ),

                    _item(
                      icon: Icons.lock,
                      color: const Color.fromARGB(255, 192, 16, 77),
                      title: "Change Password",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChangePasswordPage(),
                        ),
                      ),
                    ),

                    _item(
                      icon: Icons.logout,
                      color: const Color.fromARGB(255, 160, 11, 63),
                      title: "Logout",
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.pushNamed(context, "/login");
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _item({
    required IconData icon,
    required Color color,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
