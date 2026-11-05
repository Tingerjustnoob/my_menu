import 'package:flutter/material.dart';

import 'items_detail.dart';
import 'cart_screen.dart';

import 'items.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final List<String> _tabs;
  final List<CartItem> _cart = [];

  Future<void> _addToCart(Map<String, dynamic> item) async {
    final addEgg = await showCustomDialog(context, item);
    if (!mounted || addEgg == null) return;
    final name = item['name'] as String;
    final price =
        (item['price'] as int) + (addEgg ? (item['eggPrice'] as int) : 0);
    setState(() {
      final index = _cart.indexWhere(
        (entry) =>
            entry.name == name &&
            entry.addEgg == addEgg &&
            entry.unitPrice == price,
      );
      if (index == -1) {
        _cart.add(CartItem(name: name, unitPrice: price, addEgg: addEgg));
      } else {
        _cart[index].quantity++;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('已加入購物車'), duration: Duration(seconds: 1)),
    );
  }

  Future<void> _openCart() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => CartScreen(items: _cart)));
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabs = MenuData.categories.keys.toList();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('麥香堡菜單'),
        actions: [
          IconButton(
            onPressed: _openCart,
            tooltip:
                '購物車（${_cart.fold<int>(0, (sum, item) => sum + item.quantity)} 件）',
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          IconButton(
            onPressed: widget.onToggleTheme,
            tooltip: widget.isDarkMode ? '切換明亮模式' : '切換夜間模式',
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: _tabs.map((category) => Tab(text: category)).toList(),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((category) {
          final items = MenuData.categories[category] ?? [];
          final note = MenuData.categoryNotes[category];

          if (items.isEmpty) {
            return const Center(child: Text('目前沒有品項'));
          }

          return ListView.builder(
            itemCount: items.length + (note == null ? 0 : 1),
            itemBuilder: (context, index) {
              if (note != null && index == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Text(
                    '備註：$note',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }
              final item = items[index - (note == null ? 0 : 1)];

              return InkWell(
                onTap: () => _addToCart(item),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // 讓內容垂直居中對齊
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          item['image'],
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: Text(
                          item['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      Text(
                        '\$${item['price']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
