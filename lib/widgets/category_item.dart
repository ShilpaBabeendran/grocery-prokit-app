import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "All Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              _CategoryItem(icon: Icons.home, label: "HouseHold"),
              _CategoryItem(icon: Icons.shopping_cart, label: "Grocery"),
              _CategoryItem(icon: Icons.local_bar, label: "Liquor"),
              _CategoryItem(icon: Icons.fastfood, label: "Chilled"),
              _CategoryItem(icon: Icons.local_bar),
              _CategoryItem(icon: Icons.fastfood),
              _CategoryItem(icon: Icons.fastfood),
              _CategoryItem(icon: Icons.fastfood),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CategoryItem({required this.icon, this.label = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 1.5),
          ),
          child: Center(child: Icon(icon, size: 22, color: Colors.green)),
        ),
        if (label.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
