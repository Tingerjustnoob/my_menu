import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'store_contact.dart';

class CartItem {
  CartItem({
    required this.name,
    required this.unitPrice,
    required this.addEgg,
    required this.addCheese,
    required this.isDrink,
  });

  final String name;
  final int unitPrice;
  final bool addEgg;
  final bool addCheese;
  final bool isDrink;
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
                            final spokenLines = widget.items.map((item) {
                              final name = item.name
                                  .replaceAll(RegExp(r'[（）()]'), ' ')
                                  .replaceAll('・', ' ')
                                  .replaceAll(RegExp(r'\s+'), ' ')
                                  .trim();
                              return '${item.quantity} ${item.isDrink ? '杯' : '份'} $name${item.extras.isEmpty ? '' : '，${item.extras}'}';
                            }).toList();
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => OrderSummaryScreen(
                                  lines: summary,
                                  total: total,
                                  spokenLines: spokenLines,
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
    required this.spokenLines,
  });

  final List<String> lines;
  final int total;
  final List<String> spokenLines;

  @override
  Widget build(BuildContext context) {
    final orderText = '您好，我想要訂餐。\n${spokenLines.join('，\n')}。\n謝謝。';
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
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  content: SingleChildScrollView(
                    child: SelectableText(
                      orderText,
                      style: Theme.of(dialogContext).textTheme.bodyLarge,
                    ),
                  ),
                  actions: [
                    TextButton.icon(
                      onPressed: () async {
                        try {
                          await Clipboard.setData(ClipboardData(text: orderText));
                          if (!dialogContext.mounted) return;
                          ScaffoldMessenger.of(dialogContext).showSnackBar(
                            const SnackBar(content: Text('已複製訂餐內容')),
                          );
                        } catch (_) {
                          if (!dialogContext.mounted) return;
                          ScaffoldMessenger.of(dialogContext).showSnackBar(
                            const SnackBar(content: Text('無法複製，請手動選取文字')),
                          );
                        }
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text('複製'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text('關閉'),
                    ),
                  ],
                ),
              );
              callStore();
            },
            icon: const Icon(Icons.phone),
            label: const Text('打電話訂餐'),
          ),
        ],
      ),
    );
  }
}
