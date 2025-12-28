import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/category_item.dart';

class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({super.key});

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  bool isCategoryVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// GREEN TOP BAR
        Container(
          height: 70,
          color: const Color(0xFF00C569),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //category
              IconButton(
                icon: const Icon(Icons.category, color: Colors.white),
                onPressed: () {
                  setState(() {
                    isCategoryVisible = !isCategoryVisible;
                  });
                },
              ),

              //shoping bag
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/cart");
                },
                icon: Icon(Icons.shopping_bag, color: Colors.white),
              ),

              //favriete
              IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, "/wishlist");
                  });
                },
                icon: Icon(Icons.favorite, color: Colors.white),
              ),

              //profile
              IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, "/profile");
                  });
                },
                icon: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ),

        /// CATEGORY EXPAND SECTION
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isCategoryVisible ? 260 : 0,
          curve: Curves.easeInOut,
          child: isCategoryVisible ? const CategoryGrid() : null,
        ),
      ],
    );
  }
}
