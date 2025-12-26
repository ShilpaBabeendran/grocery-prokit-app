import 'package:flutter/material.dart';
import 'package:grocery_app/provider/product_provider.dart';
import 'package:grocery_app/widgets/menu_drawer.dart';
import 'package:grocery_app/widgets/product_cart.dart';
import 'package:grocery_app/widgets/top_navigation_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductProvider>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    //to expand top navigation bar

    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xffffffff)),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text("Store", style: TextStyle(color: Color(0xffffffff))),
        actions: const [
          Icon(Icons.search, color: Color(0xffffffff)),
          SizedBox(width: 12),
          Icon(Icons.notifications, color: Color(0xffffffff)),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopNavigationBar(),

            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Grocery Deals",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/viewall");
                        },
                        child: const Text(
                          "View all >",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// HORIZONTAL LIST
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (_, i) => ProductCard(p: products[i]),
                    ),
                  ),

                  const SizedBox(height: 12),

                  //repeating the same
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Grocery Deals",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/viewall");
                        },
                        child: const Text(
                          "View all >",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// HORIZONTAL LIST
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (_, i) => ProductCard(p: products[i]),
                    ),
                  ),

                  const SizedBox(height: 12),

                  //repeating the same
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Grocery Deals",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/viewall");
                        },
                        child: const Text(
                          "View all >",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// HORIZONTAL LIST
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (_, i) => ProductCard(p: products[i]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
