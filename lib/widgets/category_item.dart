import 'package:flutter/material.dart';

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({super.key});

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
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

          Expanded(
            child: Material(
              elevation: 5,
              color: Color(0xffffffff),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: GridView.count(
                crossAxisCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
                padding: const EdgeInsets.all(16),
                children: [
                  _CategoryItem(
                    icon: Icons.home,
                    label: "HouseHold",
                    onTap: () {},
                  ),
                  _CategoryItem(
                    icon: Icons.shopping_cart,
                    label: "Grocery",
                    onTap: () {},
                  ),
                  _CategoryItem(
                    icon: Icons.local_bar,
                    label: "Liquor",
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(context, "/viewall");
                      });
                    },
                  ),
                  _CategoryItem(
                    icon: Icons.fastfood,
                    label: "Chilled",
                    onTap: () {},
                  ),
                  _CategoryItem(
                    icon: Icons.local_bar,
                    // label: "Chilled",
                    onTap: () {},
                  ),
                  _CategoryItem(
                    icon: Icons.fastfood,
                    // label: "Chilled",
                    onTap: () {},
                  ),
                  _CategoryItem(
                    icon: Icons.fastfood,
                    // label: "Chilled",
                    onTap: () {},
                  ),
                  _CategoryItem(
                    icon: Icons.fastfood,
                    // label: "Chilled",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _CategoryItem({required this.icon, this.label = "", this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 1.5),
            ),
            child: Center(child: Icon(icon, size: 20, color: Colors.green)),
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
