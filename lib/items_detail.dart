import 'package:flutter/material.dart';

Future<({bool addEgg, bool addCheese})?> showCustomDialog(
  BuildContext context,
  Map<String, dynamic> item, {
  int? eggPrice,
  int? cheesePrice,
}) {
  bool addEgg = false;
  bool addCheese = false;
  return showDialog<({bool addEgg, bool addCheese})>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          // 圓角
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          constraints: const BoxConstraints(maxWidth: 480),
          child: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 1. 餐點圖片
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Image.asset(item['image'], fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 2. 餐點名稱與價格
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '\$${(item['price'] as int) + (addEgg ? eggPrice! : 0) + (addCheese ? cheesePrice! : 0)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (eggPrice != null)
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('加蛋 (+\$$eggPrice)'),
                        value: addEgg,
                        onChanged: (value) {
                          setDialogState(() => addEgg = value ?? false);
                        },
                      ),
                    if (cheesePrice != null)
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('加芝士 (+\$$cheesePrice)'),
                        value: addCheese,
                        onChanged: (value) {
                          setDialogState(() => addCheese = value ?? false);
                        },
                      ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () =>
                          Navigator.of(context)
                              .pop((addEgg: addEgg, addCheese: addCheese)),
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('加入購物車'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
