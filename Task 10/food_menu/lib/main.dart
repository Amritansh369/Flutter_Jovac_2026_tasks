import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListView Example',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Roboto',
      ),
      home: FoodListPage(),
    );
  }
}

class FoodItem {
  final String name;
  final String price;
  final String emoji;
  final Color bgColor;

  FoodItem({
    required this.name,
    required this.price,
    required this.emoji,
    required this.bgColor,
  });
}

class FoodListPage extends StatelessWidget {
  FoodListPage({super.key});

  final List<FoodItem> items = [
    FoodItem(name: 'Cheese Burger', price: '₹149', emoji: '🍔', bgColor: const Color(0xFFFFE0B2)),
    FoodItem(name: 'Veg Pizza', price: '₹199', emoji: '🍕', bgColor: const Color(0xFFFFCDD2)),
    FoodItem(name: 'Pasta', price: '₹179', emoji: '🍝', bgColor: const Color(0xFFFFF9C4)),
    FoodItem(name: 'Sandwich', price: '₹99', emoji: '🥪', bgColor: const Color(0xFFD7CCC8)),
    FoodItem(name: 'Cold Drink', price: '₹49', emoji: '🥤', bgColor: const Color(0xFFB3E5FC)),
    FoodItem(name: 'Ice Cream', price: '₹69', emoji: '🍦', bgColor: const Color(0xFFF8BBD0)),
    FoodItem(name: 'Chocolate Cake', price: '₹149', emoji: '🍰', bgColor: const Color(0xFFD7CCC8)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 0,
        title: const Text(
          'ListView Example',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return FoodListTile(item: item);
        },
      ),
    );
  }
}

class FoodListTile extends StatelessWidget {
  final FoodItem item;

  const FoodListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Circular image/emoji avatar
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: item.bgColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              item.emoji,
              style: const TextStyle(fontSize: 28),
            ),
          ),
          const SizedBox(width: 14),
          // Name and price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.price,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          // Cart icon
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.name} added to cart'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Color(0xFF4CAF50),
            ),
          ),
        ],
      ),
    );
  }
}