import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _navigate(BuildContext context, String routeName) async {
  Navigator.pop(context); // close drawer

  await Future.delayed(const Duration(milliseconds: 200));

  Navigator.pushReplacementNamed(context, routeName);
}


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF00C569),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            onTap: () => _navigate(context, "/home"),
          ),

          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Order History"),
            onTap: () => _navigate(context, "/orderhistory"),
          ),

          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Go to Cart"),
            onTap: () => _navigate(context, "/cart"),
          ),
        ],
      ),
    );
  }
}
