import 'package:flutter/material.dart';
import 'items_detail.dart';
import 'items.dart'; 

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final List<String> _tabs;

  // 用來儲存購物車內的餐點資訊
  final List<Map<String, dynamic>> _cartItems = [];

  // 計算總金額
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
        title: const Text('早餐菜單'),
        automaticallyImplyLeading: false, 
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: _tabs.map((category) => Tab(text: category)).toList(),
          ),
        ),
      ),
      body: Stack(
        children: [
          // 底層：餐點菜單內容
          TabBarView(
            controller: _tabController,
            children: _tabs.map((category) {
              final items = MenuData.categories[category] ?? [];
              
              // 💡 關鍵修正：這裡原本有 imageCache.clear(); 已經徹底移除！
              // 移除後圖片快取運作正常，列表資料就不會再消失變白了。

              if (items.isEmpty) {
                return const Center(child: Text('目前沒有品項'));
              }

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  
                  return InkWell(
                    onTap: () async {
                      // 呼叫對話框並等待返回資料
                      final Map<String, dynamic>? selectedItem = await showCustomDialog(context, item);
                      
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
                            content: Text('已將 ${selectedItem['name']} 放入購物車！'),
                            duration: const Duration(milliseconds: 1000),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center, 
                        children: [
                          const Icon(Icons.fastfood, color: Colors.orange),
                          const SizedBox(width: 12),
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
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '\$${item['price']}',
                            style: const TextStyle(
                              color: Colors.red, 
                              fontSize: 18, 
                              fontWeight: FontWeight.bold
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
          
          // 上層：絕對定位的「右中半圓形購物車按鈕」
          Positioned(
            right: 0, 
            top: MediaQuery.of(context).size.height / 2 - 30, 
            child: Builder(
              builder: (scaffoldContext) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(scaffoldContext).openEndDrawer();
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.amber.shade700, 
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),   
                        bottomLeft: Radius.circular(30), 
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 8,
                          offset: const Offset(-2, 3), 
                        ),
                      ],
                    ),
                    child: const Material(
                      color: Colors.transparent,
                      child: Icon(
                        Icons.shopping_basket,
                        color: Colors.black,
                        size: 26,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      
      // 右側邊欄側滑選單
      endDrawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text(
                  '購物車 / 訂單紀錄',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            Expanded(
              child: _cartItems.isEmpty
                  ? const Center(child: Text('購物車空空如也 🛒'))
                  : ListView.builder(
                      itemCount: _cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = _cartItems[index];
                        return ListTile(
                          leading: const Icon(Icons.check_circle, color: Colors.green),
                          title: Text(cartItem['name']),
                          trailing: Text(
                            '\$${cartItem['price']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '總計：',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$$_totalPrice',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
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
