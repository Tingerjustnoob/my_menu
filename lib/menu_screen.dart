import 'package:flutter/material.dart';

import 'items_detail.dart';
import 'cart_screen.dart';
import 'store_contact.dart';

import 'items.dart';

const _address = '嘉義縣民雄鄉三興村大學路一段423號';

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final List<String> _tabs;
  final List<CartItem> _cart = [];

  Future<void> _addToCart(Map<String, dynamic> item, String category) async {
    final hasExtras = MenuData.eggAndCheeseCategories.contains(category);
    final eggPrice = hasExtras
        ? (item['noExtraEgg'] == true ? null : 10)
        : item['eggPrice'] as int?;
    final cheesePrice = hasExtras && item['noExtraCheese'] != true ? 10 : null;
    final selection = await showCustomDialog(
      context,
      item,
      eggPrice: eggPrice,
      cheesePrice: cheesePrice,
      breadOptions: switch (category) {
        '經典麵包／貝果系列' => ['歐式招牌堡', '丹麥漢堡', '貝果'],
        '漢堡／湯種吐司系列' => ['漢堡', '湯種吐司'],
        _ => null,
      },
      drinks: category == '套餐系列' || category == '早午餐系列'
          ? MenuData.categories['飲料系列']
          : null,
      choices: switch (category) {
        '烤土司系列' => ['薄片', '湯種厚片', '貝果'],
        '蔬菜沙拉系列' => ['和風醬', '千島醬', '優格醬', '蜂蜜芥末醬'],
        '飲料系列' => ['中杯', '大杯'],
        _ => null,
      },
      choiceLabel: switch (category) {
        '烤土司系列' => '請選擇種類',
        '蔬菜沙拉系列' => '請選擇醬料',
        '飲料系列' => '請選擇大小',
        _ => null,
      },
      choicePrices: switch (category) {
        '烤土司系列' => {'薄片': 15, '湯種厚片': 20, '貝果': 30},
        '飲料系列' => {'中杯': item['price'] as int, '大杯': item['largePrice'] as int},
        _ => null,
      },
      standaloneDrink: category == '飲料系列',
    );
    if (!mounted || selection == null) return;
    final name =
        '${item['name']}${selection.bread == null ? '' : '（${selection.bread}）'}${selection.drink == null ? '' : '（${selection.drink}）'}${selection.option == null ? '' : '（${selection.option}）'}${selection.temperature == null ? '' : '（${selection.temperature}）'}';
    final price =
        (item['price'] as int) +
        (selection.addEgg ? eggPrice! : 0) +
        (selection.addCheese ? cheesePrice! : 0) +
        selection.drinkCharge +
        selection.optionCharge;
    setState(() {
      final index = _cart.indexWhere(
        (entry) =>
            entry.name == name &&
            entry.addEgg == selection.addEgg &&
            entry.addCheese == selection.addCheese &&
            entry.isDrink == (category == '飲料系列') &&
            entry.unitPrice == price,
      );
      if (index == -1) {
        _cart.add(
          CartItem(
            name: name,
            unitPrice: price,
            addEgg: selection.addEgg,
            addCheese: selection.addCheese,
            isDrink: category == '飲料系列',
          ),
        );
      } else {
        _cart[index].quantity++;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('已加入購物車'), duration: Duration(seconds: 1)),
    );
  }

  Future<void> _openCart() async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('訂餐方式說明'),
          content: const SingleChildScrollView(
            child: Text(
              '您可以將想吃的餐點加入購物車，查看餐點明細與總金額。'
              '本網站無法線上結帳或送出訂單，請撥打 05-272-3486 電話訂餐。\n\n'
              '營業時間：\n'
              '星期一：06:00～14:00\n'
              '星期二：06:00～14:00\n'
              '星期三：休息\n'
              '星期四：06:00～14:00\n'
              '星期五：06:00～14:00\n'
              '星期六：06:00～14:00\n'
              '星期日：06:00～14:00',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('我知道了'),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 600;
    final contactInfo = Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 4,
      children: [
        InkWell(
          onTap: () {
            const url =
                'https://www.google.com.tw/maps/place/'
                '%E9%BA%A5%E9%A6%99%E5%A0%A1/'
                '@23.5589065,120.4693861,20.83z/'
                'data=!4m6!3m5!1s0x346ebf52f6225ba1:0xf4c925ae58323615'
                '!8m2!3d23.5587745!4d120.4696578!16s%2Fg%2F11tbk35z4c'
                '?entry=ttu&g_ep=EgoyMDI2MTEwMi4wIKXMDSoASAFQAw%3D%3D';
            openStoreLink(url);
          },
          child: Text(
            '地址：$_address',
            softWrap: true,
            overflow: TextOverflow.visible,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(decoration: TextDecoration.underline),
          ),
        ),
        InkWell(
          onTap: callStore,
          child: Text(
            '電話：05-272-3486',
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: isNarrow
            ? MediaQuery.textScalerOf(context).scale(145)
            : MediaQuery.textScalerOf(context).scale(100),
        title: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'web/icons/Icon-192.png',
                  width: 48,
                  height: 48,
                  excludeFromSemantics: true,
                ),
                const Text('麥香堡'),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(child: contactInfo),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _openCart,
            tooltip:
                '購物車（${_cart.fold<int>(0, (sum, item) => sum + item.quantity)} 件）',
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          PopupMenuButton<ThemeMode>(
            tooltip: '選擇顯示模式',
            initialValue: widget.themeMode,
            onSelected: widget.onThemeModeChanged,
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            itemBuilder: (context) => [
              CheckedPopupMenuItem(
                value: ThemeMode.system,
                checked: widget.themeMode == ThemeMode.system,
                child: const Text('跟隨系統'),
              ),
              CheckedPopupMenuItem(
                value: ThemeMode.light,
                checked: widget.themeMode == ThemeMode.light,
                child: const Text('淺色模式'),
              ),
              CheckedPopupMenuItem(
                value: ThemeMode.dark,
                checked: widget.themeMode == ThemeMode.dark,
                child: const Text('深色模式'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                for (final social in [
                  (name: 'Facebook', icon: Icons.facebook),
                  (name: 'Instagram', icon: Icons.camera_alt_outlined),
                  (name: 'LINE', icon: Icons.chat_bubble_outline),
                ])
                  Tooltip(
                    message: '${social.name} 尚未設定連結',
                    child: OutlinedButton.icon(
                      onPressed: null,
                      icon: Icon(social.icon),
                      label: Text(social.name),
                    ),
                  ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: _tabs.map((category) => Tab(text: category)).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabs.map((category) {
                final categoryItems = MenuData.categories[category] ?? [];
                final items = category == '飲料系列'
                    ? categoryItems
                          .where(
                            (item) => (item['name'] as String).endsWith('（中杯）'),
                          )
                          .map((item) {
                            final name = (item['name'] as String).replaceFirst(
                              '（中杯）',
                              '',
                            );
                            final large = categoryItems.firstWhere(
                              (entry) => entry['name'] == '$name（大杯）',
                            );
                            return {
                              ...item,
                              'name': name,
                              'largePrice': large['price'],
                            };
                          })
                          .toList()
                    : categoryItems;
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
                      onTap: () => _addToCart(item, category),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // 讓內容垂直居中對齊
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
                              '\$${item['price']}${category == '烤土司系列' || category == '飲料系列' ? ' 起' : ''}',
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
          ),
        ],
      ),
    );
  }
}
