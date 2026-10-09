import 'package:flutter/material.dart';
import 'items_detail.dart';

import 'items.dart'; 

class untitled1 extends StatefulWidget {
  const untitled1({super.key});

  @override
  State<untitled1> createState() => _untitled1State();
}

class _untitled1State extends State<untitled1> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final List<String> _tabs;

  @override
  void initState() {
    super.initState();
    // 2. 直接從 MenuData 類別讀取分類的 Key 清單
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: _tabs.map((category) => Tab(text: category)).toList(),
          ),
        )
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((category) {
          // 3. 根據目前的分類，從 MenuData 抓取對應的餐點清單
          final items = MenuData.categories[category] ?? [];
          imageCache.clear(); // 清除圖片快取，避免重複加載舊圖片

          if (items.isEmpty) {
            return const Center(child: Text('目前沒有品項'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              
              // 💡 改用 InkWell + Padding 取代 ListTile，圖片大、排版更自由
              return InkWell(
                onTap: () {
                    showCustomDialog(context, item);
                  // 點擊項目的事件（可留空）
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // 讓內容垂直居中對齊
                    children: [
                      // 1. 左側圖示
                      const Icon(Icons.fastfood, color: Colors.orange),
                      const SizedBox(width: 12),
                      
                      // 2. 放大後的餐點圖片（加上精緻圓角）
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
                      
                      // 4. 右側價格
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
    );
  }
}

