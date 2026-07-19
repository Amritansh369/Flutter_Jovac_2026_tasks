import 'package:flutter/material.dart';
void main() => runApp(const SmartCafeApp());
class SmartCafeApp extends StatelessWidget {
  const SmartCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Café',
      theme: ThemeData(
        primaryColor: const Color(0xFF5B3DF6),
        fontFamily: 'Roboto',
      ),
      home: const SmartCafeScreen(),
    );
  }
}

class SmartCafeScreen extends StatefulWidget {
  const SmartCafeScreen({super.key});

  @override
  State<SmartCafeScreen> createState() => _SmartCafeScreenState();
}

class _SmartCafeScreenState extends State<SmartCafeScreen> {
  static const Color purple = Color(0xFF5B3DF6);

  String _category = 'Burger';
  int _quantity = 1;
  bool _showTodaySpecialBanner = false;
  bool _showOrderSuccess = false;

  final List<String> _categories = ['Burger', 'Pizza', 'Drinks', 'Desserts'];

  void _incrementQty() => setState(() => _quantity++);
  void _decrementQty() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  void _placeOrder() {
    setState(() => _showOrderSuccess = true);
  }

  void _clearSelection() {
    setState(() => _quantity = 1);
  }

  void _handleMenuAction(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(action), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildCategoryDropdown(),
                        const SizedBox(height: 20),
                        _buildSelectedItemSection(),
                        const SizedBox(height: 16),
                        _buildQuantitySelector(),
                        const SizedBox(height: 20),
                        _buildPlaceOrderButton(),
                        const SizedBox(height: 12),
                        _buildSaveForLaterButton(),
                        const SizedBox(height: 12),
                        _buildClearSelectionRow(),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 8),
                        _buildOrderOnIphoneSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // "Today's Special" floating circular badge
            Positioned(
              right: 16,
              top: 260,
              child: GestureDetector(
                onTap: () => setState(() => _showTodaySpecialBanner = true),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: purple,
                    shape: BoxShape.circle,
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_food_beverage, color: Colors.white, size: 18),
                      Text(
                        "Today's\nSpecial",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Today's Special popup banner
            if (_showTodaySpecialBanner) _buildTodaySpecialBanner(),

            // Order placed successfully banner
            if (_showOrderSuccess) _buildOrderSuccessBanner(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: purple,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
          ),
          const Expanded(
            child: Text(
              'Smart Café',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Category',
          style: TextStyle(color: purple, fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: purple.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(24),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _category,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: purple),
              items: _categories.map((c) {
                return DropdownMenuItem(
                  value: c,
                  child: Row(
                    children: [
                      const Text('🍔  '),
                      Text(c),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedItemSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selected Item',
          style: TextStyle(color: purple, fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 90,
                height: 90,
                color: Colors.orange.shade50,
                child: const Icon(Icons.lunch_dining, size: 48, color: Colors.deepOrange),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Veg Burger',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Delicious veg burger with fresh veggies and cheese.',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '₹120',
                    style: TextStyle(
                      color: purple,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: _handleMenuAction,
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'Add Cheese',
                  child: Row(children: [
                    Icon(Icons.local_pizza, color: Colors.orange, size: 18),
                    SizedBox(width: 8),
                    Text('Add Cheese'),
                  ]),
                ),
                PopupMenuItem(
                  value: 'Extra Sauce',
                  child: Row(children: [
                    Icon(Icons.opacity, color: Colors.red, size: 18),
                    SizedBox(width: 8),
                    Text('Extra Sauce'),
                  ]),
                ),
                PopupMenuItem(
                  value: 'View Nutrition',
                  child: Row(children: [
                    Icon(Icons.eco, color: Colors.green, size: 18),
                    SizedBox(width: 8),
                    Text('View Nutrition'),
                  ]),
                ),
                PopupMenuItem(
                  value: 'Share Item',
                  child: Row(children: [
                    Icon(Icons.share, color: Colors.blueGrey, size: 18),
                    SizedBox(width: 8),
                    Text('Share Item'),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quantity',
          style: TextStyle(color: purple, fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _qtyButton(Icons.remove, _decrementQty),
            const SizedBox(width: 20),
            Text('$_quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(width: 20),
            _qtyButton(Icons.add, _incrementQty),
          ],
        ),
      ],
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: purple),
        ),
        child: Icon(icon, color: purple, size: 18),
      ),
    );
  }

  Widget _buildPlaceOrderButton() {
    return ElevatedButton.icon(
      onPressed: _placeOrder,
      icon: const Icon(Icons.shopping_cart, color: Colors.white),
      label: const Text('Place Order'),
      style: ElevatedButton.styleFrom(
        backgroundColor: purple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildSaveForLaterButton() {
    return OutlinedButton.icon(
      onPressed: () => _handleMenuAction('Saved for later'),
      icon: const Icon(Icons.bookmark_border, color: purple),
      label: const Text('Save for Later', style: TextStyle(color: purple)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: purple),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildClearSelectionRow() {
    return Center(
      child: TextButton.icon(
        onPressed: _clearSelection,
        icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
        label: const Text('Clear Selection', style: TextStyle(color: Colors.red)),
      ),
    );
  }

  Widget _buildOrderOnIphoneSection() {
    return Column(
      children: [
        const Text(
          'Order on iPhone Style',
          style: TextStyle(color: purple, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () => _handleMenuAction('Order on iPhone Style tapped'),
          icon: const Icon(Icons.apple, color: Colors.white),
          label: const Text('Order on iPhone Style'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3EC6F0),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildTodaySpecialBanner() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 90,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              const Text('🎉', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Today's Special",
                        style: TextStyle(color: purple, fontWeight: FontWeight.w700)),
                    Text('Veg Burger', style: TextStyle(fontWeight: FontWeight.w600)),
                    Text('₹99', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _showTodaySpecialBanner = false),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSuccessBanner() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: const Color(0xFF4CAF50),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Order Placed Successfully!',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: () => setState(() => _showOrderSuccess = false),
              child: const Text('DISMISS', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}