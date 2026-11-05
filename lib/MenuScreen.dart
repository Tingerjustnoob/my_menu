
import 'package:flutter/material.dart';
import 'items_detail.dart';
import 'items.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final List<String> _tabs;

  // 購物車資料
  final List<Map<String, dynamic>> _cartItems = [];

  // 計算購物車總金額
  int get _totalPrice {
    int total = 0;

    for (var item in _cartItems) {
      final price = item['price'];

      if (price is int) {
        total += price;
      } else if (price is String) {
        total += int.tryParse(price) ?? 0;
      }
    }

    return total;
  }

  @override
  void initState() {
    super.initState();

    _tabs = MenuData.categories.keys.toList();

    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
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
        title: const Text('早餐菜單'),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs
              .map((category) => Tab(text: category))
              .toList(),
        ),
      ),

      // =====================================
      // 主畫面
      // =====================================
      body: Stack(
        children: [
          // 第一層：餐點列表
          TabBarView(
            controller: _tabController,
            children: _tabs.map((category) {
              final items = MenuData.categories[category] ?? [];

              if (items.isEmpty) {
                return const Center(
                  child: Text('目前沒有品項'),
                );
              }

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return InkWell(
                    onTap: () async {
                      final Map<String, dynamic>? selectedItem =
                          await showCustomDialog(context, item);

                      if (!mounted) return;

                      if (selectedItem != null) {
                        setState(() {
                          _cartItems.add({
                            'name': selectedItem['name'],
                            'price': selectedItem['price'],
                            'image': selectedItem['image'],
                          });
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '已將 ${selectedItem['name']} 放入購物車！',
                            ),
                            duration: const Duration(
                              milliseconds: 1000,
                            ),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.fastfood,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 12),

                          // 餐點圖片
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item['image'],
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 16),

                          // 餐點名稱
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

                          // 餐點價格
                          Text(
                            '\$${item['price']}',
                            style: const TextStyle(
                              color: Colors.red,
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

          // =====================================
          // 第二層：右側中央購物車按鈕
          // =====================================
          Align(
            alignment: Alignment.centerRight,
            child: Builder(
              builder: (scaffoldContext) {
                return Container(
                  width: 60,
                  height: 60,
                  
                  child: Material(
                    color: Colors.amber.shade700,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        Scaffold.of(scaffoldContext).openEndDrawer();
                      },
                      child: const Center(
                        child: CustomPaint(
                          size: Size(32, 32),
                          painter: _ShoppingCartPainter(),
                             ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // =====================================
      // 右側購物車 Drawer
      // =====================================
      endDrawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  '購物車 / 訂單紀錄',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            // 購物車商品列表
            Expanded(
              child: _cartItems.isEmpty
                  ? const Center(
                      child: Text('購物車空空如也 🛒'),
                    )
                  : ListView.builder(
                      itemCount: _cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = _cartItems[index];

                        return ListTile(
                          leading: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          title: Text(
                            cartItem['name'].toString(),
                          ),
                          trailing: Text(
                            '\$${cartItem['price']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onLongPress: () {
                            setState(() {
                              _cartItems.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
            ),

            const Divider(height: 1),

            // 總金額
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '總計：',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$$_totalPrice',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _ShoppingCartPainter extends CustomPainter {
  const _ShoppingCartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final basket = Path()
      ..moveTo(size.width * 0.12, size.height * 0.18)
      ..lineTo(size.width * 0.22, size.height * 0.18)
      ..lineTo(size.width * 0.34, size.height * 0.67)
      ..lineTo(size.width * 0.79, size.height * 0.67)
      ..lineTo(size.width * 0.91, size.height * 0.32)
      ..lineTo(size.width * 0.28, size.height * 0.32);
    canvas.drawPath(basket, paint);

    canvas.drawLine(
      Offset(size.width * 0.39, size.height * 0.77),
      Offset(size.width * 0.77, size.height * 0.77),
      paint,
    );

    final wheelPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width * 0.43, size.height * 0.88),
      size.width * 0.055,
      wheelPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.74, size.height * 0.88),
      size.width * 0.055,
      wheelPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ShoppingCartPainter oldDelegate) => false;
}
