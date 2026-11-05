import 'package:flutter/material.dart';

import 'store_contact.dart';

class CartItem {
  CartItem({
    required this.name,
    required this.unitPrice,
    required this.addEgg,
    required this.addCheese,
  });

  final String name;
  final int unitPrice;
  final bool addEgg;
  final bool addCheese;
  String get extras => [if (addEgg) '加蛋', if (addCheese) '加芝士'].join('、');
  int quantity = 1;
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.items});

  final List<CartItem> items;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int get _total =>
      widget.items.fold(0, (sum, item) => sum + item.unitPrice * item.quantity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('購物車'),
        actions: [
          IconButton(
            tooltip: '關閉購物車',
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: widget.items.isEmpty
          ? const Center(child: Text('購物車目前沒有餐點'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(
                          '${item.extras.isNotEmpty ? '${item.extras}・' : ''}單價 \$${item.unitPrice}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: '減少 ${item.name}',
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => setState(() {
                                if (item.quantity == 1) {
                                  widget.items.removeAt(index);
                                } else {
                                  item.quantity--;
                                }
                              }),
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              tooltip: '增加 ${item.name}',
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => setState(() => item.quantity++),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '總金額：\$$_total',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () {
                            final summary = widget.items
                                .map(
                                  (item) =>
                                      '${item.name}${item.extras.isNotEmpty ? '（${item.extras}）' : ''} × ${item.quantity}　\$${item.unitPrice * item.quantity}',
                                )
                                .toList();
                            final total = _total;
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => OrderSummaryScreen(
                                  lines: summary,
                                  total: total,
                                ),
                              ),
                            );
                          },
                          child: const Text('查看餐點明細'),
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

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({
    super.key,
    required this.lines,
    required this.total,
  });

  final List<String> lines;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('餐點明細')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final line in lines)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(line, style: Theme.of(context).textTheme.titleLarge),
            ),
          const Divider(),
          Text('總金額：\$$total', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          const Text('此畫面僅供確認，不會付款或送出訂單。'),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: callStore,
            icon: const Icon(Icons.phone),
            label: const Text('打電話訂餐'),
          ),
        ],
      ),
    );
  }
}
