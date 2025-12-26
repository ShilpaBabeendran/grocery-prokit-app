import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 39, 173, 66),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 10),
                Text(
                  "Welcome",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  "Grocery Prokit",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(height: 10),
                Text(
                  "Next your door",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, "/home");
            },
          ),

          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Order History"),
            onTap: () {
              Navigator.pushNamed(context, "/orderhistory");
            },
          ),

          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Go to Cart"),
            onTap: () {
              Navigator.pushNamed(context, "/cart");
            },
          ),
        ],
      ),
    );
  }
}
